# OPS-02 — Production environment acceptance

**Latest update:** 2026-10-28 UTC. **Final production readiness: OPERATIONALLY INCOMPLETE.**

**LOCAL PRODUCTION-TOPOLOGY TLS VALIDATION: PASS** at `https://localhost:8443`, following explicit user authorization for a local development-certificate exercise. Exact promoted image unchanged,27/27 focused checks across Chromium/Firefox/WebKit PASS, plus local readiness-routing/alerts/immutable replacement and maintenance-gated cutover PASS. Previous-production rollback remains **ROLLBACK BLOCKED**. This is **not LIVE PRODUCTION TLS VALIDATION**. See the latest local addendum below; the initial unreachable-endpoint attempt is preserved as historical evidence.

**Application migration: COMPLETE. EAP acceptance: PASS. Operational profile: VALIDATED.** No application source, validated WAR, EAP image content or EAP runtime configuration was changed. No source rebuild or full migration-harness replay was performed. Subsequent authorized local proxy/supervisor files and disposable workload lifecycle changes are documented below. OPS-01 and earlier migration evidence remain preserved.

## Image promotion — PASS

The user explicitly approved `ghcr.io/amineabri/primefaces-migration` as the destination. The existing validated local image was tagged and pushed, without rebuilding.

| Field | Result |
|---|---|
| Registry | `ghcr.io` |
| Repository | `amineabri/primefaces-migration` |
| Source image/index digest | `sha256:63126aa490725adbcf1f02170a251f1d0b949ddaeb6b2c574712c4d864a003fe` |
| Published immutable reference | **`ghcr.io/amineabri/primefaces-migration@sha256:63126aa490725adbcf1f02170a251f1d0b949ddaeb6b2c574712c4d864a003fe`** |
| Promotion tag | `ops02-63126aa49072` — convenience only, not the production identity |
| Promotion completion/remote verification timestamp | **2026-10-27T23:43:47Z** |
| Remote platform manifest | `sha256:193258104ad4478cf8f91849f3133c119fb0bada2be303a5e7bebdd466d52fe5`, linux/amd64 |
| Remote attestation manifest | `sha256:3325d0dbe89a84310c890cd4376492d7767464dceecc7af61538f797ced46ab6` |
| Digest comparison | **EXACT MATCH** with validated source index |
| Image classification | Same validated image; **not a NEW IMAGE** |
| WAR SHA256 | `e03949114666f2abce73dd9c3f6c3aca933f1db1c1190b1c779c6196304fb5a0`, unchanged |

Executed promotion and independent remote inspection:

```bash
docker tag sha256:63126aa490725adbcf1f02170a251f1d0b949ddaeb6b2c574712c4d864a003fe \
  ghcr.io/amineabri/primefaces-migration:ops02-63126aa49072
docker push ghcr.io/amineabri/primefaces-migration:ops02-63126aa49072
docker buildx imagetools inspect \
  ghcr.io/amineabri/primefaces-migration@sha256:63126aa490725adbcf1f02170a251f1d0b949ddaeb6b2c574712c4d864a003fe
```

Push reported the expected digest; remote inspection independently returned the same OCI index and platform/attestation manifests. Credentials were handled by the existing Docker registry authentication, not written to repository files. Repository visibility, retention, deletion protection, signing policy and production-host pull authorization were not changed or accepted by this test. Deploy using the immutable reference, not the tag.

## Actual HTTPS environment — BLOCKED

The user supplied **`https://localhost`** as the endpoint. It was probed from the current Copilot host with certificate/hostname verification enabled, no insecure bypass, no diagnostic cookie override and no explicit proxy:

```bash
curl --noproxy '*' --connect-timeout 5 --max-time 15 https://localhost
```

Actual result:

```text
curl: (7) Failed to connect to localhost port 443 after 0 ms: Couldn't connect to server
HTTPS status=000 remote= certificate_verify=0
```

**No TLS handshake occurred.** The reported certificate verification counter is not evidence that a chain or hostname passed: connection failed before a certificate could be inspected. There was no HTTP response, redirect or application body. `docker ps` showed **no running local containers** at inspection. This does not prove that no remote production deployment exists; `localhost` refers to this execution host, not another workstation/server.

