# Modernization assessment: `<PROJECT_NAME>`

> Blank template. Replace tokens with fresh evidence; repeat rows as required. UNKNOWN is not a pass. No transformation is authorized by this report.

| Metadata | Value |
|---|---|
| Run / output root | `<MIGRATION_ID>` / `<RUN_ROOT>` |
| Assessed revision / dirty scope | `<CHECKPOINT_REF>` / `<EVIDENCE_REF>` |
| Assessment recorded at | `<TIMESTAMP_UTC>` or UNKNOWN |
| Scope / owner / target authority | `<SCOPE>` / `<OWNER>` / `<EVIDENCE_REF>` |
| Method / exclusions / command permissions | `<METHOD>` |

## Executive decision

| Area | Assessment | Evidence and confidence |
|---|---|---|
| Overall complexity / migration readiness | `<RESULT>` | `<EVIDENCE_REF>` / `<CONFIDENCE>` / `<RATIONALE>` |
| Linux readiness / Windows dependencies | `<RESULT>` | `<EVIDENCE_REF>` / `<CONFIDENCE>` / `<RATIONALE>` |
| Automation confidence / manual work | `<RESULT>` | `<EVIDENCE_REF>` / `<CONFIDENCE>` / `<RATIONALE>` |
| Major blockers / migration risk | `<RESULT>` | `<EVIDENCE_REF>` / `<CONFIDENCE>` / `<RATIONALE>` |
| Recommended sequence | `<RESULT>` | Proposed, not executed |

## Repository, solution and module inventory

Record all roots/builds/modules/deployables, languages and roles. Include module dependency graph, external services and shared resources. Cite `project-analysis.md`.

| Module | Path | Packaging | Source/assets physical LOC | Tests/coverage evidence | Complexity/readiness |
|---|---|---|---|---|---|
| `<MODULE_ID>` | `<MODULE_PATH>` | `<PACKAGING>` | `<COUNT_OR_UNKNOWN>` | `<EVIDENCE_REF>` | `<RESULT>` |

LOC method/exclusions: `<METHOD>`. Separate application code from wrappers, generated files, vendored code, docs and evidence.

## Source/target constraint matrix

| Surface | Declared source | Resolved/observed source | Proposed target | Authority/support evidence | Unknowns/decision owner |
|---|---|---|---|---|---|
| Java source/bytecode | `<SOURCE_JAVA_VERSION>` | `<RESULT>` | `<TARGET_JAVA_VERSION>` | `<EVIDENCE_REF>` | `<OWNER>` |
| Build JVM/toolchain/build system | `<RESULT>` | `<RESULT>` | `<RESULT>` | `<EVIDENCE_REF>` | `<OWNER>` |
| Framework / Faces / enterprise namespace | `<SOURCE_FRAMEWORK_VERSION>` / `<SOURCE_NAMESPACE>` | `<RESULT>` | `<TARGET_FRAMEWORK_VERSION>` / `<TARGET_NAMESPACE>` | `<EVIDENCE_REF>` | `<OWNER>` |
| Platform/runtime/patch | `<SOURCE_PLATFORM>` / `<SOURCE_RUNTIME>` | `<RESULT>` | `<TARGET_PLATFORM>` / `<TARGET_RUNTIME>` | `<EVIDENCE_REF>` | `<OWNER>` |
| Theme/browser requirements | `<SOURCE_THEME>` / `<RESULT>` | `<RESULT>` | `<TARGET_THEME>` / `<RESULT>` | `<EVIDENCE_REF>` | `<OWNER>` |
| Deployment/context/OS/architecture | `<RESULT>` | `<RESULT>` | `<RESULT>` | `<EVIDENCE_REF>` | `<OWNER>` |

Targets remain proposals until confirmed; do not infer missing values from this template.

## Compatibility and environmental assessment

| Workstream | Findings / required change / absence or unknown | Evidence, risk and action |
|---|---|---|
| Packages/plugins/transitives/private artifacts | `<RESULT>` | `<EVIDENCE_REF>` / `<ACTION>` |
| Unsupported/deprecated packages/replacements | `<RESULT>` | Exact release/support source and date; compatibility != vendor support |
| APIs/descriptors/taglibs/EL/client/serialization | `<RESULT>` | `<EVIDENCE_REF>` / `<ACTION>` |
| Windows-specific / Linux/native portability | `<RESULT>` | `<EVIDENCE_REF>` / `<ACTION>` |
| Database/driver/ORM/schema/transactions | `<RESULT>` | Include data migration/restore/rollback implications where present |
| Authentication/authorization/SSO/logout | `<RESULT>` | Actual application/proxy boundaries, not assumed login |
| External configuration/secrets | `<RESULT>` | References/owners only; no secrets |
| Build/deployment/provisioning | `<RESULT>` | Wrapper/JVM/toolchain, artifacts, permissions, platform, registry/runtime access |
| Maintained tests/coverage/CI/manual baseline | `<RESULT>` | Counts/freshness; empty test task != behavior coverage |
| Theme/visual/browser/accessibility/mobile | `<RESULT>` | Explicit resource/support decisions and baseline gaps |

## Baseline and runtime availability

| Check | Command/environment | Observed outcome | Evidence / limitation |
|---|---|---|---|
| Build health | `<BUILD_COMMAND>` | UNKNOWN / NOT RUN until observed | `<EVIDENCE_REF>` |
| Tests | `<TEST_COMMAND>` | UNKNOWN / NOT RUN / NO TESTS until observed | Discovered/executed/passed/failed/skipped counts or UNKNOWN |
| Runtime/product availability | `<ENVIRONMENT_ID>` | UNKNOWN until verified | Configured runtime is not observed runtime |

Record pre-existing failures separately. Unavailable original artifact -> proposed baseline reconstruction, never silent substitution or claimed equivalence.

## Prospective estimates

Engineering working-day convention: `<HOURS_PER_DAY>` hours/day, rationale `<RATIONALE>`. Unknown values remain UNKNOWN; do not select a previous project's convention.

| Scope | Best hours/days | Most-likely hours/days | High-risk hours/days | Confidence, evidence, assumptions |
|---|---|---|---|---|
| Total engineering effort | `<ESTIMATE>` | `<ESTIMATE>` | `<ESTIMATE>` | `<CONFIDENCE>` / `<EVIDENCE_REF>` / `<RATIONALE>` |
| `<MODULE_ID>` engineering allocation (repeat) | `<ESTIMATE>` | `<ESTIMATE>` | `<ESTIMATE>` | Shared-work allocation `<METHOD>` |
| `<WORKSTREAM>` engineering allocation (repeat) | `<ESTIMATE>` | `<ESTIMATE>` | `<ESTIMATE>` | Cross-view of same total, not additional effort |
| Agent/tool execution elapsed | `<ESTIMATE>` | `<ESTIMATE>` | `<ESTIMATE>` | Separate from human labor; include tooling/cache assumptions |
| Delivery/calendar window | `<ESTIMATE>` | `<ESTIMATE>` | `<ESTIMATE>` | Separate environment/QA waits and parallelism |

Reconciliation: `<METHOD>`. No observed actuals or savings inferred from these forecasts.

## Plan, risks and stop

Recommended phase graph: `<EVIDENCE_REF>` to `migration-plan.md`. List unresolved findings, blockers, responsible owners, risk acceptance required and prerequisites for the first phase.

**ASSESSMENT COMPLETE**

**Migration has NOT started.**

First proposed phase and required authorization: `<PHASE_ID>` / `<SCOPE>` / `<OWNER>`. No phase is authorized by report creation.
