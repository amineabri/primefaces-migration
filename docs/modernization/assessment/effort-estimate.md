# Effort Estimate

## Basis and Definitions

Numerical totals use the repository's existing AWS Transform-style stage reports and `reports/product-delivery-assessment.md` (dated 2026-06-24) as the primary estimate baseline. Figures are estimates, not measured execution. One engineering day is **7.5 person-hours**.

The original aggregate human-effort estimates are 25.5 / 38.5 / 59 hours for best / expected / high-risk. The source provides expected human effort per stage and stage-level AWS Transform agent minutes; it does not consistently provide low/high human effort per stage. The stage low/high values below are a proportional allocation of the published aggregate to expected stage effort. They are planning allocations, not figures quoted from the original reports. Confidence in stage low/high allocation is LOW.

## ENGINEERING EFFORT

| Scenario | Engineering hours | Engineering days | Confidence | Evidence |
|---|---:|---:|---|---|
| Best case | **25.5 h** | **3.4 days** | LOW-MEDIUM | Published aggregate low estimate; assumes clean mechanical edits and few regressions |
| Most likely | **38.5 h** | **5.1 days** | MEDIUM-LOW | Published expected total and expected stage breakdown; includes developer review and QA |
| High-risk | **59 h** | **7.9 days** | LOW | Published aggregate high estimate; assumes build/image friction, regressions and retesting |

### Stage-by-Stage Engineering Estimate (Additive)

Expected human values are taken from the previous product-delivery assessment and sum to 38.5 hours. Low/high human allocations are proportional to expected stage hours and sum to the aggregate. Agent minutes are a separate estimate.

| Stage | Best engineering (h / days) | Most likely engineering (h / days) | High-risk engineering (h / days) | Agent minutes (low / expected / high) | Automation potential | Confidence | Main dependency / risk |
|---|---:|---:|---:|---:|---|---|---|
| Baseline preparation and PF 6.2.30 → 7 | 1.99 / 0.27 | 3 / 0.40 | 4.60 / 0.61 | 10 / 15 / 25 | HIGH for version edit | MEDIUM expected; LOW ranges | Baseline build and PF artifact; date/table/theme checks |
| PF 7 → 8 | 1.99 / 0.27 | 3 / 0.40 | 4.60 / 0.61 | 15 / 25 / 40 | HIGH for catalog; MEDIUM API | MEDIUM expected; LOW ranges | File-upload/date APIs |
| PF 8 → 10 | 3.31 / 0.44 | 5 / 0.67 | 7.66 / 1.02 | 15 / 25 / 40 | MEDIUM | MEDIUM expected; LOW ranges | API, uploader setting and theme validation |
| PF 10 → 11 | 1.99 / 0.27 | 3 / 0.40 | 4.60 / 0.61 | 8 / 12 / 20 | HIGH for version edit | MEDIUM expected; LOW ranges | Visual/client-side regression |
| PF 11 → 12 | 1.99 / 0.27 | 3 / 0.40 | 4.60 / 0.61 | 8 / 14 / 22 | MEDIUM | MEDIUM expected; LOW ranges | Exporter, upload and editor behavior |
| PF 12 → 13 | 1.99 / 0.27 | 3 / 0.40 | 4.60 / 0.61 | 15 / 25 / 40 | MEDIUM | MEDIUM expected; LOW ranges | File-upload API and table/export |
| PF 13 → 14 | 4.31 / 0.57 | 6.5 / 0.87 | 9.96 / 1.33 | 15 / 25 / 40 | MEDIUM | MEDIUM expected; LOW ranges | Calendar/messages and visual regression |
| PF 14 → 15 Jakarta + EAP 8.1 / Jakarta EE 10 / Java 21 | 7.93 / 1.06 | 12 / 1.60 | 18.38 / 2.45 | 35 / 55 / 85 | MEDIUM for mechanical changes; LOW-MEDIUM overall | LOW-MEDIUM expected; LOW ranges | Target API/artifact, image entitlement, descriptors and deployment |
| **Total** | **25.50 / 3.40** | **38.5 / 5.13** | **59.00 / 7.87** | **121 / 196 / 312** | — | **MEDIUM-LOW overall** | — |

Per-row day values are rounded; totals derive from unrounded hours and 7.5 hours/day. The final-stage value includes Jakarta conversion, descriptors, Java/build/dependency changes, EAP image/deployment and final QA; do not add the crosscutting breakdown below to this table.

### Cross-Cutting Workstream Breakdown (Included Within Stage Totals)

The following work packages answer the requested effort categories. They are **subsets of the stage estimates above and are not additive**. Each range is an engineering planning allocation with separate confidence; the individual rows should not be summed.

