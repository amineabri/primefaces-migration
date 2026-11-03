# Modernization Effort Estimate

**Assessment date:** 2026-10-27  
**Scope:** Staged migration from PrimeFaces 6.2.30 / Java EE 8 / EAP 7.3 / Java 8 to PrimeFaces 15.0.16 Jakarta / Jakarta EE 10 / EAP 8.1 / Java 21. Estimates include staged QA checkpoints and exclude feature work, production data migration, security/authentication additions, infrastructure provisioning, release waiting time, and agile ceremony overhead.

## Summary estimate

Engineering effort is measured in person-hours and person-days. One working day is **7.5 hours**. The project is one deployable Gradle module, so the project-level estimate equals the complete migration estimate.

| Scenario | Engineering/team effort | Working days | Confidence | Basis |
|---|---:|---:|---|---|
| Best case | **25.5 hours** | **3.4 days** | Low-medium | Sum of low estimates in the existing staged assessment/product-delivery report; assumes mechanical changes and few regressions |
| Most likely | **38.5 hours** | **5.1 days** | Medium-low | Existing product-delivery assessment expected total; assumes targeted fixes plus human review and functional QA at each gate |
| High risk | **59 hours** | **7.9 days** | Low | Existing high scenario; assumes multiple UI/runtime regressions, toolchain/image friction, and repeat QA |

**Project-by-project:** `primefaces-homeoffice` — best case 25.5 hours / 3.4 days; most likely 38.5 hours / 5.1 days; high risk 59 hours / 7.9 days. Confidence and evidence are the same as the summary above. There are no independent subprojects to estimate.

These totals are delivery-team person-hours (developer implementation/review plus QA) based on the existing product-delivery estimate. They are not elapsed calendar time and are not AWS Transform execution minutes.

## Workstream-by-workstream estimate

The following allocation partitions the most-likely effort across the work areas identified in repository code and staged recipes. Low/most-likely/high values sum to the project totals. These allocations are planning estimates, not measured durations.

| Workstream | Best case (h) | Most likely (h) | High risk (h) | Confidence | Evidence / main uncertainty |
|---|---:|---:|---:|---|---|
| PrimeFaces version steps and UI/API adjustments (6.2.30 through 14) | 7 | 11 | 16 | Medium-low | Eight staged definitions/reports; one Elements page has upload, calendar, table, exporter, editor, and other controls |
| Jakarta namespace and Java EE descriptor conversion | 4 | 6 | 9 | Medium | Five Java files use `javax.*`; three XML descriptors plus Faces configuration need coordinated conversion |
| Java 21 and Gradle/dependency alignment | 2 | 3 | 5 | Low-medium | Java 8 source/target, wrapper 8.4, provided Java EE 8 API, and target API/artifact coordinates; no Java 21 build run |
| EAP 8.1 container, Compose, and Linux deployment | 2 | 4 | 7 | Low-medium | Current EAP 7.3 OpenJDK 8 image and amd64-only Compose configuration; target registry access and deployment unverified |
| Functional regression, visual checks, and defect retest | 8 | 12 | 18 | Medium-low | Existing stage QA estimates and broad component showcase; no automated behavioral test suite |
| Integration, acceptance evidence, and final release validation | 2.5 | 2.5 | 4 | Low | Includes cross-stage build/deployment checks and QA sign-off; actual environment/release process is unknown |
| **Total** | **25.5** | **38.5** | **59** | **Medium-low overall** | Matches the existing product-delivery assessment range |

## Separate AWS Transform execution and elapsed estimates

These figures describe the migration agent's estimated execution budget, not engineering person-hours. The staged reports list per-stage agent minutes totaling the values below. The AWS Transform run itself was not invoked for this assessment.

| Scenario | Estimated agent execution | Estimated elapsed calendar duration | Confidence | Evidence |
|---|---:|---:|---|---|
| Best case | **121 minutes** (2.0 agent-hours) | **10 business days** | Low | Sum of low estimates across eight existing stage reports; calendar figure inherited from the product-delivery assessment |
| Most likely | **196 minutes** (3.3 agent-hours) | **12 business days** | Low-medium for agent minutes; low for calendar | Sum of expected agent-minute estimates; calendar includes staged QA gates and is not elapsed wall time observed in a run |
| High risk | **312 minutes** (5.2 agent-hours) | **18 business days** | Low | Sum of high agent-minute estimates; calendar contingency reflects iterations and external runtime/image delays |

Calendar duration is a planning window for sequential stage execution with QA gates, not time spent continuously by an engineer or agent. It excludes user/approval wait time and may change substantially with environment availability.

## Per-stage estimate basis

The following per-stage expected effort is reproduced from `aws-transform/eap-primefaces-modernization/reports/product-delivery-assessment.md`. Stage effort combines developer and QA human effort; stage agent minutes are estimated AWS Transform execution.

| Stage | Expected agent minutes | Expected human effort | Main work |
|---|---:|---:|---|
| PF 6.2.30 → 7.0 | 15 | 3 h | Version update and baseline component smoke test |
| PF 7.0 → 8.0 | 25 | 3 h | Upload API, date input, table attributes, component checks |
| PF 8.0 → 10.0.0 | 25 | 5 h | API adjustments, uploader setting, theme and UI checks |
| PF 10.0.0 → 11.0.0 | 12 | 3 h | Dependency update and visual/behavior check |
| PF 11.0.0 → 12.0.0 | 14 | 3 h | Export, upload, editor, table and client-library checks |
| PF 12.0.0 → 13.0.0 | 25 | 3 h | File-upload API and component regressions |
| PF 13.0.0 → 14.0.0 | 25 | 6.5 h | Deprecated component changes, tables, theme and UI regression |
| PF 14.0.0 → PF 15.0.16 Jakarta + EAP 8.1 | 55 | 12 h | Jakarta namespace, Java 21, Gradle, descriptors, image and deployment |
| **Total** | **196** | **38.5 h** | Eight gated stages |

## Confidence and assumptions

- **High confidence** in the project count and size indicators: one Gradle project, 11 Java sources, six XHTML files, three descriptors, and no tracked test source tree or CI pipeline.
- **Medium confidence** in scope: repository files and its own staged recipes consistently describe the source and target platforms. Exact compatibility still needs validation with the chosen artifact versions and target server.
- **Medium-low confidence** in the most-likely engineering estimate: it is grounded in eight pre-existing stage estimates, but those were authored 2026-06-24 and have not been recalibrated by a fresh assessment run.
- **Low confidence** in exact calendar duration and high-risk estimates: environment provisioning, registry access, QA throughput, and test environment reliability are unknown.
- The assessment assumes the app remains a sample WAR with existing pages and static/sample data. It does not include new functions, authentication, database/ORM, REST, messaging, observability, CI/CD, Kubernetes, or infrastructure-as-code.
- AWS Transform pricing and agent-minute cost were intentionally not converted to currency: the repository's rate statement is dated 2026-06-24 and should be checked against current AWS pricing before budgeting.