The follow-up asking for an actual deployed environment or authorization for a distinctly local rehearsal was skipped. No proxy/certificate/container/environment was invented or provisioned, and no production service was drained or modified.

| Required production gate | Result |
|---|---|
| Real HTTPS origin/certificate chain/hostname/redirects | **BLOCKED** — designated endpoint unreachable |
| Forwarded/X-Forwarded-Proto trust, host validation and redirect/resource URLs | **NOT TESTABLE** — no actual proxy configuration/access or reachable origin |
| Secure/HttpOnly/SameSite=Lax cookies and session continuity through HTTPS | **NOT TESTABLE** — OPS-01 local cookie evidence remains valid but is not end-to-end production acceptance |
| Absence of HTTP-only diagnostic override in production | **NOT VERIFIED** — production workload/environment unavailable |
| AJAX/upload/CSV/polling through TLS proxy | **NOT TESTABLE** |
| WebSockets | Not used by executed sample feature paths; production proxy policy not inspected |

## Proxy trust and security — BLOCKED

The approved architecture remains single-instance standalone Docker, host reverse-proxy TLS termination, local sessions, no clustering. Infrastructure-owned controls must be evidenced separately from application controls:

| Control owner | Required evidence | OPS-02 result |
|---|---|---|
| Proxy/network | Trusted proxy only; overwrite untrusted forwarding headers; enforce HTTPS/origin; block direct backend access | **NOT VERIFIED** |
| Proxy | HSTS/other approved headers, appropriate disclosure/header policy, upload/body/timeouts and request forwarding | **NOT VERIFIED** |
| Production host/orchestrator | Only intended backend exposure; no public EAP management/health endpoints; controlled management access | **NOT VERIFIED** |
| Validated image | Secure/HttpOnly/SameSite=Lax session configuration; container-loopback management binding and deployment-aware probes | Prior **OPS-01 PASS**, not proof of actual production launch settings |
| Product/security owner | Authentication/access policy, stable browser/OS matrix and accepted known risks | **NOT SUPPLIED/NOT ACCEPTED here** |

No infrastructure-owned control was assumed accepted. The sample application has no built-in authentication or logout integration; production proxy authentication, if required, remains unspecified.

## Production health/replacement integration — BLOCKED

OPS-01 startup/liveness/readiness scripts and the **IMMUTABLE CONTAINER REPLACEMENT** model remain validated locally. Promotion did not deploy or connect them to a real production supervisor.

| Required integration behavior | Production evidence |
|---|---|
| Startup grace prevents premature replacement | **NOT TESTABLE** |
| Failed readiness removes traffic / broken ROOT receives none | **NOT TESTABLE** |
| Liveness failure creates a fresh replacement container | **NOT TESTABLE** |
| Repeated failures generate alerts/escalation | **NOT TESTABLE** |
| Health/replacement/deployment/resource-pressure events observable by operators | **NOT TESTABLE** |

Docker HEALTHCHECK and `restart: "no"` alone are not production orchestration. No automatic recovery or monitoring success is claimed from the presence of repository scripts.

## Controlled cutover rehearsal — BLOCKED

No old production instance, traffic-control access, maintenance authorization/window or running new production instance was supplied. No actual cutover steps or timings can be recorded as executed.

| Ordered step | Status |
|---|---|
| Deploy promoted image by immutable digest | **BLOCKED** — production host/platform access missing |
| Drain/remove old instance | **NOT EXECUTED** — old instance and traffic-control details missing |
| Invalidate existing application sessions/Faces views | **NOT EXECUTED in production** |
| Route traffic to new instance after readiness | **NOT EXECUTED** |
| Verify login/session creation | **NOT TESTABLE**; app has no native login, proxy identity policy unknown |
| Critical smoke/health/monitoring/logs | **BLOCKED** |
| Start/end/durations for actual cutover | **NOT AVAILABLE** — no simulated timings substituted |

