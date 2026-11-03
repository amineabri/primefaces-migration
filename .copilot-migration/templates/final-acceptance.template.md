# Acceptance record: `<PROJECT_NAME>`

> Unexecuted template. Do not prefill acceptance counts or passing outcomes. Append each real attempt and preserve failed/provisional evidence.

## Candidate, authority and environment

| Item | Actual value or UNKNOWN |
|---|---|
| Run / phase / attempt | `<MIGRATION_ID>` / `<PHASE_ID>` / `<ATTEMPT_ID>` |
| Authorization / scope / owner | `<EVIDENCE_REF>` / `<SCOPE>` / `<OWNER>` |
| Snapshot / artifact / checksum | `<CHECKPOINT_REF>` / `<WAR_NAME>` if applicable / `<EVIDENCE_REF>` |
| Intended vs actual runtime/JVM/patch/configuration | `<TARGET_RUNTIME>` / `<RESULT>` |
| Environment/endpoint/OS/architecture/topology | `<ENVIRONMENT_ID>` / `<RESULT>` |
| UTC observations / report time | `<TIMESTAMP_UTC>` or UNKNOWN |
| Harness/criteria version and raw evidence manifest | `<EVIDENCE_REF>` |

## Layered results

Repeat rows for actual criteria. Gate statuses: UNKNOWN / NOT_RUN / PASS / FAIL / BLOCKED / DEFERRED / NO_TESTS / NOT_APPLICABLE, with rationale.

| Gate/layer | Required assertion | Observed status | Command/counts/semantic result | Environment/evidence | Residual risk/action |
|---|---|---|---|---|---|
| Build/package | Actual build/toolchain/bytecode/dependencies/artifact | UNKNOWN | `<RESULT>` | `<EVIDENCE_REF>` | `<ACTION>` |
| Maintained tests | Discovery/execution/coverage | UNKNOWN | Counts UNKNOWN until observed | `<EVIDENCE_REF>` | Empty task is not behavioral coverage |
| Static compatibility | Used API/tag/descriptor/namespace/package checks | UNKNOWN | `<RESULT>` | `<EVIDENCE_REF>` | Static != runtime |
| Deployment/init | Real product, application initialization/resources/content/logs | NOT_RUN | `<RESULT>` | `<EVIDENCE_REF>` | Missing target means BLOCKED |
| Functional | Actual critical journeys/assertions from inventory | NOT_RUN | `<RESULT>` | `<EVIDENCE_REF>` | Do not invent absent features |
| Theme/visual | Explicit resources, baseline comparison and approved differences | NOT_RUN | `<RESULT>` | `<EVIDENCE_REF>` | Missing baseline != equivalence |
| Browser | Required products/versions/OS and engine limitations | NOT_RUN | `<RESULT>` | `<EVIDENCE_REF>` | Untested remains NOT TESTED |
| Session/cutover | Actual state storage, stale views, drain/invalidation/migration | NOT_RUN | `<RESULT>` | `<EVIDENCE_REF>` | Cookie clearing != server logout |
| Rollback | Actual compatible package and reverse-deploy rehearsal | UNKNOWN | `<RESULT>` | `<EVIDENCE_REF>` | Source checkpoint/replacement != previous-release restore |

## Validation counts and interpretation

| Suite/run/environment | Discovered/executed/pass/fail/skip | Counted unit / denominator | Evidence / exclusions |
|---|---|---|---|
| `<RESULT>` | UNKNOWN until observed | Maintained tests vs grouped acceptance assertions | `<EVIDENCE_REF>` |

Selected final runs vs all attempts: `<RESULT>`. Preserve initial failures and corrected harness versions. Do not claim a global pass rate from selected successful retries.

## Product and residual risk register

| Risk/gap | Status | Owner/acceptance record | Follow-up |
|---|---|---|---|
| Actual required browser products not exercised | UNKNOWN | `<OWNER>` / `<EVIDENCE_REF>` | `<ACTION>` |
| Formal accessibility | UNKNOWN | `<OWNER>` / `<EVIDENCE_REF>` | `<ACTION>` |
| Mobile/responsive/visual baseline | UNKNOWN | `<OWNER>` / `<EVIDENCE_REF>` | `<ACTION>` |
| Maintained behavioral suite/coverage | UNKNOWN | `<OWNER>` / `<EVIDENCE_REF>` | `<ACTION>` |
| Other findings/state/data/identity/runtime gaps | `<RESULT>` | `<OWNER>` / `<EVIDENCE_REF>` | `<ACTION>` |

## Decision

- Application migration status: `<STATUS>`.
- Actual target-runtime acceptance: `<STATUS>`.
- Production readiness: `<STATUS>` (not implied by application acceptance).
- Acceptance decision: `<STATUS>`; choose ACCEPTED / ACCEPTED WITH APPROVED RISKS / INCOMPLETE / BLOCKED / REJECTED only after evaluating required gates.
- Approver, evidence, rationale, confidence and scope limitations: `<OWNER>` / `<EVIDENCE_REF>` / `<RATIONALE>` / `<CONFIDENCE>`.
- Current summary supersedes: `<EVIDENCE_REF>` or NOT APPLICABLE.

No promotion/production authorization is conferred by writing this report.
