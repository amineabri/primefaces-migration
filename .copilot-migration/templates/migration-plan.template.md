# Proposed migration plan: `<PROJECT_NAME>`

| Control | Value |
|---|---|
| Run / revision / recorded time | `<MIGRATION_ID>` / `<PLAN_REVISION>` / `<TIMESTAMP_UTC>` or UNKNOWN |
| Assessment/evidence snapshot | `<EVIDENCE_REF>` / `<CHECKPOINT_REF>` |
| Plan approval | NOT_REQUESTED until owner/record/scope/time is present |
| Execution authorization | None from plan creation or approval |
| In-scope / excluded changes | `<SCOPE>` / `<EXCLUSIONS>` |
| Source -> target constraints | `<RESULT>` |
| Preserved behavior/deployment invariants | `<RESULT>` |

## Dynamic phase graph

Generate IDs from the actual assessment. Repeat rows; no preset stage count, version ladder or category order. Validate unique IDs, existing dependency references and acyclicity.

| Phase/category | Objective/source -> target | Modules/findings | Depends on | Mandatory decisions/gates | Owner | Engineering best/likely/high / confidence |
|---|---|---|---|---|---|---|
| `<PHASE_ID>` / `<CATEGORY>` | `<RESULT>` | `<MODULE_ID>` / `<FINDING_ID>` | `<PHASE_DEPENDENCIES>` | `<GATE_ID>` / `<RESULT>` | `<OWNER>` | `<ESTIMATE>` / `<CONFIDENCE>` / `<EVIDENCE_REF>` |

Graph and order rationale: `<RESULT>`. Intermediate compatibility evidence: `<EVIDENCE_REF>`. Identify atomic Java/namespace/framework/runtime changes and sub-gates; expected intermediate diagnostics do not become passing checkpoints.

## Phase specification: `<PHASE_ID>` (repeat per phase)

| Field | Required content |
|---|---|
| Objective/category/scope | `<RESULT>` |
| Baseline/source/target matrix | Actual build-JVM/toolchain/bytecode/framework/platform/runtime/theme constraints |
| Modules/files and findings | `<MODULE_ID>` / actual paths / `<FINDING_ID>` |
| Prerequisites and authorization | Prior gates, owner decisions, artifact/environment access and exact permission scope |
| Before-checkpoint / rollback | Recoverable revision/dirty patch, matched artifact/runtime/config/data/session procedure; unknown -> blocker |
| Changes and evidence | Minimal justified dependency/API/config/UI edits; exact release evidence |
| Build/test loop | Discovered `<BUILD_COMMAND>` / `<TEST_COMMAND>` with directories; affected-consumer coverage; NO TESTS handling |
| Static validation | `<STATIC_COMMAND>` or inspection, expected packaging/API/descriptors and evidence |
| Runtime/functional gate | Environment/product identity and semantic assertions; availability/permission explicitly checked |
| Theme/browser gate | Concrete theme/default/resources/CSS, visual baseline, required browser products and support decisions |
| Namespace/session/data gate | Atomic boundaries, compatibility, drain/invalidation/restore or verified migration strategy |
| Completion criteria | Required gate statuses, checkpoint, log/state/evidence; no inferred success |
| Failure/stop/conditional policy | Bounded in-scope remediation, manual decisions, explicit deferral approval/follow-up |
| After-checkpoint/evidence | Artifact identity and attempt manifest; preserve failures |
| Estimates | Engineering hours/days, separate agent/tool elapsed range, confidence/assumptions |

Gate records: `<GATE_ID>`, category, required flag, measurable criteria, environment, evidence, counts where applicable, owner and exception policy. Use the state field contract in `instructions/migration.instructions.md` relative to the toolkit root.

## Cost, risk and scheduling

| View (repeat rows) | Best | Most likely | High risk | Unit / confidence / evidence / assumptions |
|---|---|---|---|---|
| Total engineering | `<ESTIMATE>` | `<ESTIMATE>` | `<ESTIMATE>` | Hours and days at declared `<HOURS_PER_DAY>` |
| Module allocation: `<MODULE_ID>` | `<ESTIMATE>` | `<ESTIMATE>` | `<ESTIMATE>` | Shared work allocated once |
| Workstream allocation: `<WORKSTREAM>` | `<ESTIMATE>` | `<ESTIMATE>` | `<ESTIMATE>` | Same total from a different view |
| Agent/tool execution | `<ESTIMATE>` | `<ESTIMATE>` | `<ESTIMATE>` | Separate elapsed unit/cache/concurrency assumptions |
| Delivery window | `<ESTIMATE>` | `<ESTIMATE>` | `<ESTIMATE>` | QA/environment waits, not active engineering |

Totals reconciliation, blockers/external dependencies, risks, owners and contingency: `<RESULT>`.

## Acceptance and optional operations

Define actual required build/test/static/runtime/functional/visual/browser/session/rollback criteria. Add operations only if relevant, with immutable release, real TLS, health/replacement, monitoring, cutover/rollback and handover criteria. Target acceptance and production decisions remain separate.

## Approval gate

Plan owner/revision/scope/record/time: `<OWNER>` / `<EVIDENCE_REF>` or NOT_REQUESTED.

First eligible proposed phase: `<PHASE_ID>`.

**PLAN PROPOSED - NOT EXECUTED. Stop and request authorization for exactly one phase.**
