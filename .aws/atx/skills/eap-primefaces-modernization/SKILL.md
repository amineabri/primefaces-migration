# EAP PrimeFaces Modernization Skill

Use this skill when assessing or modernizing this repository from JBoss EAP 7.3 / Java EE 8 / PrimeFaces 6.2.30 to JBoss EAP 8.1 / Jakarta EE 10 / PrimeFaces 15.0.16.

## Workflow

Run modernization in two phases:

1. Assessment phase: inspect the repository and estimate time/cost/risk separately for each version move.
2. Migration phase: run one version move at a time, with QA checkpoints between stages.

During assessment, do not modify application code, build files, Docker files, descriptors, JSF pages, or README files. The only allowed assessment output is the report.

Per-stage assessment reports:

- `aws-transform/eap-primefaces-modernization/reports/01-primefaces-8-assessment.md`
- `aws-transform/eap-primefaces-modernization/reports/02-primefaces-11-assessment.md`
- `aws-transform/eap-primefaces-modernization/reports/03-eap8-primefaces15-assessment.md`

Per-stage migration order:

1. PrimeFaces 6.2.30 to PrimeFaces 8.0 on current Java EE / EAP 7.3.
2. PrimeFaces 8.0 to PrimeFaces 11.0.0 on current Java EE / EAP 7.3.
3. PrimeFaces 11.0.0 to PrimeFaces 15.0.16 Jakarta plus EAP 8.1 / Jakarta EE 10 / Java 21.

Do not continue to the next migration stage until the testing team has completed the QA checkpoint for the previous stage.

## Target Decisions

- Target Java 21.
- Target JBoss EAP 8.1 using `registry.redhat.io/jboss-eap-8/eap81-openjdk21-runtime-openshift-rhel9:latest`.
- Target Jakarta EE 10.
- Target PrimeFaces `15.0.16` with the `jakarta` classifier.
- Keep the application deployed at root `/`.
- Keep the existing pages and sample-only behavior.

## Implementation Rules

- Do not add Spring Boot, Quarkus, databases, JPA, REST APIs, authentication, authorization, messaging, monitoring, CI/CD, or Kubernetes.
- Keep Gradle and the WAR packaging model.
- Keep dependency versions in `gradle/libs.versions.toml`.
- Keep local private PrimeFaces fallback support, but rename it to `libs/primefaces-15.0.16-jakarta.jar`.
- Replace all Java EE `javax.*` imports and XML schemas with Jakarta equivalents.
- Update Facelets namespaces to Jakarta Faces namespaces.
- Keep PrimeFaces namespace as `http://primefaces.org/ui`.
- Update `web.xml`, `beans.xml`, `jboss-web.xml`, Docker files, and README together.
- Do not leave mixed Java EE and Jakarta EE APIs in the same codebase.
- During migration, read the assessment report if it exists before editing files.

## Known PrimeFaces Migration Checks

- `org.primefaces.model.UploadedFile` must become `org.primefaces.model.file.UploadedFile` for PrimeFaces 15.
- Check every `p:` component attribute against PrimeFaces 15 documentation or taglib before finalizing.
- The Elements page must still demonstrate the existing component list after modernization.
- `p:textEditor` must either use secure mode with sanitizer dependency or explicitly use `secure="false"` with a README note.

## Validation

Run:

```bash
./gradlew clean build
bash .aws/atx/skills/eap-primefaces-modernization/scripts/validate-modernized.sh
docker compose config
```

Acceptance:

- Build succeeds.
- No `javax.` imports remain in `src/main/java`.
- Gradle references `jakarta.jakartaee-api`, PrimeFaces `15.0.16`, and the Jakarta PrimeFaces artifact.
- Docker references EAP 8.1, not EAP 7.3.
- Root URL is still `/`.
