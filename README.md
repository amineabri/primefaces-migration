# PrimeFaces Home Office Sample

Minimal Jakarta EE 10 web application for Java 21, Jakarta Faces 4, Gradle, and PrimeFaces 15.0.16 Jakarta, targeting JBoss EAP 8.1.

**Application migration COMPLETE. EAP acceptance PASS. OPS-01: OPERATIONALLY INCOMPLETE.** Actual EAP8.1 Update8.0/Red Hat Java21 deployment and **54/54** Chromium/Firefox/WebKit checks match the preserved WildFly baseline. The user-approved single-instance Docker profile now excludes clustering, locks provisioning, uses finalized configuration and passes immutable replacement/health checks. Production proxy/TLS, recovery supervision, image publication and compatible previous-production rollback remain open. See [production readiness](docs/modernization/operations/production-readiness.md). Earlier [MIG-09 acceptance](docs/modernization/migration/final-acceptance.md), [report](docs/modernization/transformation-report.md) and [migration state](docs/modernization/migration/migration-state.json) preserve historical phase results. Production release is not approved.

**OPS-02 update:** exact validated image promoted to `ghcr.io/amineabri/primefaces-migration@sha256:63126aa490725adbcf1f02170a251f1d0b949ddaeb6b2c574712c4d864a003fe`. **LOCAL PRODUCTION-TOPOLOGY TLS VALIDATION PASS** at localhost8443 with unchanged EAP:27focused checks, secure session cookies, local health/routing/alerts/replacement and maintenance-gated cutover. This is not live-production TLS acceptance. Final **OPERATIONALLY INCOMPLETE**: approved previous-production rollback pair missing, production platform/CA/durable monitoring and retained product risks open. See [production acceptance](docs/modernization/operations/production-acceptance.md) for reproduction and exact scope.

## What Is Included

- Gradle WAR project with Java 21 compiler toolchain (Gradle 8.4 runs on JDK 11)
- Gradle version catalog in `gradle/libs.versions.toml`
- Optional local library directory for private JARs
- JSF Facelets pages for Home, Dashboard, Employees, and Reports
- Elements page demonstrating common PrimeFaces components
- Shared Facelets template with top navigation
- CDI managed beans with static sample data
- PrimeFaces 15.0.16 Jakarta components with explicitly configured Saga Blue theme
- JBoss deployment descriptor
- Digest-pinned multi-stage EAP8.1 Java21 provisioning Dockerfile and docker-compose.yml

No Spring Boot, Quarkus, authentication, authorization, database, JPA, REST API, messaging, monitoring, CI/CD, Kubernetes, or test framework is included.

## Prerequisites

- JDK 11 to run the Gradle 8.4 wrapper and an installed JDK 21 compiler toolchain (application bytecode target 21)
- Gradle wrapper included
- Docker
- Authenticated registry access to the approved digest-pinned Red Hat builder/runtime images, plus access to Red Hat Maven repositories for provisioning
- Access to public `org.primefaces:primefaces:15.0.16:jakarta` and `jakarta.platform:jakarta.jakartaee-api:10.0.0`

The Gradle build resolves PrimeFaces in this order:

- `libs/primefaces-15.0.16-jakarta.jar` (only use a verified local Jakarta override)
- `org.primefaces:primefaces:15.0.16:jakarta` from Maven Central

The original private PrimeFaces 6.2.30 artifact was unavailable; MIG-00 used an approved public 6.2 reconstruction, not proven functional equivalence.

Dependency versions are defined in `gradle/libs.versions.toml`.

## Build

```bash
./gradlew clean build
bash .aws/atx/skills/eap-primefaces-modernization/scripts/validate-modernized.sh
```

The build creates:

```text
build/libs/primefaces-homeoffice.war
```

## Run With Docker Compose

The Dockerfile now uses the user-approved immutable Red Hat images:

- Builder: `registry.redhat.io/jboss-eap-8/eap81-openjdk21-builder-openshift-rhel9@sha256:40f2d11ef2b181330eadb04fc1b89925b91921612f39f72fee475c55a53e06d6`
- Runtime: `registry.redhat.io/jboss-eap-8/eap81-openjdk21-runtime-openshift-rhel9@sha256:6a3590ad17625af2bffd64d4cd6828da15c56102fcc57fa5c7be9bd4dc662845`

Builder assembly pins the EAP8.1 channel manifest to **1.8.0.GA-redhat-00006**, using explicit non-clustered web/Faces/CDI/health/management layers for the approved single-instance architecture. `/opt/server` is copied into the runtime before ROOT.war deployment; the runtime base alone has no server. `EAP_IMAGE` is no longer required. Configuration is finalized at image build time. Preserve the generated installation manifest and tested immutable application image rather than rebuilding for each environment.

On Apple Silicon or other ARM hosts, this project uses Docker Desktop emulation by explicitly setting the container platform to `linux/amd64`.

For local evaluation only, after secure registry authentication:

```bash
./gradlew clean build
docker compose config
docker compose up --build
```

**Production model: immutable replacement**, not automatic same-container restart. The historical cloud profile failed duplicate KUBE_PING configuration; OPS-01 provisions a complete no-cluster configuration before setting `CONFIG_IS_FINAL=true`, removing that cause. Same-container restart also passes a diagnostic smoke test, but both Compose definitions deliberately use `restart: "no"`. A production monitor must replace exited/unhealthy instances, not rely on Docker health status to restart them.

The local Compose file builds for evaluation and binds HTTP to **127.0.0.1:8080** only. Production cookies are Secure/HttpOnly/SameSite=Lax; local plain HTTP is not an end-to-end TLS acceptance environment. Production uses a host reverse proxy for HTTPS. For deployment, publish the tested application image to a controlled registry, set `EAP_APPLICATION_IMAGE` to its verified `repository@sha256:...` reference and run `bash operations/eap/replace-container.sh`. The separate `docker-compose.production.yml` contains no build and waits for deployment-aware readiness.

Startup/liveness/readiness probes are available via `/opt/server/bin/ops-healthcheck.sh`; Docker HEALTHCHECK uses readiness. Management binds container loopback and is not published. **All existing application sessions/Faces views must be invalidated at cutover and rollback.** Proxy/TLS configuration, production recovery supervision and approved prior-production rollback rehearsal remain release gates; see the [OPS-01 report](docs/modernization/operations/production-readiness.md).

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
