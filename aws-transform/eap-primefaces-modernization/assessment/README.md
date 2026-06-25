# Phase 1: Assessment Transformer

This AWS Transform custom definition assesses the modernization effort before code migration.

It should produce an assessment report with:

- Current application inventory
- Migration work breakdown
- Risk and complexity assessment
- Estimated AWS Transform agent minutes
- Estimated AWS Transform migration cost in USD
- Estimated human review and test time
- Cost formula using the current AWS Transform agent-minute price
- Go/no-go notes for the migration phase

It must not modernize the application code.

## Recommended Per-Version Assessment

```bash
make assessments-publish
make assessments-run
make assessments-validate
```

This produces:

```text
aws-transform/eap-primefaces-modernization/reports/01-primefaces-7-assessment.md
aws-transform/eap-primefaces-modernization/reports/02-primefaces-8-assessment.md
aws-transform/eap-primefaces-modernization/reports/03-primefaces-10-assessment.md
aws-transform/eap-primefaces-modernization/reports/04-primefaces-11-assessment.md
aws-transform/eap-primefaces-modernization/reports/05-primefaces-12-assessment.md
aws-transform/eap-primefaces-modernization/reports/06-primefaces-13-assessment.md
aws-transform/eap-primefaces-modernization/reports/07-primefaces-14-assessment.md
aws-transform/eap-primefaces-modernization/reports/08-primefaces-15-jakarta-assessment.md
```

Run a single version estimate when needed:

```bash
make pf7-assessment-run
make pf8-assessment-run
make pf10-assessment-run
make pf11-assessment-run
make pf12-assessment-run
make pf13-assessment-run
make pf14-assessment-run
make pf15-assessment-run
```

Each report includes low / expected / high agent minutes, AWS Transform price, human effort, QA effort, and calendar duration. As of 2026-06-24, AWS Transform custom pricing is USD 0.035 per agent minute; check current AWS pricing before relying on the estimate.
