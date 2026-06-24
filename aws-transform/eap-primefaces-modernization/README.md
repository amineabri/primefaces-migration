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

Publish:

```bash
make assessment-publish
```

Execute with an assessment budget cap:

```bash
make assessment-run
```

Expected output:

```text
aws-transform/eap-primefaces-modernization/reports/assessment.md
```

## Phase 2: Migration

Purpose: perform the modernization after reviewing the assessment.

Publish:

```bash
make migration-publish
```

Execute with a migration budget cap:

```bash
make migration-run
```

Override budget caps when needed:

```bash
make assessment-run ASSESSMENT_LIMIT=45
make migration-run MIGRATION_LIMIT=240
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
