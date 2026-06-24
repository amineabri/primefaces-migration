# Phase 1: Assessment Transformer

This AWS Transform custom definition assesses the modernization effort before code migration.

It should produce an assessment report with:

- Current application inventory
- Migration work breakdown
- Risk and complexity assessment
- Estimated AWS Transform agent minutes
- Estimated human review and test time
- Cost formula using the current AWS Transform agent-minute price
- Go/no-go notes for the migration phase

It must not modernize the application code.

## Publish

```bash
atx custom def publish \
  --transformation-name eap-primefaces-modernization-assessment \
  --source-directory aws-transform/eap-primefaces-modernization/assessment/definition \
  --description "Assess EAP 7.3 and PrimeFaces 6.2 modernization effort, cost, time, and risk"
```

## Execute

Use `--limit` to cap assessment agent minutes.

```bash
atx custom def exec \
  --code-repository-path . \
  --transformation-name eap-primefaces-modernization-assessment \
  --configuration "file://$(pwd)/aws-transform/eap-primefaces-modernization/assessment/config.yaml" \
  --limit 30
```

Expected report:

```text
aws-transform/eap-primefaces-modernization/reports/assessment.md
```
