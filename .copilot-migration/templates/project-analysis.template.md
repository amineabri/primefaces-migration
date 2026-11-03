# Project/module analysis: `<PROJECT_NAME>`

> Repeat the module detail section for every detected module; do not assume a single WAR.

## Inventory and dependency graph

Snapshot: `<CHECKPOINT_REF>`. Discovery method/exclusions: `<METHOD>`. Evidence: `<EVIDENCE_REF>`.

| ID / path / role | Build / packaging | Source/build/runtime Java | Framework/platform/runtime | Dependencies/consumers | LOC/test indicators | Complexity/readiness/confidence |
|---|---|---|---|---|---|---|
| `<MODULE_ID>` / `<MODULE_PATH>` / `<ROLE>` | `<RESULT>` | `<RESULT>` | `<RESULT>` | `<RESULT>` | `<RESULT>` | `<RESULT>` / `<CONFIDENCE>` |

Graph: render actual module edges, shared libraries, deployables, provided runtime services and external systems. Distinguish build-time and deployed dependencies. UNKNOWN edges need follow-up.

## Module: `<MODULE_ID>`

- Purpose, application entry points and owner: `<RESULT>`.
- Actual paths/source/assets/descriptors/generated output: `<RESULT>`.
- Current vs proposed target stack and invariant behavior/context/packaging: `<RESULT>`.
- Dependency resolution/provenance, local/private overrides and server-provided APIs: `<RESULT>`.
- UI/components/themes/CSS/icons/browser and visual exposure: `<RESULT>`.
- Data/ORM/SQL/transactions, identity/SSO and configuration/secrets references: `<RESULT>`.
- Runtime/OS/architecture/native/Windows/Linux constraints: `<RESULT>`.
- Build health/test framework/counts/coverage/runtime baseline availability: `<RESULT>`.
- Migration surface/coupling and complexity rationale: `<RESULT>`.
- Automation/manual boundaries, blockers, risks and required gates: `<RESULT>`.
- Engineering best/likely/high hours and days, hours/day convention and shared-cost allocation: `<ESTIMATE>`.
- Agent/tool execution/elapsed estimate separately: `<ESTIMATE>`.
- Evidence/confidence/unknowns: `<EVIDENCE_REF>` / `<CONFIDENCE>` / `<ACTION>`.

## Counts and estimate reconciliation

| Metric | Value or UNKNOWN | Method/exclusions | Evidence/confidence |
|---|---|---|---|
| Modules/deployables/languages | `<COUNT_OR_UNKNOWN>` | `<METHOD>` | `<EVIDENCE_REF>` / `<CONFIDENCE>` |
| Java/UI/config/test physical LOC | `<COUNT_OR_UNKNOWN>` | Separate generated/vendor/docs; include blanks/comments only if stated | `<EVIDENCE_REF>` / `<CONFIDENCE>` |
| Maintained tests/coverage | `<COUNT_OR_UNKNOWN>` | Test discovery != execution != coverage | `<EVIDENCE_REF>` / `<CONFIDENCE>` |
| Shared/cross-cutting engineering work | `<ESTIMATE>` | Allocate once across modules | `<EVIDENCE_REF>` / `<CONFIDENCE>` |

Totals must reconcile with `assessment-report.md` and `migration-plan.md`; do not add module/workstream views together.
