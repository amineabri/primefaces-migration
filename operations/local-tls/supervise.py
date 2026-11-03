#!/usr/bin/env python3
"""Local acceptance supervisor; not a production service installation."""

import argparse
import datetime
import json
import os
from pathlib import Path
import signal
import subprocess
import time


parser = argparse.ArgumentParser()
parser.add_argument("--interval", type=float, default=3)
parser.add_argument("--startup-grace", type=float, default=120)
parser.add_argument("--max-replacements", type=int, default=3)
args = parser.parse_args()
if args.interval <= 0 or args.startup_grace <= 0 or args.max_replacements < 1:
    parser.error("interval, startup grace and replacement limit must be positive")
if "OPS02_TLS_DIR" not in os.environ:
    parser.error("OPS02_TLS_DIR is required")
compose = ["docker", "compose", "--file", str(Path(__file__).with_name("compose.yml"))]


def event(kind, **data):
    print(json.dumps({
        "at": datetime.datetime.now(datetime.timezone.utc).isoformat(),
        "event": kind, **data,
    }), flush=True)


def run(arguments, required=True):
    try:
        result = subprocess.run(arguments, text=True, capture_output=True, timeout=45)
    except subprocess.TimeoutExpired:
        if required:
            raise
        result = subprocess.CompletedProcess(arguments, 124, "", "Probe timed out")
    if required and result.returncode:
        raise RuntimeError(f"{arguments}: {result.stderr or result.stdout}")
    return result


def gate(ready):
    command = "rm -f /tmp/backend-unready" if ready else "touch /tmp/backend-unready"
    run(compose + ["exec", "-T", "proxy", "sh", "-c", command])


identity = None
started = 0
ever_ready = False
last_ready = None
failures = 0
replacements = 0


def stop(signum, frame):
    raise KeyboardInterrupt


signal.signal(signal.SIGTERM, stop)
signal.signal(signal.SIGINT, stop)
gate(False)
event("supervisor_started", startup_grace=args.startup_grace)
try:
    while True:
        current = run(compose + ["ps", "--all", "--quiet", "eap"]).stdout.strip()
        if not current:
            raise RuntimeError("Managed EAP container is missing")
        if current != identity:
            identity, started = current, time.monotonic()
            ever_ready, failures, last_ready = False, 0, None
            gate(False)
            event("instance_observed", container=identity)
        state = json.loads(run(["docker", "inspect", "--format", "{{json .State}}", identity]).stdout)
        running = state["Running"] and not state["Paused"]
        checks = {}
        for probe in ("startup", "liveness", "readiness"):
            result = run(["docker", "exec", identity, "/opt/server/bin/ops-healthcheck.sh", probe], False) if running else None
            checks[probe] = result is not None and result.returncode == 0
        ready = all(checks.values())
        if ready != last_ready:
            gate(ready)
            event("routing_ready" if ready else "routing_removed", **checks)
            last_ready = ready
        if ready:
            ever_ready = True
        in_grace = not ever_ready and time.monotonic() - started < args.startup_grace
        failed = not checks["liveness"] or not checks["readiness"] or not checks["startup"]
        failures = failures + 1 if failed and not in_grace else 0
        if failed:
            event("probe_failure", count=failures, startup_grace=in_grace, **checks)
        if failures >= 2:
            event("alert_repeated_failures", **checks)
        # A live but unready app is removed and alerted, not blindly restarted.
        if not checks["liveness"] and not in_grace and failures >= 2:
            gate(False)
            if replacements >= args.max_replacements:
                event("alert_replacement_limit", replacements=replacements)
                raise RuntimeError("Replacement limit reached; operator intervention required")
            run(compose + ["up", "--detach", "--no-build", "--no-deps", "--force-recreate", "eap"])
            replacements += 1
            event("immutable_replacement", old_container=identity, replacements=replacements)
        time.sleep(args.interval)
except KeyboardInterrupt:
    event("supervisor_stopped")
finally:
    gate(False)
