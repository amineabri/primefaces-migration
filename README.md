# PrimeFaces Home Office Sample

Minimal Jakarta EE 10 web application for JBoss EAP 8.1, JSF, Gradle, and PrimeFaces 15.0.16.

## What Is Included

- Gradle WAR project
- Gradle version catalog in `gradle/libs.versions.toml`
- Optional local library directory for private JARs
- JSF Facelets pages for Home, Dashboard, Employees, and Reports
- Elements page demonstrating common PrimeFaces 15.0.16 components
- Shared Facelets template with top navigation
- CDI managed beans with static sample data
- PrimeFaces 15.0.16 UI components
- JBoss deployment descriptor
- Dockerfile and docker-compose.yml for a JBoss EAP 8.1 container image

No Spring Boot, Quarkus, authentication, authorization, database, JPA, REST API, messaging, monitoring, CI/CD, Kubernetes, or test framework is included.

## Prerequisites

- Java 21
- Gradle wrapper included
- Docker
- Access to the Red Hat registry images:
  - `registry.redhat.io/jboss-eap-8/eap81-openjdk21-builder-openshift-rhel9:latest`
  - `registry.redhat.io/jboss-eap-8/eap81-openjdk21-runtime-openshift-rhel9:latest`
- Access to the PrimeFaces 15.0.16 artifact

PrimeFaces 15.0.16 Jakarta is a PRO release. The Gradle build resolves it in this order:

- `libs/primefaces-15.0.16-jakarta.jar`
- `org.primefaces:primefaces:15.0.16:jakarta` from the configured repositories

Dependency versions are defined in `gradle/libs.versions.toml`.

## Build

```bash
./gradlew clean build
```

The build creates:

```text
build/libs/primefaces-homeoffice.war
```

## Run With Docker Compose

Log in to the Red Hat registry if required:

```bash
docker login registry.redhat.io
```

The official Red Hat JBoss EAP 8.1 OpenJDK 21 images are published for `amd64`. On Apple Silicon or other ARM hosts, this project uses Docker Desktop emulation by explicitly setting the container platform to `linux/amd64`.

The Dockerfile uses the Red Hat EAP 8.1 builder image to provision the server under `/opt/server`, then copies that provisioned server into the EAP 8.1 runtime image. This pairing is required because the runtime image is intentionally thin and expects `/opt/server` to already exist.

Build the WAR first, then start the container:

```bash
./gradlew clean build
docker compose up --build
```

Open the application:

```text
http://localhost:8080/
```

The application is deployed as the root web application, so the JBoss EAP welcome page is replaced by the JSF Home page at `/`.

## AWS Transform Modernization

The AWS Transform custom workflow is split into two phases:

- Assessment: `aws-transform/eap-primefaces-modernization/assessment`
- Migration: `aws-transform/eap-primefaces-modernization/migration`

Start with the assessment phase to estimate time, cost, and risk before running the migration phase. See [aws-transform/eap-primefaces-modernization/README.md](aws-transform/eap-primefaces-modernization/README.md).

Common commands are wrapped in the root `Makefile`:

```bash
make help
make assessments-publish
make assessments-run
make assessments-validate
make staged-publish
make pf7-run
make pf8-run
make pf10-run
make pf11-run
make pf12-run
make pf13-run
make pf14-run
make pf15-run
```

## Project Structure

```text
.
├── aws-transform
├── Dockerfile
├── build.gradle
├── docker-compose.yml
├── settings.gradle
├── gradle/libs.versions.toml
├── libs/README.md
├── gradlew
├── gradlew.bat
├── README.md
└── src
    └── main
        ├── java
        │   └── com/example/homeoffice
        │       ├── model
        │       └── view
        └── webapp
            ├── WEB-INF
            │   ├── beans.xml
            │   ├── jboss-web.xml
            │   ├── templates/main.xhtml
            │   └── web.xml
            ├── resources/css/app.css
            ├── home.xhtml
            ├── dashboard.xhtml
            ├── employees.xhtml
            ├── elements.xhtml
            └── reports.xhtml
```