The mandatory procedure remains **INVALIDATE ALL EXISTING APPLICATION SESSIONS / FACES VIEWS**, at cutover and rollback. Drain/stop every old app instance, prevent app-scoped state restoration, start fresh, require new GET/new session and discard stale Faces forms. Warn users of lost unsaved work. Never restore cross-version state or imply a state-preserving rolling migration. OPS-01 replacement/session-loss evidence remains historical local evidence only.

## Rollback rehearsal — ROLLBACK BLOCKED

**No approved previous production artifact/runtime/configuration pair was supplied.** The required package is still missing:

- Actual approved previous-production application artifact, immutable identity/hash and release provenance.
- Matching compatible runtime/Java/platform image and immutable identity.
- Matching previous production configuration, secure secret/configuration references and deployment instructions.
- Approved isolated rehearsal/production access, traffic-control procedure, expected critical user path and monitoring access.

Do not substitute pre-MIG08 artifacts or the reconstructed private-PrimeFaces baseline. The accessible historical EAP7 registry manifest from OPS-01 is not an approved rollback package. No pre-Jakarta WAR was deployed onto EAP8.

Drain/remove migrated deployment, state invalidation, previous compatible runtime/config restoration, previous artifact deployment, traffic restoration, prior startup/user-path/monitoring checks and rollback completion are **NOT EXECUTED**. No previous-production readiness or rollback duration is claimed.

## Focused production smoke and observability — BLOCKED

| Smoke path | Production result |
|---|---|
| Application load/navigation | **NOT TESTABLE** |
| Login/session creation | **NOT TESTABLE**; native app login not present |
| AJAX/table/form submission | **NOT TESTABLE** |
| File upload/validation feedback | **NOT TESTABLE** |
| Dialogs/messages/CSV export | **NOT TESTABLE** |
| Logout/session invalidation | **NOT TESTABLE**; native logout absent, required identity/session boundary must be specified |

No full migration harness was rerun: the image did not change and no reachable production path exists to test. No production application/EAP/container logs, health/replacement events, HTTP error dashboards, deployment-failure alerts or resource-pressure alerts were available. Operator ability to identify failed deployment, unhealthy instance, repeated replacement loop or application error spike is **NOT VERIFIED**.

## Explicit residual product/test gaps

| Gap | Current disposition |
|---|---|
| Safari product validation | **NOT TESTED**; tooling WebKit is not Safari certification |
| Accessibility | **PARTIAL / NOT FORMALLY ACCEPTED** |
| Mobile/responsive | Retained narrow table/calendar wrapping/clipping, fixed-dialog mobile and inherited style limitations; owner acceptance not recorded |
| Maintained repository behavioral tests | **0**; preserved54-check acceptance harness is evidence, not a maintained regression suite |

No product or infrastructure risk waiver was inferred from image promotion or the skipped environment question.

## Evidence and final decision

Evidence directory: `/Users/amineabri/.copilot/session-state/b576bbf4-7254-42d8-992a-9e42c392510e/files/ops02/`.

Preserved records: `promotion.log`, `promoted-manifest.log`, `promotion-record.json`, failed `https-probe.log`, empty HTTPS response-header output, source/WAR identity checks and `evidence-manifest.json`. Prior OPS-01 image archive/harness/lifecycle/configuration and all migration records remain retained. Empty/missing response artifacts represent connection failure, not successful acceptance. No acceptance container was created or production workload stopped during OPS-02.

**Initial attempt status: BLOCKED.** Exact validated image promotion is **PASS**. At that attempt, remaining gates required a reachable designated production HTTPS origin with deployment/proxy/monitoring/traffic-control access, approved health/replacement integration, and the actual approved rollback package plus rehearsal authorization. This historical result is superseded only within the explicitly local scope of the next addendum.

## Authorized local continuation — 2026-10-27/28 UTC

The user clarified that no external production hostname exists and explicitly requested a local TLS reverse-proxy topology. The local certificate is authorized **for this exercise only**. No actual production hostname/certificate/platform or previous-production rollback package is inferred.

### Topology and immutable identities

