# Production readiness: `<PROJECT_NAME>`

> Use only if operations are relevant. Initial status is NOT ASSESSED; no previous result is implied.

## Release and scope

Run/stage/environment/owner: `<MIGRATION_ID>` / `<PHASE_ID>` / `<ENVIRONMENT_ID>` / `<OWNER>`. Authorization and observed UTC times: `<EVIDENCE_REF>` / `<TIMESTAMP_UTC>` or UNKNOWN.

Application migration status: `<STATUS>`. Target-runtime acceptance: `<STATUS>`. Current production readiness: `<STATUS>`.

| Identity/contract | Actual value/evidence |
|---|---|
| Source revision / immutable artifact/runtime/configuration | `<CHECKPOINT_REF>` / `<EVIDENCE_REF>` |
| Image identity, only if applicable | `<IMAGE_REGISTRY>` / `<IMAGE_REPOSITORY>` / `<IMAGE_DIGEST>`; unknown until verified |
| Promotion/source/destination/platform identities and timestamp | `<RESULT>` / `<TIMESTAMP_UTC>` or UNKNOWN |
| Real HTTPS origin / topology / architecture | `<HTTPS_ORIGIN>` / `<RESULT>` |
| Cluster requirement / session strategy / cutover policy | `<RESULT>` / `<EVIDENCE_REF>` |
| Previous approved rollback package/version/storage | `<RESULT>` / `<EVIDENCE_REF>`; do not reconstruct |

## Independent operational gates

| Gate | Applicability and criteria | Status | Actual environment/evidence | Owner / blocker / next action |
|---|---|---|---|---|
| Immutable release/pull/promotion | No unvalidated rebuild; exact accepted candidate identity | UNKNOWN | `<EVIDENCE_REF>` | `<OWNER>` / `<ACTION>` |
| Runtime/config/secrets access | Supported actual runtime/platform, secure references | UNKNOWN | `<EVIDENCE_REF>` | `<OWNER>` / `<ACTION>` |
| Real TLS/proxy | Hostname/DNS/CA/renewal, redirects/resources/AJAX/upload, cookies | NOT_RUN | `<EVIDENCE_REF>` | `<OWNER>` / `<ACTION>` |
| Trust/exposure/headers | Trusted forwarding, management/backend/health visibility, controls layer | NOT_RUN | `<EVIDENCE_REF>` | `<OWNER>` / `<ACTION>` |
| Startup/liveness/readiness integration | Routing removal, recovery, startup grace, disabled/broken app negative check | NOT_RUN | `<EVIDENCE_REF>` | `<OWNER>` / `<ACTION>` |
| Restart/replacement and clustering | Evidence for selected model; no implied HA | NOT_RUN | `<EVIDENCE_REF>` | `<OWNER>` / `<ACTION>` |
| Sessions/cutover | Approved loss/migration, drain and fresh-session/view behavior | NOT_RUN | `<EVIDENCE_REF>` | `<OWNER>` / `<ACTION>` |
| Rollback rehearsal | Approved matched prior package or applicable approved contingency | UNKNOWN | `<EVIDENCE_REF>` | `<OWNER>` / `<ACTION>` |
| Production smoke | Real critical semantic checks, identity/logout where present | NOT_RUN | `<EVIDENCE_REF>` | `<OWNER>` / `<ACTION>` |
| Observability/ownership | Logs, dashboards, alerts actually delivered, retention/access | UNKNOWN | `<EVIDENCE_REF>` | `<OWNER>` / `<ACTION>` |

Local/provisional results must be labeled separately. NOT APPLICABLE requires an actual reason. No required gate disappears because infrastructure is owned elsewhere.

## Monitoring handover

| Signal | Named owner/on-call/destination | Threshold/window/grace/retry policy | Delivery/detection evidence |
|---|---|---|---|
| Deployment/init failure | UNASSIGNED until provided | UNKNOWN | `<EVIDENCE_REF>` |
| Readiness removal / restart/replacement loop | UNASSIGNED until provided | UNKNOWN | `<EVIDENCE_REF>` |
| HTTP/application errors | UNASSIGNED until provided | UNKNOWN, include minimum volume | `<EVIDENCE_REF>` |
| CPU/memory/OOM/disk pressure | UNASSIGNED until provided | UNKNOWN | `<EVIDENCE_REF>` |
| Certificate expiry/renewal | UNASSIGNED until provided | UNKNOWN | `<EVIDENCE_REF>` |
| Log retention/dashboards/ingest gap | UNASSIGNED until provided | UNKNOWN | `<EVIDENCE_REF>` |

## Runbook to render as `operations/go-live-runbook.md`

This outline is a procedure, not execution evidence. Mark HOLD while required inputs are unresolved. Replace commands only with discovered/approved commands; do not execute placeholders.

| Stage | Required steps and recorded inputs |
|---|---|
| Change record | Window, actual release/environment, operator/incident/business owners, evidence store, approvals and abort authority |
| PRE-CUTOVER | Verify digest/artifact and target pull/access, infrastructure/config/secrets, real TLS/DNS, monitoring, rollback package/rehearsal, numeric error/recovery policies, announce maintenance and drain if applicable |
| CUTOVER | Gate traffic, apply approved session/view/data boundary, deploy accepted release, wait startup/readiness, route, critical real-HTTPS smoke, UTC steps/timings |
| POST-CUTOVER | Logs/alerts/health/session/journeys/error window, resource status, business sign-off, actual outage/user impact and evidence |
| ROLLBACK TRIGGERS | Deployment/readiness failure, critical regression, TLS/security failure, sustained approved error threshold, repeated recovery/resource failure |
| ROLLBACK PROCEDURE | Drain current, handle app-owned state/data, restore actual compatible prior artifact/runtime/config/secrets, startup/critical-path/monitoring, restore traffic and record completion |
| Minimal smoke | HTTPS content/session/identity/logout if present; navigation, forms/AJAX/validation, uploads/tables/dialogs/messages/parsed exports as applicable; not a replacement for full acceptance |
| Monitoring handover | Named on-call/backup/escalation, tested notifications, dashboards/log retention, observation/threshold policies |

## Risks and decision

Carry browser product, accessibility, mobile/responsive, missing maintained tests, rollback/environment/identity and other unresolved risks from acceptance; do not reset them. Record actual owner approval or UNKNOWN.

Decision: `<STATUS>`. Choose PRODUCTION READY / PRODUCTION READY WITH KNOWN RISKS / OPERATIONALLY INCOMPLETE / BLOCKED only after relevant required gates are met or blockers recorded. Rationale/evidence/confidence: `<RATIONALE>` / `<EVIDENCE_REF>` / `<CONFIDENCE>`.

Operational report completion is not live production authorization. Stop after the authorized stage.
