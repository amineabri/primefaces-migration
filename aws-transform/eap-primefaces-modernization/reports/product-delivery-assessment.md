# PrimeFaces Modernisation - Product Delivery Assessment

Project: `primefaces-6.2.30`

Date: 2026-06-24

Audience: Product Manager, Delivery Manager, Engineering Lead, QA Lead

## Executive Summary

This application is small and well-contained: 6 XHTML pages, 11 Java source files, 1 Java file with PrimeFaces imports, Gradle build files, Docker Compose, and a JBoss EAP deployment setup.

The recommended migration route is staged by PrimeFaces version so each version jump can be tested before continuing. The generated assessments show that the PrimeFaces-only stages are low effort. The final stage, PrimeFaces 15.0.16 with Jakarta + JBoss EAP 8.1 + Java 21, is the highest-risk stage because it changes the runtime platform, Java namespace, descriptors, Docker image, and build toolchain.

Expected AWS Transform agent cost for the full staged migration is approximately **$6.89**. The real delivery cost is team time: expected total human effort is approximately **38.5 hours**, plus normal agile overhead, release coordination, environment delays, and any defect retesting.

Recommended delivery plan: **2 two-week sprints**, with one optional hardening buffer if the EAP 8.1 / Java 21 container work exposes environment issues.

## Scope

Included:

- PrimeFaces staged migration from 6.2.30 to 15.0.16.
- Final Jakarta + JBoss EAP 8.1 + Java 21 stage from the generated PF15 assessment.
- Engineering review effort.
- QA effort.
- AWS Transform agent-minute cost.
- Sprint-level delivery plan.
- Product-facing risks and decision points.

Excluded:

- New business functionality.
- Authentication or authorization changes.
- Database changes.
- REST APIs, microservices, messaging, monitoring, CI/CD, or Kubernetes.
- Production operational cost outside the migration work.

## Evidence Used

This document uses the generated assessment outputs in:

- `01-primefaces-7-assessment.md`
- `02-primefaces-8-assessment.md`
- `03-primefaces-10-assessment.md`
- `04-primefaces-11-assessment.md`
- `05-primefaces-12-assessment.md`
- `06-primefaces-13-assessment.md`
- `07-primefaces-14-assessment.md`
- `08-primefaces-15-jakarta-assessment.md`

PrimeFaces does not have a normal public 9.x migration stage in this path, so the generated plan moves from PrimeFaces 8.0 to 10.0.0.

## Overall Cost And Effort

| Scenario | AWS Transform Agent Minutes | AWS Transform Cost | Human Delivery Effort | Raw Calendar Duration |
| --- | ---: | ---: | ---: | ---: |
| Low | 121 | $4.26 | 25.5 hours | 10 business days |
| Expected | 196 | $6.89 | 38.5 hours | 12 business days |
| High | 312 | $10.93 | 59 hours | 18 business days |

AWS Transform cost formula:

```text
AWS Transform cost = estimated agent minutes * $0.035
```

Local builds, local file reads, manual QA, user idle time, product review, and agile ceremonies are not charged as AWS Transform agent minutes.

## People Cost Model

Use your blended delivery team day rate to convert human effort into a budget figure.

Assumption: 1 working day = 7.5 hours.

| Scenario | Human Effort | Working Days | At 600/day | At 800/day | At 1,000/day |
| --- | ---: | ---: | ---: | ---: | ---: |
| Low | 25.5h | 3.4 days | 2,040 | 2,720 | 3,400 |
| Expected | 38.5h | 5.1 days | 3,080 | 4,107 | 5,133 |
| High | 59h | 7.9 days | 4,720 | 6,293 | 7,867 |

Add the AWS Transform agent cost separately. The AWS Transform cost is negligible compared with delivery team time; the delivery decision should be driven by QA capacity, EAP/Jakarta risk, and sprint scheduling rather than agent-minute spend.

## Stage Breakdown

| Stage | Expected Agent Cost | Expected Human Effort | Expected Duration | Delivery Risk | Main Product Concern |
| --- | ---: | ---: | ---: | --- | --- |
| PF 6.2.30 to 7.0 | $0.53 | 3h | 1 day | Low | Basic UI smoke test |
| PF 7.0 to 8.0 | $0.88 | 3h | 1 day | Low-Medium | Upload, date picker, table sort/filter |
| PF 8.0 to 10.0.0 | $0.88 | 5h | 1 day | Medium | CSS/theme checks, file upload, data export |
| PF 10.0.0 to 11.0.0 | $0.42 | 3h | 1 day | Low | Visual regression |
| PF 11.0.0 to 12.0.0 | $0.49 | 3h | 1 day | Low-Medium | DataExporter, file upload, text editor |
| PF 12.0.0 to 13.0.0 | $0.88 | 3h | 1 day | Medium | FileUpload API and Java/runtime compatibility check |
| PF 13.0.0 to 14.0.0 | $0.88 | 6.5h | 1-2 days | Medium | Growl/calendar changes and UI regression |
| PF 14.0.0 to 15.0.16 + EAP 8.1 | $1.93 | 12h | 3-5 days | Medium-High | Jakarta namespace, Java 21, Docker/EAP deployment |