| Component | Configuration/evidence |
|---|---|
| Application | **Exact promoted** `ghcr.io/amineabri/primefaces-migration@sha256:63126aa490725adbcf1f02170a251f1d0b949ddaeb6b2c574712c4d864a003fe` |
| EAP unchanged | No Dockerfile, WAR, dependencies, application code or EAP configuration changes in this continuation; no image rebuild |
| EAP network | Internal Docker backend network, **no published ports**, HTTP8080 only between proxy and EAP; local sessions, no clustering |
| Proxy | Nginx1.28.3 from `nginx@sha256:a8b39bd9cf0f83869a2162827a0caf6137ddf759d50a171451b335cecc87d236` |
| Public local endpoints | **https://localhost:8443**, HTTP redirect only at `http://localhost:8081`; bound127.0.0.1 |
| Isolation | Proxy joins backend plus an edge network for loopback port publication; EAP joins backend only |
| Definition | `operations/local-tls/compose.yml`, `nginx.conf`, `supervise.py`; separate Compose project **ops02-local** |
| Health | Run original in-container startup/liveness/readiness scripts through Docker, never use a public health endpoint |
| Diagnostic override | **ABSENT**. Actual EAP environment and cookie behavior confirm production-default secure cookie configuration |
| Certificate | Self-signed7-day **LOCAL DEVELOPMENT ONLY**, CN/SAN localhost; SAN also127.0.0.1; generated2026-10-27T23:53:27Z, expires2026-11-03T23:53:27Z |

Development key/certificate are in the session evidence's private `tls/` directory, **not committed, baked into images or installed into system trust**. Private key permission is restricted; omit it from shared evidence exports. No production CA chain, renewal or external-hostname acceptance is claimed.

### TLS/proxy results — LOCAL PASS

| Gate | Actual assertion/result |
|---|---|
| TLS certificate/hostname | `curl --cacert <local cert>` verifies local explicit trust and localhost name, returns200/verify0; untrusted self-signed request fails60; wrong hostname fails60 |
| Browser certificate handling | Disposable Playwright contexts allow this self-signed certificate only through `ignore_https_errors=true`; **separate curl verification** checks trust/name/validity. This is not browser public-CA trust acceptance |
| Redirect | HTTP8081 returns308 to **https://localhost:8443**, preserving request path; no downgrade in actual app navigation/forms/resource/AJAX/download responses |
| Secure cookie | Browser retains JSESSIONID over HTTPS; **Secure, HttpOnly, SameSite=Lax** in all three engines; not readable through document.cookie; same session/model survives POST/reload |
| Forwarded headers | Effective config overwrites Host, X-Forwarded-Host/Port/Proto/For and Forwarded using the trusted proxy origin/client address; client-supplied values are not appended/trusted |
| Spoof attempt | Supplied proto=http and attacker host/port/Forwarded values; response stays local HTTPS-origin behavior, secure cookies preserved and attacker origin absent. Wrong Host returns400 |
| Resources/AJAX/upload/export | Actual Faces scripts/styles served via HTTPS, no insecure responses; actual form/AJAX partial updates/validation/native multipart upload/parsed CSV download PASS |
| Polling | HTTP AJAX poll updates actual model through HTTPS; no application WebSocket feature path to test |
| Headers | HSTS max-age300 for local exercise, nosniff, SAMEORIGIN, strict-origin-when-cross-origin; no EAP/X-Powered-By/version header exposed |
| Remaining disclosure | Generic `Server: nginx` product token remains; no claim of complete product concealment |
| Management/health visibility | Public `/health`, `/health/ready`, `/health/live`, `/management`, `/metrics` return404; actual management bound EAP-container loopback, not published |

The trust boundary is **isolated backend network + header-overwriting proxy configuration**, not an application IP allowlist. The backend is accessible to its trusted proxy and privileged host/Docker operators, not general public clients. No request-introspection code was added to EAP to observe headers. Native/production network and credential policy are not proven by this local topology.

