# OPS-03 — Go-live runbook

**Status: HOLD — not authorized for live execution.** This is a handover procedure, not a record of production deployment. Read the [go-live readiness decision](go-live-readiness.md) first. Do not execute cutover until its blockers are closed and named owners approve the change.

## Release contract

| Item | Required value |
|---|---|
| Validated release image | `ghcr.io/amineabri/primefaces-migration@sha256:63126aa490725adbcf1f02170a251f1d0b949ddaeb6b2c574712c4d864a003fe` |
| Architecture | One linux/amd64 EAP instance; immutable container replacement; trusted host reverse proxy terminates TLS; no clustering/HA |
| Stack | EAP8.1 Update8.0, Red Hat OpenJDK21.0.12.1+1-LTS, Jakarta EE10 application, PrimeFaces15.0.16 Jakarta |
| Session contract | LOCAL, not replicated/persisted/passivated; **INVALIDATE ALL EXISTING APPLICATION SESSIONS / FACES VIEWS** at cutover and rollback |
| Evidence | EAP54/54 acceptance and local HTTPS27/27 smoke PASS; **LOCAL PRODUCTION-TOPOLOGY TLS VALIDATION**, not live production TLS |
| Change boundary | No application source changes, WAR changes, image rebuilds or mutable image tags |

Use the tested image as-is; do not copy the OPS-02 development key/certificate, localhost hostname or local supervisor into production and call them production acceptance. The single-instance model has maintenance downtime and loses unsaved session/view state.

## Mandatory change record

Before proceeding, record the change ID, date/window, real HTTPS origin, production host/platform, deployment operator, incident commander/on-call backup, proxy/TLS owner, monitoring owner, business approver, immutable image reference, approved rollback version/package, and evidence storage location. Every owner is **UNASSIGNED** until explicitly recorded and acknowledged. Record UTC start/end times, actual commands, results, approvals and abort decisions. Never place secrets or full session cookies in the change record.

## PRE-CUTOVER — all gates required

| Gate | Required action/evidence |
|---|---|
| Image identity/access | Resolve remote digest below; pull the exact image from the actual deployment host using least-privilege registry access; record index/platform identities. No rebuild |
| Infrastructure | Confirm host support/capacity, amd64 platform, Docker/Compose versions, UID185 permissions, firewall/proxy-only backend, no persistent session/config/data mounts and no conflicting workload |
| Configuration | Review deployed environment/Compose inputs: `CONFIG_IS_FINAL=true`, management bound container loopback, no `ops.session.cookie.secure=false`, no unapproved launcher/config override. Configuration matches the image and approved proxy |
| TLS/DNS | Real DNS resolves correctly; trusted CA chain/hostname/expiry and renewal tested at the real HTTPS origin; HTTP redirects to HTTPS, forwarded headers overwritten, approved Host enforced; no public management/health routes |
| Health/recovery | Production supervisor/service installed, startup grace and all three probes connected, failed readiness removes traffic, repeated liveness failure creates a fresh same-digest instance; alerts delivered to acknowledged on-call |
| Observability | EAP/container/proxy logs searchable and retained; dashboards, error-rate/resource/certificate alerts and notification delivery tested; baseline recorded |
| Rollback | Actual approved previous-production application/runtime/configuration/secrets references/instructions available, retained and reverse-deployment rehearsed. **Missing package means STOP** |
| Product approval | Record owner dispositions for browser/accessibility/mobile and zero maintained behavioral tests; validate any actual authentication/access policy |
| Maintenance | Announce downtime, unsaved work loss and requirement to reload old Faces forms; confirm business window and fallback/escalation contacts |
| Old deployment | Identify all old instances and state stores if applicable. Confirm maintenance/routing control and graceful drain timeouts, including uploads and CSV requests. For first deployment, record old deployment as NOT APPLICABLE, not a guessed rollback release |

Inspection commands, run on the intended host only after approval:

```bash
export EAP_APPLICATION_IMAGE=ghcr.io/amineabri/primefaces-migration@sha256:63126aa490725adbcf1f02170a251f1d0b949ddaeb6b2c574712c4d864a003fe
docker buildx imagetools inspect "$EAP_APPLICATION_IMAGE"
docker pull --platform linux/amd64 "$EAP_APPLICATION_IMAGE"
docker compose -f docker-compose.production.yml config --quiet
```

