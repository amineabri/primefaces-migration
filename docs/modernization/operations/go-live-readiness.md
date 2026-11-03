# OPS-03 — Production handover and go-live readiness

**Recorded:** 2026-10-28. **Decision: NOT READY — OPERATIONAL BLOCKERS REMAIN.**

Application migration is **COMPLETE**. EAP acceptance is **PASS**. The validated operational image remains unchanged. This is a documentary handover assessment, not live deployment authorization, risk acceptance or a reopened migration phase.

## Validated release available

**Immutable image:**
`ghcr.io/amineabri/primefaces-migration@sha256:63126aa490725adbcf1f02170a251f1d0b949ddaeb6b2c574712c4d864a003fe`

OPS-03 independently resolved this remote OCI index successfully; it retains linux/amd64 platform manifest `sha256:193258104ad4478cf8f91849f3133c119fb0bada2be303a5e7bebdd466d52fe5`. The image was not rebuilt, altered or deployed in OPS-03. Registry availability to this environment does not establish pull authorization/retention/access from an unspecified production host.

| Existing evidence | Disposition |
|---|---|
| EAP8.1 Update8.0 / Red Hat Java21 / Jakarta EE10 / PF15 Jakarta | PASS actual server/deployment evidence |
| Migrated application acceptance | **54/54 PASS**, same results as WildFly provisional baseline |
| Local reverse-proxy topology/TLS | **PASS — LOCAL PRODUCTION-TOPOLOGY TLS VALIDATION**, self-signed development certificate only |
| Local HTTPS smoke | **27/27 PASS**, Chromium/Firefox/WebKit with production-default cookie settings |
| Local readiness/routing/replacement | PASS controlled local exercise, no production service/paging integration inferred |
| Local cutover/session invalidation | PASS; maintenance-gated replacement, no restoration of old model/session/views |
| Live production environment/TLS/cutover | **NOT DEFINED / NOT VALIDATED**; localhost does not establish an external production deployment |

Detailed immutable identity, logs, certificate trust boundaries, local fault injection, timestamps and limitations are retained in [production acceptance](production-acceptance.md) and [operational readiness](production-readiness.md). The earlier reports are preserved, not reclassified as live passes.

## Rollback readiness — BLOCKED

The user explicitly confirmed in OPS-03: **“No — keep rollback readiness BLOCKED.”**

The approved package is **not available**. Required missing evidence is the actual previous approved production version identifier/application artifact, compatible previous runtime/Java/platform identity, previous production configuration, secure external configuration/secrets references and deployment instructions. A controlled storage location and integrity/provenance checks are also required.

Do not reconstruct the package from the original unavailable private PrimeFaces artifact, the public baseline substitute, intermediate PF14 migration WARs or a historical EAP7 image tag. No previous-production restore was attempted. Current-image replacement is not rollback to a previous production release.

**Go-live consequence:** a compatible approved rollback path and reverse-deployment rehearsal are not credible yet; this remains a blocking risk. If the operator later proposes a first-ever-release contingency instead, that requires an explicit approved plan and decision—not an invented prior production package or implicit waiver.

## Production prerequisites and named ownership

No real production hostname/host/platform or named operations ownership was provided. The selected architecture is one EAP instance on standalone Docker with reverse-proxy TLS, immutable replacement, local sessions and no clustering. These concrete prerequisites must exist and be evidenced before go-live:

| Prerequisite | What must be provided/validated | Current status |
|---|---|---|
| Real hostname | Approved HTTPS origin, routing and service owner | **MISSING** |
| DNS | Managed zone/records, propagation and change ownership | **UNKNOWN / UNASSIGNED** |
| Trusted CA certificate | Valid hostname/chain, secure key source, renewal/expiry monitoring | **MISSING**; local development certificate not acceptable |
| Reverse proxy/ingress | Production configuration, header trust/Host policy, HTTPS enforcement, maintenance/drain controls | Local model validated; actual production **UNDEFINED** |
| Production host/platform | Supported amd64 deployment host, capacity/limits, firewall/access and service management | **UNDEFINED** |
| Immutable image pull | Actual host can pull pinned GHCR digest with approved least-privilege access and retention policy | Image available; host access **NOT VERIFIED** |
| Secrets/configuration | Reviewed manifest and secure references; no diagnostic cookie override; explicitly record NONE for unneeded secrets | **NOT REVIEWED for live environment**; sample has no app authentication/database |
| Alert destination | Named on-call/backup, pager/channel, acknowledgement/escalation | **UNKNOWN / UNASSIGNED** |
| Log retention | Central storage, access/redaction, duration, rotation/ingest policy | **UNKNOWN / UNASSIGNED** |
| Dashboards | Proxy5xx, deployment/probes/replacement, resource/cert/error visibility | **NOT PROVIDED** |
| Health/replacement | Durable supervisor integration, startup grace, traffic gating, bounded fresh-instance recovery and actual notification tests | Local only; production **NOT INSTALLED/ACCEPTED** |
| Rollback artifact storage | Approved previous app/runtime/config package, immutable identities, controlled retrieval/retention | **BLOCKED / MISSING** |
| Change/business ownership | Approved window, operator/incident owner, business/product approver | **UNASSIGNED** |