**Focused smoke:27/27 grouped checks PASS**,9each Chromium156.0.8078.4, Firefox157.0, WebKit27.2: load/session/form; navigation/Faces resources; AJAX/required validation/reset; table sorting/filter/row expansion; native accepted upload/extension rejection; dialogs/confirmation/messages; parsed CSV header/four records; AJAX polling; fresh browser-session behavior. Page errors, HTTP errors, insecure responses and Faces partial-response errors **0**. No full54-check rerun.

The app has **no login/logout integration**. Login and server logout are NOT APPLICABLE to the sample, not passed authentication checks. Clearing browser cookies demonstrates a fresh session, **not server-side logout**; actual server-side old-state loss is separately demonstrated by immutable container replacement below.

### Local health/replacement integration and observability

`operations/local-tls/supervise.py` runs on the local host with Docker access. It observes the pinned EAP service, runs the existing three probes, gates Nginx routing only when **all three sampled probes pass**, and creates a **fresh same-digest instance** when a stopped/non-live server fails twice after startup grace. A live-but-unready application is withheld and alerted rather than blindly restarted. JSON events record startup/grace, readiness routing, failures, alerts and replacements. Replacement limit defaults to3 and stops/escalates instead of creating an unbounded restart loop. Signal shutdown gates traffic closed.

Verified with bounded, controlled fault injection on OPS-02-owned containers:

| Check | Local result |
|---|---|
| Startup initially withheld | Proxy starts with backend-unready marker; public HTTPS returns503 before supervisor readiness approval |
| Broken/disabled ROOT | Undeploy retaining content; live EAP remains responsive, readiness fails, supervisor removes public routing/returns503 and emits repeated-failure JSON alert |
| Restore ROOT | Redeploy original content; readiness passes and traffic resumes; no new WAR/image |
| Liveness failure | Gracefully stop old EAP; two observed failures trigger a different fresh container from **same promoted digest**, not `docker restart` |
| Startup delay | Pause the new process for15seconds within local40second grace; public traffic withheld, no premature second replacement, resume then readiness/HTTPS pass |
| Session boundary | Previously saved model is not restored; same browser receives a new session cookie, initial model; new form/save/reload works through HTTPS |
| Logs/events | EAP/container logs and versioned proxy access logs available, HTTP503/404 and upstream statuses visible, local repeated-failure and replacement events captured |
| Resources | Docker CPU/memory snapshot captured; **resource-pressure alerting not installed/tested** |

Local routing is **poll-based, not instantaneous**. Each probe can take several seconds, failure detection/routing converge after the polling cycle, and probe snapshots can differ while a deployment transitions. This is a local acceptance supervisor, **not a durable production service, pager integration or highly available control plane**. JSON alert generation is validated; remote notification delivery, HTTP error-rate thresholds, resource-pressure alerts, forced-host/daemon failure recovery and supervisor-crash watchdog are not. Do not imply those controls passed. Maintenance gating below prevents request routing during planned replacement.

The first local recovery exercise and its timings remain in `local-recovery-first-results.json`. The subsequent explicitly maintenance-gated cutover is authoritative for the planned local cutover procedure.

### Controlled LOCAL cutover — PASS with documented single-instance outage

Executed against the exact registry digest; **not a live-production change**:

1. Establish HTTPS session, save a distinguishing model value; record cookie and old instance.
2. Set proxy `/tmp/maintenance` marker and confirm503 **before** stopping EAP. This blocks new traffic separately from readiness; allow graceful Docker stop (5second bound in this disposable exercise).
3. Stop old instance; no persistent app/session/view store exists. The local supervisor detects liveness failure, replaces/removes the old container and starts a fresh exact-digest instance.
4. Hold the new process paused15seconds to exercise startup grace, then resume. Wait for in-container health and supervisor routing readiness; maintenance continues to return503.
5. Remove maintenance marker only after readiness; HTTPS200 resumes. Require fresh GET/new JSESSIONID; old model lost, new form/AJAX/save/reload PASS. Native login not present.
6. Capture events, EAP/proxy/container logs and resource snapshot. No cross-version serialized/session/view state restored.