A successful local pull is not production-host pull acceptance. The proxy and monitor are infrastructure-owned: the production Compose file supplies the backend container only. Do not use the build-enabled local Compose file for production.

## CUTOVER

1. **Start the approved change record and maintenance window.** Gate the public route into maintenance before removing the old backend; verify no new application traffic reaches it. Record UTC time. Drain existing requests for the approved bound, then stop old instances. If the deployment has no old instance, record that fact.
2. **Invalidate existing application sessions/Faces views.** Stop every old instance. Prevent restoration of this application's persisted/replicated state if any exists outside the validated local-session topology; isolate/clean only app-owned stores with operator approval. Do not restore old server data/config/tmp directories or JavaEE/PrimeFaces serialized objects. Require new GET/new session; stale forms must be reloaded.
3. **Deploy the exact image without rebuilding.** With maintenance still active and all preconditions satisfied, run `bash operations/eap/replace-container.sh`. It pulls the supplied immutable image and forces a fresh production Compose instance, waiting for Docker readiness. A command error is an explicit failure, not permission to route traffic or retry indefinitely.
4. **Verify startup and readiness independently of the public URL.** Record actual image/environment, clean boot/deployment status, ROOT.war availability and these probes:

```bash
docker compose -f docker-compose.production.yml exec -T primefaces-homeoffice \
  /opt/server/bin/ops-healthcheck.sh startup
docker compose -f docker-compose.production.yml exec -T primefaces-homeoffice \
  /opt/server/bin/ops-healthcheck.sh liveness
docker compose -f docker-compose.production.yml exec -T primefaces-homeoffice \
  /opt/server/bin/ops-healthcheck.sh readiness
```

5. **Route only after all gates pass.** Production routing/supervisor must agree the instance is ready; remove maintenance under the proxy owner's control. Validate the real trusted-CA HTTPS entry point, not backend8080 or a self-signed local substitute.
6. **Run the focused checklist below.** Record browser/version/OS, origin, assertions, logs and UTC times. No native login/logout exists; test the actual proxy identity policy if added and record its owner. Do not call cookie clearing a server logout.
7. **Abort/escalate on a failed critical gate.** Keep traffic withheld or restore maintenance. Preserve failed-instance logs before replacement/removal. Do not deploy the pre-Jakarta WAR on EAP8, change the validated image or invent a rollback target.

## Minimal production HTTPS smoke checklist

This is a short go-live check, **not a replacement for the preserved full54-check acceptance harness**. Use only approved non-sensitive sample inputs.

| Check | Required assertion |
|---|---|
| HTTPS/application | Real hostname and trusted certificate verify without an insecure bypass; HTTP redirect stays HTTPS; actual Home content loads, no backend welcome/error page |
| Session/identity | Secure/HttpOnly/SameSite=Lax JSESSIONID established; form value persists across same-session reload; exercise approved proxy login if present, otherwise native login NOT APPLICABLE |
| Navigation/resources | Navigate Home/Elements/Employees; correct content, Faces CSS/scripts/fonts use HTTPS, no mixed content or resource errors |
| Faces form/AJAX | Change service name and Save; actual model/messages update, required-field failure and Reset behave correctly; no Faces partial-response error |
| Upload/validation | Accepted small txt invokes expected status/message; invalid extension is rejected without corrupting prior upload status |
| Tables | Sort/filter and expand a row; verify correct data/detail, not merely a successful HTTP status |
| Dialogs/messages | Open/close dialog; confirm action and message/growl |
| CSV | Download and parse actual expected headers/records, not an HTML error/login page |
| Logout/session termination | If authentication exists, verify its real logout/SSO boundary. For this unauthenticated sample, native logout is NOT APPLICABLE; use an approved disposable session/replacement test for server-state invalidation, never log out all users as an unplanned smoke step |
| Observability | No unexpected browser/console/5xx/linkage/deployment errors; supervisor/readiness status and logs agree with actual path |