No production endpoint was probed or deployed in OPS-03 because the real environment does not exist in the supplied context. No certificates/secrets were generated, production workload changed, image rebuilt or source modified.

## Cutover and smoke handover

The [go-live runbook](go-live-runbook.md) now defines PRE-CUTOVER, CUTOVER, POST-CUTOVER, rollback triggers, minimum HTTPS smoke and the monitoring ownership contract.

**Mandatory deployment boundary: INVALIDATE ALL EXISTING APPLICATION SESSIONS / FACES VIEWS** at cutover and rollback. Announce unsaved work loss; gate traffic/maintenance, drain/stop old nodes, prevent app-state restoration, start fresh, require new GET/new session. No mixed-version state-preserving rolling migration is approved.

The minimal smoke checks real HTTPS, session, navigation/resources, form/AJAX/validation, accepted/rejected upload, table operations, dialogs/messages and parsed CSV. Native app login/logout does not exist; verify any actual proxy identity/logout integration separately. Browser-cookie clearing is not server-side logout. The checklist does not replace the preserved acceptance harness.

The runbook is complete as a **gated procedure**; it cannot be executed as an approved go-live until production inputs, ownership, numeric monitoring policies and a compatible rollback package are supplied.

## Monitoring ownership — UNKNOWN / UNASSIGNED

There is **no named production alert recipient**, on-call/backup, escalation path, monitoring operator or dashboard owner. Missing assignments cover deployment failure, readiness failures, liveness/fresh replacement, replacement-loop caps, sustained HTTP5xx/error-rate thresholds, CPU/memory/OOM/disk pressure, certificate expiry/renewal and log retention.

Threshold rates, sampling windows, minimum request counts, grace intervals, observation periods and acknowledgement/notification policy require explicit owner approval. Do not infer production paging from OPS-02 JSON alert output. See the runbook table for signal-by-signal responsibilities and required proof.

## Known residual product/test risks — not silently accepted

| Risk | Status / acceptance required |
|---|---|
| Safari product not tested | **NOT TESTED**; tooling WebKit is not Safari certification |
| Formal accessibility | **PARTIAL / NOT FORMALLY ACCEPTED** |
| Mobile/responsive | Inherited narrow table/calendar clipping/wrapping and fixed-dialog/style limitations; product owner sign-off missing |
| Maintained behavioral tests | **0**; migration54-check and local27-check scripts remain executed evidence, not a maintained suite |

These are tracked known product risks rather than a newly discovered migration defect. They may be treated as non-blocking **only with the appropriate owner disposition**; no such acceptance was supplied. No new application modernization or test-suite implementation was undertaken.

## Final handover decision

| Readiness criterion | Result |
|---|---|
| Validated immutable image available | **YES**, remote digest verified |
| Live production environment defined | **NO** |
| Production hostname/TLS/DNS plan complete | **NO** |
| Health/monitoring ownership assigned | **NO** |
| Credible approved rollback and rehearsal | **NO — BLOCKED** |
| Cutover runbook/minimal smoke documented | **YES**, gated and not executed live |
| Residual risk acceptance recorded | **NO** |

**NOT READY — OPERATIONAL BLOCKERS REMAIN.** Handover documentation is available, but authorization for actual production use is withheld. Close the missing-environment/ownership/rollback gates, execute the runbook in the real environment, capture evidence and obtain explicit operational/business approval before changing this decision. **Stop after OPS-03.**
