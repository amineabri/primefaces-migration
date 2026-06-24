# EAP And PrimeFaces Jakarta Modernization

## Goal

Modernize this Java EE JSF/PrimeFaces WAR application to run on the latest Red Hat JBoss EAP target and current PrimeFaces major version while preserving the existing application behavior and page set.

## Target Stack

- Java: 21
- Application server: Red Hat JBoss EAP 8.1
- Container image: `registry.redhat.io/jboss-eap-8/eap81-openjdk21-runtime-openshift-rhel9:latest`
- Platform APIs: Jakarta EE 10
- JSF/Jakarta Faces: the implementation provided by JBoss EAP 8.1
- PrimeFaces: `org.primefaces:primefaces:15.0.16` with the `jakarta` classifier
- Build: Gradle WAR build with version catalog
- Deployment: root context at `/`

## Required Transformations

### Build And Dependency Modernization

- Keep Gradle and WAR packaging.
- Update `gradle/libs.versions.toml`:
  - Replace `javaee = "8.0"` with `jakartaee = "10.0.0"`.
  - Replace `primefaces = "6.2.30"` with `primefaces = "15.0.16"`.
  - Replace `javax:javaee-api` with `jakarta.platform:jakarta.jakartaee-api`.
  - Add an OWASP Java HTML Sanitizer dependency only if `p:textEditor` is kept in secure mode.
- Update `build.gradle`:
  - Use Java 21 source and target compatibility.
  - Use `providedCompile libs.jakartaee.api`.
  - Resolve PrimeFaces from `libs/primefaces-15.0.16-jakarta.jar` first if present.
  - Otherwise use the PrimeFaces Maven artifact with the `jakarta` classifier.
  - Keep `archiveFileName = 'primefaces-homeoffice.war'`.

### Java Namespace Migration

- Replace `javax.*` imports with Jakarta equivalents:
  - `javax.enterprise.*` to `jakarta.enterprise.*`
  - `javax.inject.*` to `jakarta.inject.*`
  - `javax.faces.*` to `jakarta.faces.*`
  - `javax.servlet.*` to `jakarta.servlet.*`
  - `javax.el.*` to `jakarta.el.*`
- Update PrimeFaces upload model imports for PrimeFaces 15:
  - `org.primefaces.model.UploadedFile` to `org.primefaces.model.file.UploadedFile`
  - Keep `org.primefaces.event.FileUploadEvent` unless compilation proves otherwise.
- Preserve current CDI bean scopes and bean names.

### Descriptor And Facelets Migration

- Update `WEB-INF/web.xml` to Jakarta EE 10 web-app 6.0 schema.
- Update the Faces servlet class to `jakarta.faces.webapp.FacesServlet`.
- Update JSF context-param names to `jakarta.faces.*` where applicable.
- Update `WEB-INF/beans.xml` to Jakarta CDI 4 schema.
- Keep `WEB-INF/jboss-web.xml` context root as `/`.
- Update Facelets namespaces:
  - `xmlns:h="jakarta.faces.html"`
  - `xmlns:f="jakarta.faces.core"`
  - `xmlns:ui="jakarta.faces.facelets"`
  - Keep `xmlns:p="http://primefaces.org/ui"`.

### PrimeFaces Page Migration

- Keep the existing pages and navigation.
- Keep the Elements page as the PrimeFaces component demonstration page.
- Replace or adjust components and attributes removed after PrimeFaces 6.2.30:
  - Prefer current PrimeFaces 15 equivalents.
  - Keep the behavior simple and static.
  - Do not introduce new application features.
- For `p:textEditor`, prefer secure mode with the sanitizer dependency. If sanitizer setup is not added, explicitly keep `secure="false"` and document why.
- Validate that root `/` renders the Home page and `/elements.xhtml` renders without server errors.

### Docker Modernization

- Update `Dockerfile`:
  - Replace the EAP 7.3 base image with `registry.redhat.io/jboss-eap-8/eap81-openjdk21-runtime-openshift-rhel9:latest`.
  - Keep deployment as `/opt/eap/standalone/deployments/ROOT.war`.
  - Keep `linux/amd64` platform settings unless the selected Red Hat image publishes an ARM variant.
- Update `docker-compose.yml` only as needed for the new EAP 8.1 image and platform.
- Keep port `8080:8080`.

### Documentation

- Update README to describe:
  - Gradle build using Java 21.
  - JBoss EAP 8.1 target.
  - PrimeFaces 15.0.16 Jakarta artifact.
  - Root URL `http://localhost:8080/`.
  - Local private JAR convention `libs/primefaces-15.0.16-jakarta.jar`.

## Validation

Run these checks after transformation:

```bash
./gradlew clean build
bash .aws/atx/skills/eap-primefaces-modernization/scripts/validate-modernized.sh
docker compose config
```

If Docker registry authentication is available, also run:

```bash
docker compose up --build
```

Manual acceptance checks:

- `http://localhost:8080/` opens Home.
- `http://localhost:8080/elements.xhtml` opens Elements without internal server errors.
- No `javax.` imports remain in `src/main/java`.
- No JBoss EAP 7.3 image remains in Docker files.
- No PrimeFaces 6.2.30 dependency remains in Gradle files or README.

## Out Of Scope

- Do not add Spring Boot.
- Do not add Quarkus.
- Do not add databases, JPA, REST APIs, authentication, authorization, messaging, monitoring, CI/CD, or Kubernetes.
- Do not add new pages beyond those already present.
- Do not change the application domain behavior beyond compatibility modernization.