| Workstream | Best (h / days) | Most likely (h / days) | High-risk (h / days) | Automation potential | Confidence | Dependencies | Risk |
|---|---:|---:|---:|---|---|---|---|
| Baseline preparation | 0.5 / 0.07 | 1 / 0.13 | 1.5 / 0.20 | LOW-MEDIUM | LOW | Current build and app access | Baseline environment unavailable |
| Build stabilization | 0.5 / 0.07 | 1 / 0.13 | 2 / 0.27 | MEDIUM | LOW-MEDIUM | Java 21 and Gradle wrapper | Toolchain/build failure |
| Java 8 → Java 21 upgrade | 0.5 / 0.07 | 1 / 0.13 | 2 / 0.27 | MEDIUM | LOW-MEDIUM | JDK and Gradle | Runtime/build mismatch |
| PF 6.2.30 → 7 | 1 / 0.13 | 2 / 0.27 | 3 / 0.40 | HIGH | MEDIUM | Baseline | Table/date/theme regression |
| PF 7 → 8 | 1 / 0.13 | 2 / 0.27 | 4 / 0.53 | HIGH | MEDIUM | Prior stage gate | Upload/date API behavior |
| PF 8 → 10 | 2 / 0.27 | 4 / 0.53 | 7 / 0.93 | MEDIUM | MEDIUM | Prior stage gate | API/uploader/theme changes |
| PF 10 → 11 | 1 / 0.13 | 2 / 0.27 | 3 / 0.40 | HIGH | MEDIUM | Prior stage gate | Client/visual regression |
| PF 11 → 12 | 1 / 0.13 | 2 / 0.27 | 4 / 0.53 | MEDIUM | MEDIUM | Prior stage gate | Export/upload/editor behavior |
| PF 12 → 13 | 1 / 0.13 | 2 / 0.27 | 4 / 0.53 | MEDIUM | MEDIUM | Prior stage gate | Upload/table/export |
| PF 13 → 14 | 2 / 0.27 | 4 / 0.53 | 7 / 0.93 | MEDIUM | MEDIUM-LOW | Prior stage gate | Date/messages/theme regression |
| PF 14 → 15 Jakarta PrimeFaces changes | 1 / 0.13 | 2 / 0.27 | 4 / 0.53 | MEDIUM | LOW-MEDIUM | PF14 gate; target artifact | API/tag incompatibility |
| `javax` → `jakarta` source conversion | 0.5 / 0.07 | 1.5 / 0.20 | 2 / 0.27 | HIGH mechanical | MEDIUM | Jakarta API coordinate | Residual mixed namespace |
| Descriptor changes | 0.5 / 0.07 | 1 / 0.13 | 2 / 0.27 | HIGH for literal edits | MEDIUM | EAP schema support | Deployment rejection |
| EAP 8.1 migration | 1 / 0.13 | 2 / 0.27 | 5 / 0.67 | LOW-MEDIUM | LOW | Registry, image, architecture | Image access/startup |
| Dependency changes | 0.5 / 0.07 | 1 / 0.13 | 2 / 0.27 | HIGH | MEDIUM | Exact API/PF coordinates | Wrong artifact or scope |
| Source/API remediation | 0.5 / 0.07 | 1.5 / 0.20 | 3 / 0.40 | MEDIUM | LOW-MEDIUM | Exact target APIs | Signature/behavior change |
| Configuration changes | 0.5 / 0.07 | 1 / 0.13 | 2 / 0.27 | MEDIUM-HIGH | MEDIUM | Descriptors and image decision | Inconsistent configuration |
| Test remediation / evidence preparation | 0.5 / 0.07 | 1 / 0.13 | 2 / 0.27 | LOW | LOW | QA availability | No automated coverage |
| Regression testing | 3 / 0.40 | 7 / 0.93 | 12 / 1.60 | LOW-MEDIUM | LOW-MEDIUM | Running stage artifacts and test environment | UI regressions escape |
| Deployment validation | 1 / 0.13 | 2 / 0.27 | 5 / 0.67 | LOW | LOW | EAP 8.1 image access | Target runtime mismatch |

## AGENT EXECUTION ESTIMATE

These are estimated AWS Transform agent minutes from the prior stage reports, not engineering person-hours. No AWS Transform run was executed for this assessment.

| Scenario | Agent minutes | Agent-hours equivalent | Confidence | Basis |
|---|---:|---:|---|---|
| Best | **121** | 2.0 | LOW | Sum of reported low-stage agent estimates |
| Most likely | **196** | 3.3 | LOW-MEDIUM | Sum of reported expected-stage agent estimates |
| High-risk | **312** | 5.2 | LOW | Sum of reported high-stage agent estimates |

Existing stage inputs: 10/15/25, 15/25/40, 15/25/40, 8/12/20, 8/14/22, 15/25/40, 15/25/40, and 35/55/85 minutes. Historic AWS cost calculation uses $0.035 per agent-minute dated 2026-06-24; verify current AWS pricing before budgeting.

## EXPECTED CALENDAR / VALIDATION TIME

| Scenario | Elapsed calendar estimate | Confidence | Basis |
|---|---:|---|---|
| Best | **10 business days** | LOW | Existing aggregate estimate; staged QA gates |
| Most likely | **12 business days** | LOW | Existing aggregate estimate; review, QA and environment coordination |
| High-risk | **18 business days** | LOW | Existing aggregate estimate; defects, blockers and repeat validation |

Calendar days are not person-days or agent runtime. Stage gates, target image access and QA throughput determine elapsed duration.