A previous OPS-02 browser certificate exception was scoped to self-signed development testing. It must **not** be used for this production checklist.

## POST-CUTOVER

1. Verify EAP boot/deployment/container/proxy logs, live/readiness state and actual HTTPS session creation. Check no namespace/module conflicts, deployment rollback, recurring failed AJAX or replacement loop.
2. Confirm alerts and dashboard ingestion, including proxy5xx trends, readiness transitions, replacements, memory/CPU/host capacity and certificate expiry. Confirm the named on-call can locate the release/digest and failed instance logs.
3. Exercise key user journeys with the product/business owner and obtain explicit sign-off. Preserve exception/risk approvals; no sign-off inferred from technical checks.
4. Monitor for the **owner-approved observation window and error budget**. These values are currently TBD and must be fixed before release; do not manufacture a universal safe threshold.
5. Record UTC completion, outage duration, session/user impact, smoke results, error baseline, alerts, approvers and rollback disposition. Keep prior compatible artifacts/configurations available for the approved rollback-retention window.

## Rollback triggers and decision path

| Trigger | Required action |
|---|---|
| Deployment or startup failure | Do not route traffic; preserve errors and escalate to deployment owner |
| Readiness fails/not achieved within approved grace | Maintenance/traffic removal; distinguish a live-but-broken deployment from non-live process; do not blindly restart the same container |
| Critical functional regression | Stop new traffic, reproduce minimally and invoke incident/business owner rollback decision |
| TLS, trust, origin, cookie or exposure/security failure | Withhold traffic immediately; involve proxy/security owner; do not bypass certificate/security validation |
| Sustained5xx/error threshold breach | Apply **approved** rate/window/minimum-volume criteria; thresholds currently unassigned, so this gate is not operationally accepted |
| Repeated replacement/resource pressure | Bounded replacement and alert/escalation; preserve diagnostics, do not allow an unbounded restart loop |

**Rollback execution requires the approved compatible previous-production pair.** Drain current traffic, invalidate application sessions/views, restore the previous runtime/Java/config/secrets references and application artifact together, verify prior startup/readiness and critical user path/monitoring, then restore traffic and record completion. Never swap javax and Jakarta WARs across incompatible runtime families.

**Current rollback readiness: BLOCKED — user confirmed approved package is unavailable in OPS-03.** There is no executable previous-release command or successful rollback rehearsal to report. If an incident occurs without a credible rollback path, remain in maintenance and escalate; do not guess a release. This is a go-live blocker, not an automatically accepted risk.

## Monitoring handover contract

All people/teams, destinations and numeric policies below are **UNKNOWN / UNASSIGNED**, not implied by the local JSON supervisor alerts.

| Signal | Proposed accountable role — assignment required | Required policy/evidence before go-live |
|---|---|---|
| Deployment/startup failure | Deployment owner + on-call | Page/route destination, acknowledgement/escalation, release ID/digest and failed boot logs |
| Readiness failure | Platform/on-call + proxy owner | Traffic removal, duration threshold, page policy, safe recovery and maintenance controls |
| Liveness/replacement | Platform/on-call | Fresh immutable replacement, startup grace, replacement-rate/window cap and escalation; no same-container restart dependency |
| Repeated replacement | Incident commander/on-call | Detect loops, stop retries at approved cap, retain prior-container diagnostics |
| HTTP5xx/error spike | Service owner + proxy/monitoring owner | Approve numerator/denominator, sampling window, minimum request count, threshold, observation window and notification test |
| CPU/memory/OOM/disk pressure | Host/platform owner | Capacity limits/headroom, sustained thresholds, OOM/container-exit events, host logs and resource dashboards |
| Certificate expiry/renewal | TLS/DNS/proxy owner | Expiry warning schedule, renewal failure page, chain/hostname revalidation and emergency contact |
| Logs/dashboards | Observability owner | Retention duration/storage, access controls/redaction, query examples, ingest-gap alerts, release/event correlation |

No recipient, paging destination, SLA or threshold is assigned by this document. On-call ownership must be acknowledged, notifications delivered in a controlled test, and production control behavior rehearsed before readiness can be approved.
