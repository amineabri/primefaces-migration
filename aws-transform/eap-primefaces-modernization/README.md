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
aws-transform/eap-primefaces-modernization/reports/01-primefaces-8-assessment.md
aws-transform/eap-primefaces-modernization/reports/02-primefaces-11-assessment.md
aws-transform/eap-primefaces-modernization/reports/03-eap8-primefaces15-assessment.md
```

You can also run a single stage estimate:

```bash
make pf8-assessment-publish
make pf8-assessment-run
make pf8-assessment-validate
```

Each assessment report includes low / expected / high estimates for agent minutes, AWS Transform cost, human effort, QA effort, and calendar duration. As of 2026-06-24, AWS Transform custom pricing is USD 0.035 per agent minute; check current AWS pricing before relying on the estimate.

## Phase 2: Migration

Purpose: perform one version move at a time after reviewing the matching estimate.

Recommended staged migration:

```bash
make staged-publish
make pf8-run
# QA tests PrimeFaces 8
make pf11-run
# QA tests PrimeFaces 11
make eap8-pf15-run
# QA tests EAP 8.1 and PrimeFaces 15 Jakarta
```

Stage mapping:

| Assessment report | Migration command | QA checkpoint |
| --- | --- | --- |
| `01-primefaces-8-assessment.md` | `make pf8-run` | PrimeFaces 8 on current EAP 7.3 |
| `02-primefaces-11-assessment.md` | `make pf11-run` | PrimeFaces 11 on current EAP 7.3 |
| `03-eap8-primefaces15-assessment.md` | `make eap8-pf15-run` | EAP 8.1, Jakarta EE, PrimeFaces 15 |
```

Override budget caps when needed:

```bash
make pf8-assessment-run PF8_ASSESSMENT_LIMIT=45
make pf8-run PF8_LIMIT=90
make eap8-pf15-run EAP8_PF15_LIMIT=240
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
