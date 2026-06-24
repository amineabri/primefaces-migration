# EAP PrimeFaces Modernization Skill

Use this skill when assessing or modernizing this repository from JBoss EAP 7.3 / Java EE 8 / PrimeFaces 6.2.30 to JBoss EAP 8.1 / Jakarta EE 10 / PrimeFaces 15.0.16.

## Workflow

Run modernization in two phases:

1. Assessment phase: inspect the repository, estimate time/cost/risk, and write `aws-transform/eap-primefaces-modernization/reports/assessment.md`.
2. Migration phase: read the assessment report, then modernize the app according to the target decisions below.

During assessment, do not modify application code, build files, Docker files, descriptors, JSF pages, or README files. The only allowed assessment output is the report.

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
