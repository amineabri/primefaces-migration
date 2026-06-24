# PrimeFaces Home Office Sample

Minimal Java EE web application for JBoss EAP 7.3.10.GA, JSF, Gradle, and PrimeFaces 6.2.30.

## What Is Included

- Gradle WAR project
- Gradle version catalog in `gradle/libs.versions.toml`
- Optional local library directory for private JARs
- JSF Facelets pages for Home, Dashboard, Employees, and Reports
- Elements page demonstrating common PrimeFaces 6.2.30 components
- Shared Facelets template with top navigation
- CDI managed beans with static sample data
- PrimeFaces 6.2.30 UI components
- JBoss deployment descriptor
- Dockerfile and docker-compose.yml for a JBoss EAP 7.3.10 container image

No Spring Boot, Quarkus, authentication, authorization, database, JPA, REST API, messaging, monitoring, CI/CD, Kubernetes, or test framework is included.

## Prerequisites

- Java 8
- Gradle wrapper included
- Docker
- Access to the Red Hat registry image `registry.redhat.io/jboss-eap-7/eap73-openjdk8-openshift-rhel7:7.3.10-2`
- Access to the PrimeFaces 6.2.30 artifact

PrimeFaces 6.2.30 is an Elite/PRO maintenance release and is not the public `6.2` artifact. The Gradle build resolves it in this order:

- `libs/primefaces-6.2.30.jar`
- `org.primefaces:primefaces:6.2.30` from the configured repositories

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

The official Red Hat JBoss EAP 7.3.10 OpenJDK 8 image is published for `amd64`. On Apple Silicon or other ARM hosts, this project uses Docker Desktop emulation by explicitly setting the container platform to `linux/amd64`.

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
make pf8-run
make pf11-run
make eap8-pf15-run
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
