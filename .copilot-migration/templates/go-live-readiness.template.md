# Go-live readiness: `<PROJECT_NAME>`

Run/revision/recorded time: `<MIGRATION_ID>` / `<CHECKPOINT_REF>` / `<TIMESTAMP_UTC>` or UNKNOWN.

## Readiness criteria

| Criterion | Actual status/evidence | Owner / missing prerequisite |
|---|---|---|
| Validated immutable release available and target access | UNKNOWN | `<OWNER>` / `<ACTION>` |
| Real environment/hostname/DNS/proxy/trusted TLS defined and accepted | UNKNOWN | `<OWNER>` / `<ACTION>` |
| Production config/secrets references reviewed | UNKNOWN | `<OWNER>` / `<ACTION>` |
| Health/recovery/routing integrated and exercised | UNKNOWN | `<OWNER>` / `<ACTION>` |
| Monitoring/on-call/backup, dashboards/log retention, notification policies | UNASSIGNED until acknowledged | `<OWNER>` / `<ACTION>` |
| Credible approved rollback package and rehearsal/contingency | UNKNOWN | `<OWNER>` / `<ACTION>` |
| Cutover runbook, session/data boundary and focused smoke | UNKNOWN | `<OWNER>` / `<ACTION>` |
| Maintenance/business sign-off/observation/error budget | UNKNOWN | `<OWNER>` / `<ACTION>` |
| Residual risks explicitly accepted where permitted | UNKNOWN | `<OWNER>` / `<ACTION>` |

## Evidence scope

Application migration: `<STATUS>`. Actual target-runtime acceptance: `<STATUS>`. Local/provisional vs live-production evidence: `<RESULT>`. Release identity and reports: `<EVIDENCE_REF>`.

Approved previous production artifact/runtime/configuration/version/deployment instructions/secrets references/storage: `<RESULT>`. If missing, rollback BLOCKED; never reconstruct from migration history. For a first release, cite the actually approved contingency and rehearsal.

## Residual risks (repeat actual risks, do not presume absence)

| Risk | Status / scope | Owner acceptance record or UNKNOWN | Follow-up |
|---|---|---|---|
| Required browser products untested | `<RESULT>` | `<EVIDENCE_REF>` | `<ACTION>` |
| Formal accessibility | `<RESULT>` | `<EVIDENCE_REF>` | `<ACTION>` |
| Mobile/responsive/visual baseline | `<RESULT>` | `<EVIDENCE_REF>` | `<ACTION>` |
| Maintained behavioral tests/coverage | `<RESULT>` | `<EVIDENCE_REF>` | `<ACTION>` |
| Other operational/data/identity risks | `<RESULT>` | `<EVIDENCE_REF>` | `<ACTION>` |

## Final handover decision

Select **exactly one** after evaluation, not during template creation:

- READY FOR PRODUCTION DEPLOYMENT
- READY WITH ACCEPTED RISKS
- NOT READY - OPERATIONAL BLOCKERS REMAIN
- BLOCKED

Chosen decision: `<STATUS>`. Authority/owner/time: `<OWNER>` / `<EVIDENCE_REF>` / `<TIMESTAMP_UTC>` or UNKNOWN. Rationale/confidence: `<RATIONALE>` / `<CONFIDENCE>`.

Ready requires all mandatory release/environment/TLS/health/monitoring/rollback/cutover/smoke gates and no critical unresolved issue; accepted risks require explicit ownership and cannot conceal missing mandatory gates. This document does not itself execute or authorize deployment.
