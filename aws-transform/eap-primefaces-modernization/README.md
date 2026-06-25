# AWS Transform Two-Phase Modernization

This directory contains a two-phase AWS Transform custom workflow for modernizing this application from:

- JBoss EAP 7.3.x / Java EE 8 / `javax.*`
- PrimeFaces 6.2.30
- Java 8

to:

- JBoss EAP 8.1 on OpenJDK 21
- Jakarta EE 10 / `jakarta.*`
- PrimeFaces 15.0.16 Jakarta artifact
- Java 21

## Phase 1: Assessment

Purpose: estimate work, risk, time, and AWS Transform cost before changing application code.

Recommended staged assessment:

```bash
make assessments-publish
make assessments-run
make assessments-validate
```

This produces one estimate per migration stage:

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

You can also run a single stage estimate:

```bash
make pf7-assessment-publish
make pf7-assessment-run
make pf7-assessment-validate
```

Each assessment report includes low / expected / high estimates for agent minutes, AWS Transform cost, human effort, QA effort, and calendar duration. As of 2026-06-24, AWS Transform custom pricing is USD 0.035 per agent minute; check current AWS pricing before relying on the estimate.

## Phase 2: Migration

Purpose: perform one version move at a time after reviewing the matching estimate.

Recommended staged migration:

```bash
make staged-publish
make pf7-run
# QA tests PrimeFaces 7
make pf8-run
# QA tests PrimeFaces 8
make pf10-run
# QA tests PrimeFaces 10
make pf11-run
# QA tests PrimeFaces 11
make pf12-run
# QA tests PrimeFaces 12
make pf13-run
# QA tests PrimeFaces 13
make pf14-run
# QA tests PrimeFaces 14
make pf15-run
# QA tests EAP 8.1 and PrimeFaces 15 Jakarta
```

Stage mapping:

| Assessment report | Migration command | QA checkpoint |
| --- | --- | --- |
| `01-primefaces-7-assessment.md` | `make pf7-run` | PrimeFaces 7 on current EAP 7.3 |
| `02-primefaces-8-assessment.md` | `make pf8-run` | PrimeFaces 8 on current EAP 7.3 |
| `03-primefaces-10-assessment.md` | `make pf10-run` | PrimeFaces 10 on current EAP 7.3 |
| `04-primefaces-11-assessment.md` | `make pf11-run` | PrimeFaces 11 on current EAP 7.3 |
| `05-primefaces-12-assessment.md` | `make pf12-run` | PrimeFaces 12 on current EAP 7.3 |
| `06-primefaces-13-assessment.md` | `make pf13-run` | PrimeFaces 13 on current EAP 7.3 |
| `07-primefaces-14-assessment.md` | `make pf14-run` | PrimeFaces 14 on current EAP 7.3 |
| `08-primefaces-15-jakarta-assessment.md` | `make pf15-run` | EAP 8.1, Jakarta EE, PrimeFaces 15 |

PrimeFaces does not have a normal public `9.x` major stage in this path, so the next major-line step after `8.0` is `10.0.0`.

Override budget caps when needed:

```bash
make pf7-assessment-run pf7_ASSESSMENT_LIMIT=45
make pf7-run pf7_LIMIT=90
make pf15-run pf15_LIMIT=240
```

## Cost Control

AWS Transform custom transformations use agent minutes. The `--limit` option caps the agent-minute budget for each phase. The assessment report must calculate estimated cost as:

```text
estimated cost = estimated agent minutes * current AWS Transform custom transformation agent-minute price
```

Check current AWS pricing when running the assessment because prices can change.

## References

- AWS Transform custom transformations: https://docs.aws.amazon.com/transform/latest/userguide/custom.html
- AWS Transform custom workflows and configuration: https://docs.aws.amazon.com/transform/latest/userguide/custom-workflows.html
- Red Hat JBoss EAP 8.1 OpenJDK 21 runtime image: https://catalog.redhat.com/en/software/containers/jboss-eap-8/eap81-openjdk21-runtime-openshift-rhel9/683da12da060a55180434f52
- PrimeFaces artifact metadata: https://central.sonatype.com/artifact/org.primefaces/primefaces
