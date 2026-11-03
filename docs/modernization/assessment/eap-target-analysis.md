# Application Server Target Analysis: JBoss EAP 8.1

## Summary

**MIG-08 current execution addendum:** JakartaEE10/Faces4/PF15Jakarta/Java21 WAR now builds conditionally; this is not EAP deployment evidence. User explicitly chose Java21 build with deployment guarded pending a provisioned EAP8.1 image. Red Hat confirms EAP8.1 supports EE10/Faces4/Servlet6, but its named OpenJDK21 **runtime** image contains no server: a provisioned server must be copied from a builder/assembly stage. Documented server home is `/opt/server`, not `/opt/eap`. Therefore the old assessment's bare-image WAR-copy assumption is not deployable and was not replayed.

Docker/Compose now require an external approved provisioned `EAP_IMAGE`; missing input fails explicitly, Dockerfile checks installed server/deployment directory and copies ROOT.war under `/opt/server`. Actual image identity/access/digest/platform/UID185/entrypoint/permissions/deployment-scanner checks remain deferred. No image assembly, registry authentication, pull/build/start or substitute runtime was attempted. Vendor jboss-web7.2 with root context only is retained based on schema/upstream parser evidence; exact EAP8.1 descriptor acceptance remains runtime QA. No datasource/security/module/env-entry migration exists in this repository. Historical original-runtime inventory below is not current deployment status.

Sources: [EAP supported standards, 8.1 column](https://access.redhat.com/articles/113373); [Red Hat runtime image/provisioning guide](https://docs.redhat.com/en/documentation/red_hat_jboss_enterprise_application_platform/8.1/html-single/using_jboss_eap_on_openshift_container_platform/index#proc_provisioning-the-jboss-eap-server-with-default-configuration_deploying-a-third-party-application-on-openshift). **EAP 8.1 RUNTIME VALIDATION DEFERRED**; future image provisioning/acceptance requires separate authorization.

The repository is currently configured for JBoss EAP 7.3.10/OpenJDK 8 and Java EE 8. The declared target is JBoss EAP 8.1/OpenJDK 21 with Jakarta EE 10 and PrimeFaces 15 Jakarta. The app is a simple root-deployed WAR with CDI/JSF and no database, security framework, custom EAP Java API, or remote server integration. Application-server migration complexity is medium because the runtime image, Jakarta APIs, descriptors, build, and startup behavior change together.

**Status:** Target compatibility is not verified by a build/deployment in this assessment.

## Current Server Assumptions

| Concern | Current evidence |
|---|---|
| Image | `registry.redhat.io/jboss-eap-7/eap73-openjdk8-openshift-rhel7:7.3.10-2` in Dockerfile/Compose |
| Runtime | OpenJDK 8 implied by image |
| Platform | EAP 7.3 / Java EE 8 |
| Deployment | Copy WAR to `/opt/eap/standalone/deployments/ROOT.war`; `.dodeploy` marker |
| User/port | Container user 185; port 8080 |
| Context root | `/` via `jboss-web.xml` and ROOT.war |
| Architecture | Explicit `linux/amd64` |
| APIs | `javax:javaee-api:8.0` in provided scope; app expects server APIs |

Evidence: `Dockerfile:1-15`, `docker-compose.yml:1-13`, `build.gradle:17-23`, and three `WEB-INF` descriptors.

## Target Stack and Compatibility

The repository skill specifies EAP 8.1, Java 21, Jakarta EE 10, and PrimeFaces 15.0.16 Jakarta. It names the image `registry.redhat.io/jboss-eap-8/eap81-openjdk21-runtime-openshift-rhel9:latest`; validate this exact image/tag, its lifecycle/entitlement and architecture before use. `latest` is mutable, so deployment planning should record an approved immutable tag or digest as an implementation-time decision.

The application must compile against Jakarta APIs while using EAP-provided platform services. Do not package a second Faces, Servlet, CDI or Jakarta EE implementation. The EAP-provided Faces version is not independently specified in Gradle; verify it with the selected EAP distribution.

## Runtime Requirements and Build/Deployment Implications

- Java 21 must be available to both the build and runtime. Run Gradle 8.4 under the chosen JDK before assuming wrapper change is needed.
- Replace `javax:javaee-api:8.0` with the intended Jakarta EE 10 API at provided scope; align exact coordinate to official EAP-supported APIs.
- PrimeFaces target must be its Jakarta artifact. Confirm local JAR fallback cannot override the target dependency.
- Update image references in Dockerfile and Compose together; preserve WAR name, port, user, path and root context unless target image evidence requires a deliberate change.
- Confirm target image preserves `/opt/eap/standalone/deployments` workflow, deployment marker, UID 185, and exposed port. These are current-image assumptions.
- Check Linux architecture manifest and remove/adjust forced `linux/amd64` only if target supports the intended deployment architecture.

## Descriptor Implications

`web.xml` uses Java EE web-app 4.0 schema, two `javax.faces.*` context parameters, and `javax.faces.webapp.FacesServlet`. Target requires Jakarta Faces names and Jakarta EE descriptor schema/version suitable for Servlet 6.0. Preserve `*.xhtml`, welcome `home.xhtml`, and multipart limits.

`beans.xml` uses Java EE beans 1.1 schema/version; convert to a Jakarta CDI descriptor accepted by EAP 8.1 while preserving annotated discovery. `jboss-web.xml` currently uses JBoss web schema version 7.2 and root context `/`; verify target support and preserve the context root.

## Module/Classloading and Container-Managed Services

No application server-specific Java imports or `jboss-deployment-structure.xml` were detected. App uses server-provided Faces, CDI, injection, and servlet services. Keep enterprise APIs `provided`; check packaged WAR for duplicate APIs or implementation classes. Verify classloading warnings and CDI/Faces resource initialization at startup.

## Security Implications

No application authentication/authorization dependencies or EAP security-domain references were found. The migration must not introduce security behavior changes. Registry authentication is external deployment access and remains a prerequisite. Container continues to run as user 185 according to current Dockerfile; verify target image user and write permissions.

## Datasource Implications

None identified. No datasource, JPA, JDBC driver, persistence unit, entity, or SQL configuration exists. No datasource migration is planned.

## Image Access and Blockers

| Item | Status | Required evidence before final stage |
|---|---|---|
| EAP 8.1 image/tag | Not verified | Pull/build approved image and record immutable image identity |
| Registry access/subscription | Unknown | Validate credentials/entitlement in the intended environment |
| Java 21 runtime | Declared by target only | Confirm image JDK and successful app startup |
| Linux architecture | Current target amd64; target image not inspected | Confirm manifest and host architecture |
| WAR deployment filesystem | Assumed same `/opt/eap/...` path | Inspect target image and deploy a test WAR |
| UID/permissions/port | Assumed current values remain | Verify target image defaults/permissions and container start |
| EAP descriptor acceptance | Not tested | Deploy target descriptors and inspect server logs |

These are release gates rather than confirmed blockers. The target report does not establish vendor support status or runtime compatibility without an actual EAP deployment.
