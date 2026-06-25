# Phase 2: Migration Transformer

This AWS Transform custom definition performs the modernization after the assessment is reviewed.

Run Phase 1 first and review:

```text
aws-transform/eap-primefaces-modernization/reports/assessment.md
```

## Recommended Staged Migration

```bash
make staged-publish
```

Then run and test one version move at a time:

```bash
make pf7-run
# QA checkpoint: PrimeFaces 7

make pf8-run
# QA checkpoint: PrimeFaces 8

make pf10-run
# QA checkpoint: PrimeFaces 10

make pf11-run
# QA checkpoint: PrimeFaces 11

make pf12-run
# QA checkpoint: PrimeFaces 12

make pf13-run
# QA checkpoint: PrimeFaces 13

make pf14-run
# QA checkpoint: PrimeFaces 14

make pf15-run
# QA checkpoint: JBoss EAP 8.1, Jakarta EE, PrimeFaces 15
```

## Validate

```bash
./gradlew clean build
bash .aws/atx/skills/eap-primefaces-modernization/scripts/validate-modernized.sh
docker compose config
```
