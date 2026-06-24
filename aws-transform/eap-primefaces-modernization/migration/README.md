# Phase 2: Migration Transformer

This AWS Transform custom definition performs the modernization after the assessment is reviewed.

Run Phase 1 first and review:

```text
aws-transform/eap-primefaces-modernization/reports/assessment.md
```

## Publish

```bash
atx custom def publish \
  --transformation-name eap-primefaces-modernization-migration \
  --source-directory aws-transform/eap-primefaces-modernization/migration/definition \
  --description "Modernize EAP 7.3 Java EE PrimeFaces app to EAP 8.1 Jakarta EE and PrimeFaces 15"
```

## Execute

Use `--limit` to cap migration agent minutes.

```bash
atx custom def exec \
  --code-repository-path . \
  --transformation-name eap-primefaces-modernization-migration \
  --configuration "file://$(pwd)/aws-transform/eap-primefaces-modernization/migration/config.yaml" \
  --limit 180
```

## Validate

```bash
./gradlew clean build
bash .aws/atx/skills/eap-primefaces-modernization/scripts/validate-modernized.sh
docker compose config
```