## Sprint Plan

Recommended plan for 2-week sprints:

| Sprint | Scope | Target Outcome | Acceptance Gate |
| --- | --- | --- | --- |
| Sprint 1 | PF 6.2.30 to PF 12.0.0 | Application runs on the current Java EE/JBoss baseline with PrimeFaces 12 | All pages render, navigation works, data tables sort/filter, upload/export/editor checked |
| Sprint 2 | PF 13.0.0 to PF 15.0.16 Jakarta + EAP 8.1 / Java 21 | Application runs on the modern Jakarta/EAP/Java baseline | Docker build, EAP deployment, no `javax.*` leakage, full UI smoke test passes |
| Optional buffer | Hardening and release readiness | Fix defects, visual polish, release notes, final retest | QA sign-off and release candidate approved |

Alternative conservative plan:

- Sprint 1: PF 7, PF 8, PF 10.
- Sprint 2: PF 11, PF 12, PF 13, PF 14.
- Sprint 3: PF 15 + Jakarta + EAP 8.1 + Java 21.

The conservative plan is easier for stage-by-stage QA sign-off. The 2-sprint plan is realistic for this small demo application if the team can test several PrimeFaces stages inside one sprint.

## Product Risks

| Risk | Product Impact | Likelihood | Impact | Mitigation |
| --- | --- | --- | --- | --- |
| EAP 8.1 image/subscription access | Final migration could be delayed | Medium | High | Confirm Red Hat registry access before Sprint 2 |
| Gradle wrapper and Java 21 compatibility | Build may need toolchain work | Medium | Medium | Upgrade Gradle early in PF15 stage |
| Jakarta namespace migration | Runtime failures if any `javax.*` remains | Medium | Medium | Scan source and built WAR for `javax.` |
| PrimeFaces file upload API changes | Upload demo may fail | Medium | Medium | Test upload every stage from PF8 onward |
| `p:calendar` to `p:datePicker` changes | Date input behaviour may differ | Medium | Low | QA date picker selection and formatting |
| `p:growl` replacement | Feedback messages could change visually | Medium | Low | Use `p:messages` and verify validation feedback |
| CSS/theme drift | UI may look different across PF versions | Low-Medium | Low | Visual smoke test all 6 pages at each stage |

## QA Regression Pack

Minimum QA checks at each stage:

- Home page loads at root context.
- Shared navigation works across Home, Dashboard, Employees, Reports, and Elements.
- Data tables render, sort, filter, paginate, expand rows where used, and export.
- Form validation messages display correctly.
- AJAX status, command buttons, command links, reset input, confirm dialog, and growl/messages work.
- File upload works and the managed bean receives file metadata/content.
- Date input opens, selects, submits, and displays correctly.
- AutoComplete suggestions render and select correctly.
- TextEditor renders and submits content.
- Dialog, poll, progress bar, and menu components render without browser console errors.
- Docker container starts and serves the app after the final EAP/Jakarta stage.

## Delivery Decision

Recommendation: **Proceed with staged migration.**

For Product planning, treat this as a small modernisation project with low AWS Transform cost and modest delivery-team effort. The main decision point is not PrimeFaces itself; it is the final runtime move to JBoss EAP 8.1, Jakarta EE 10, and Java 21.

Recommended commitment:

- Fund 2 sprints.
- Confirm EAP 8.1 image access before starting the final stage.
- Keep a small hardening buffer available if Java 21, Gradle, Docker, or Jakarta deployment issues appear.

## Next Actions

1. Confirm the blended delivery day rate for the financial forecast.
2. Confirm Red Hat EAP 8.1 container image access.
3. Decide whether Product wants the 2-sprint plan or the more conservative 3-sprint plan.
4. Start migration with PF 6.2.30 to PF 7.0.
5. Require QA sign-off before each subsequent version jump.

## Source Reports

The detailed technical assessments remain in:

```text
aws-transform/eap-primefaces-modernization/reports/
```
