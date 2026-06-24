# AWS Transform Custom Transformer: EAP And PrimeFaces Modernization

This directory contains a custom AWS Transform definition for modernizing this application from:

- JBoss EAP 7.3.x / Java EE 8 / `javax.*`
- PrimeFaces 6.2.30
- Java 8

to:

- JBoss EAP 8.1 on OpenJDK 21
- Jakarta EE 10 / `jakarta.*`
- PrimeFaces 15.0.16 Jakarta artifact
- Java 21

## Publish The Transformer

```bash
atx custom def publish \
  --transformation-name eap-primefaces-modernization \
  --source-directory aws-transform/eap-primefaces-modernization
```

Use `save-draft` instead of `publish` while iterating:

```bash
atx custom def save-draft \
  --transformation-name eap-primefaces-modernization \
  --source-directory aws-transform/eap-primefaces-modernization
```

## Execute Against This Repository

```bash
atx custom def exec \
  --code-repository-path . \
  --transformation-name eap-primefaces-modernization \
  --configuration aws-transform/eap-primefaces-modernization/config.yaml
```

## References

- AWS Transform custom transformations: https://docs.aws.amazon.com/transform/latest/userguide/custom.html
- AWS Transform custom workflows and configuration: https://docs.aws.amazon.com/transform/latest/userguide/custom-workflows.html
- Red Hat JBoss EAP 8.1 OpenJDK 21 runtime image: https://catalog.redhat.com/en/software/containers/jboss-eap-8/eap81-openjdk21-runtime-openshift-rhel9/683da12da060a55180434f52
- PrimeFaces artifact metadata: https://central.sonatype.com/artifact/org.primefaces/primefaces