| Final controlled exercise timing | UTC/result |
|---|---|
| Broken ROOT removal/alert check completed |2026-10-28T00:06:17.766271Z; **18.73seconds** |
| Readiness restored/traffic resumes |2026-10-28T00:06:41.782906Z; **24.02seconds** |
| Cutover started | **2026-10-28T00:06:43.309124Z** |
| Immutable replacement event | **2026-10-28T00:06:49.383588Z** |
| HTTPS/session/post-replacement smoke completed | **2026-10-28T00:07:42.904566Z** |
| Planned maintenance/replacement through smoke | **59.60seconds**, includes intentional15second pause, health sampling and smoke assertions; not pure server startup time or a production SLA |

Exact per-step timestamps and durations in `local-operations-results.json` are authoritative. Single-replica replacement has a maintenance outage; no zero-downtime/HA or in-flight long-upload drain SLA is asserted. **INVALIDATE ALL EXISTING APPLICATION SESSIONS / FACES VIEWS**, require fresh GET, warn of lost unsaved work; apply the same procedure at rollback.

### Rollback and residual gates

**ROLLBACK BLOCKED:** no actual approved previous-production application/runtime/configuration/secrets references/deployment instructions were supplied. No reconstructed migration artifact was substituted and no pre-Jakarta WAR was deployed onto EAP8. Current-image HTTPS recovery/replacement is not previous-production rollback. The original missing-package list remains valid.

Local continuation closes the intended reverse-proxy/TLS architecture gate and validates local health/routing/replacement/alerts/cutover within this scope. It does **not** close actual production host/CA/hostname/TLS renewal, durable supervisor/monitoring/access-policy and on-call integration, resource/error-rate alerting, or compatible previous-production rollback.

Safari product remains **NOT TESTED**; accessibility **PARTIAL / NOT FORMALLY ACCEPTED**; inherited mobile/responsive limitations and owner acceptance remain open. Maintained repository behavioral tests remain **0**; focused session smoke scripts are evidence, not a new maintained application suite.

### Reproduction and cleanup

Generate a new development certificate outside tracked source, never reuse the exercise key for production:

```bash
mkdir -p build/ops02-local-tls
export OPS02_TLS_DIR="$PWD/build/ops02-local-tls"
(umask 077; openssl req -x509 -newkey rsa:2048 -sha256 -nodes -days 7 \
  -keyout "$OPS02_TLS_DIR/localhost.key" -out "$OPS02_TLS_DIR/localhost.crt" \
  -subj '/CN=localhost/O=OPS-02 Local Development Only' \
  -addext 'subjectAltName=DNS:localhost,IP:127.0.0.1')
docker compose -f operations/local-tls/compose.yml up -d
# Keep the local supervisor in a foreground terminal during the exercise.
python3 operations/local-tls/supervise.py
```

In another terminal use `curl --cacert "$OPS02_TLS_DIR/localhost.crt" https://localhost:8443/`. Public health routes deliberately return404; use `docker compose -f operations/local-tls/compose.yml exec -T eap /opt/server/bin/ops-healthcheck.sh readiness`. Stop the supervisor and run `docker compose -f operations/local-tls/compose.yml down` after collecting evidence. The local certificate is self-signed and not trusted automatically by browsers; do not install it as a production CA. Never enable the HTTP-only session-cookie diagnostic override.

Local evidence is retained under the existing `files/ops02/`: certificate verification/metadata (development private key excluded from export manifest), effective proxy config, same-digest pull/inspect records, `local-smoke.py`/27results/screenshots/CSVs, `local-proxy-security-results.json`, supervisor logs, first recovery and final maintenance-gated operations results, separate local health/management logs, resource snapshots, EAP/proxy logs and final identity checks. Initial unreachable-port and internal-only-network port-publication failure are preserved where recorded; adding an edge network only to the proxy fixed local host connectivity without exposing EAP.

After capture, only the OPS-02 local supervisor, project containers and project networks were stopped/removed. Validated application image, registry publication and all previous evidence remain preserved.

**Current final production readiness: OPERATIONALLY INCOMPLETE. LOCAL PRODUCTION-TOPOLOGY TLS VALIDATION: PASS. ROLLBACK BLOCKED. No LIVE PRODUCTION TLS VALIDATION claimed. Stop after OPS-02.**
