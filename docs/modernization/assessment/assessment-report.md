# EAP and PrimeFaces Modernization Assessment

| Assessment metadata | Value |
|---|---|
| Repository | `amineabri/primefaces-migration` |
| Assessment date | 2026-10-27 |
| Assessment type | Repository-evidence assessment; no migration execution |
**Target path:** PrimeFaces 6.2.30 → 7 → 8 → 10 → 11 → 12 → 13 → 14 → 15.0.16 Jakarta; Java EE 8/EAP 7.3/Java 8 → Jakarta EE 10/EAP 8.1/Java 21

## Executive Summary

The assessed application is one small Gradle WAR project with 11 Java files, six XHTML files (five user pages and one template), three deployment descriptors, and a single CSS file. Its application-specific source and web assets total approximately **1,522 physical lines** (571 Java; 951 webapp XHTML/XML/CSS), excluding build tooling, migration recipes, reports, and documentation. There is no database/ORM, authentication subsystem, external service integration, or automated test suite.

The modernization is **low-to-medium complexity overall**. The seven PrimeFaces-only version transitions are small but need component-level regression checks. The final transition is **medium-to-high complexity relative to this repository** because it combines a Java 8→21 build/runtime change, Java EE `javax.*`→Jakarta namespace conversion, descriptor updates, PrimeFaces Jakarta artifact/API changes, and EAP 8.1 image/deployment replacement.

| Metric | Assessment |
|---|---|
| Overall complexity | Low-to-medium; final platform cutover medium |
| Migration readiness | Moderate; recipes and acceptance validators exist, but no behavioral tests or current successful baseline build evidence |
| Linux readiness | Partial; container is Linux/amd64-specific; target image/architecture compatibility is unverified |
| Automation potential | High for mechanical version/catalog/namespace edits; medium-low for semantic API changes and deployment |
| Engineering effort | Best 25.5 h / 3.4 days; most likely 38.5 h / 5.1 days; high-risk 59 h / 7.9 days |
| Estimated transformation-agent execution | Best 121 min; expected 196 min; high 312 min (historical estimates in source reports, not a run result) |
| Expected elapsed delivery window | 10 / 12 / 18 business days (best / expected / high; QA gates and environment availability dominate) |
| Migration decision | Proceed only after baseline verification and confirmation of target image/artifact access; stage changes and QA gates are mandatory |

Engineering effort, agent execution, and calendar duration are distinct measures. Confidence is medium-low for engineering effort and low for calendar duration because estimates come from the existing 2026-06-24 assessment reports, not observed work or a live AWS Transform run.

## Assessment Scope

This assessment re-evaluates repository facts for the target stack declared in `.aws/atx/skills/eap-primefaces-modernization/SKILL.md` and the staged AWS Transform definitions. Scope includes code/build/runtime/deployment dependencies, API/namespace compatibility, Linux constraints, test evidence, findings, effort, sequence, and post-migration validation.

Included: existing application and its eight documented PrimeFaces migration transitions through Jakarta/EAP. Excluded: new features, database/ORM, authentication, REST, messaging, observability, CI/CD, Kubernetes, cloud infrastructure provisioning, operational hardening unrelated to migration, and release approval.

No source/build/deployment migration was performed. No dependency resolution, compilation, container build, AWS Transform execution, or target-server deployment was performed during this assessment. The reports below distinguish repository-declared facts from assumptions requiring verification.

## Source Repository

| Attribute | Evidence / value |
|---|---|
| Repository | `amineabri/primefaces-migration` |
| Tracked files | 90 files at assessment inspection (includes 9 previous assessment reports, transformation definitions/configurations, wrapper binary/scripts, and source) |
| Tracked physical lines | Approximately 4,612 across all tracked files; includes docs and generated wrapper files, not a source LOC measure |
| Application Java LOC | 571 physical lines over 11 Java files |
| Application web LOC | 951 physical lines over six XHTML files, three XML descriptors, and one CSS file |
| Build/deployment | `build.gradle`, `settings.gradle`, `gradle/libs.versions.toml`, Gradle wrapper, `Dockerfile`, `docker-compose.yml`, `Makefile` |
| AWS Transform assets | 49 files under `aws-transform/`: 9 prior Markdown reports, workflow definitions/configuration, and `.gitkeep`; inventory in `aws-transform-artifact-inventory.md` |
| Original output formats | Nine Markdown reports. No prior HTML, JSON, CSV, XLSX, logs, or execution metadata file was found under the repository |
| Git worktree | Assessment generated under `docs/modernization/assessment/`; no production source change is part of this deliverable |

The 90-file count is from `git ls-files` before these new, untracked assessment deliverables. Counts are physical lines, including blank/comment lines; they are not semantic SLOC.

## Current Technology Stack

| Layer | Current state | Repository evidence |
|---|---|---|
| Language/runtime | Java 8 source and target compatibility | `build.gradle:10-13` |
| Enterprise platform | Java EE 8 API, `javax` namespace | `gradle/libs.versions.toml:2,6`; Java imports below |
| UI | JSF/Facelets and PrimeFaces 6.2.30 | README; version catalog; `src/main/webapp` |
| JSF implementation | Not declared by application dependency; assumed server-provided | No standalone Mojarra/MyFaces dependency in catalog/build; EAP is configured as runtime |
| CDI / injection | Java EE CDI and `javax.inject` annotations | Five view beans; `beans.xml` |
| Application server | JBoss EAP 7.3.10.GA, OpenJDK 8 image | README, Dockerfile, Compose |
| Build | Gradle 8.4 wrapper; Java and WAR plugins | `gradle/wrapper/gradle-wrapper.properties:3`; `build.gradle:1-4` |
| Persistence | None detected | No JDBC/JPA/ORM/database dependency or descriptor |
| Authentication | None detected | README and application facts explicitly exclude authentication/authorization |
| Tests | No test source tree/framework found | Repository inventory; build declares no test dependency |

## Target Technology Stack

| Layer | Target declared in repository assets | Assessment note |
|---|---|---|
| Java | 21 | Verify Gradle 8.4 invocation/toolchain behavior; update wrapper if the actual build requires it |
| Enterprise platform | Jakarta EE 10 | Replace Java EE 8 API dependency and all application-managed `javax` Enterprise APIs |
| JSF | Jakarta Faces 4.0, supplied by target server | Version is implied by Jakarta EE 10; application does not independently select a Faces implementation |
| PrimeFaces | 15.0.16 with `jakarta` classifier | Verify exact coordinate/artifact availability and APIs |
| Application server | JBoss EAP 8.1 | Confirm approved image tag, registry entitlement, architecture and runtime configuration |
| Packaging | Gradle WAR; root deployment remains `/` | Preserve `ROOT.war` and `jboss-web.xml` context root |
| Data/authentication | Remain absent | No database/authentication migration is in scope |

Target values are declared in the repository modernization skill and staged definitions, not independently validated against current vendor support matrices.

## Repository Analysis

The project is a single web application. Six model classes hold serializable sample data; five CDI beans supply view data/actions. Five pages (`home`, `dashboard`, `employees`, `reports`, `elements`) use a shared Facelets template. The Elements page concentrates PrimeFaces usage, including file upload, date input, tables, CSV export, text editor, AJAX, dialog, progress, and message components. A 412-line CSS file includes the largest custom presentation surface and should be checked visually after theme/client library changes.

The repository includes staged AWS Transform instructions and validators, which improve process repeatability. They are documentation/automation assets, not proof that the current application builds or that a prior transformation was executed. `aws-transform/eap-primefaces-modernization/reports/` contains the reference reports listed in the [artifact inventory](manifest.json).

## Application / Module Inventory

| Project/module | Path | Type | Files/LOC | Role | Complexity |
|---|---|---|---:|---|---|
| `primefaces-homeoffice` | repository root; `src/main` | Gradle Java WAR | 11 Java / 571 LOC; 6 XHTML + 3 XML + 1 CSS / 951 LOC | CDI sample web app, Facelets UI, PrimeFaces showcase | Low current; medium target cutover |

There are no Gradle subprojects, separate deployables, service modules, or test modules. Detailed module facts are in `project-analysis.md`.

## Project Dependency Analysis

```text
Gradle 8.4 wrapper
  └─ root WAR project: primefaces-homeoffice
      ├─ javax:javaee-api:8.0 [providedCompile; expected from server at runtime]
      └─ org.primefaces:primefaces:6.2.30 [implementation, or exact local JAR override]
          └─ primefaces-homeoffice.war (ROOT.war in Docker)
              └─ JBoss EAP 7.3.10 / OpenJDK 8 / linux/amd64
```

No project-to-project dependency edges exist. The WAR uses `javax:javaee-api:8.0` as provided API and packages PrimeFaces. `build.gradle:15-23` conditionally picks `libs/primefaces-<catalog version>.jar` when present; `libs/` currently has documentation rather than a tracked PrimeFaces JAR. `settings.gradle` configures `mavenLocal()` and Maven Central. Target graph: Jakarta EE 10 API provided by EAP 8.1; PrimeFaces 15 Jakarta packaged in WAR; Java 21 runtime.

## Framework Analysis

**JSF/Facelets:** Facelets is used throughout; no JSP or custom Faces extension was found. The implementation and exact Faces version are not selected by a standalone dependency and are presumed to be server-provided. EAP 8.1 is intended to provide Jakarta Faces under Jakarta EE 10. Do not package a second Faces implementation without a deliberate classloading decision.

**CDI:** Five named view beans use application or session scope. `beans.xml` uses annotated discovery mode, which is an explicit current setting. Target CDI is server-provided. Check bean injection/name resolution after namespace/descriptors change.

**PrimeFaces:** Current version is 6.2.30; only `ElementsBean.java` imports PF classes directly, while XHTML across the application invokes the component library. No PrimeFaces Extensions or custom theme dependency appears in project dependencies. CSS overrides mean default-theme and `.ui-*` changes still need visual testing.

**No other framework detected:** No Spring, Quarkus, Hibernate, JPA, REST framework, security framework, or logging library dependency is declared.

## Runtime / JDK Analysis

Current build source/target are Java 8 (`build.gradle:10-13`), and the container image is EAP 7.3/OpenJDK 8 (`Dockerfile:1`). Target Java is 21. The Java sources inspected use ordinary Java language/library constructs and show no intentional Java 8-only or internal JDK APIs; however, no Java 21 compilation/runtime check was executed. `gradle-wrapper.properties` pins Gradle 8.4; test it against the selected JDK and only change the wrapper if actual compatibility or policy requires.

The high-impact work is environment/toolchain alignment, not an observed Java source rewrite. Potential container-side JDK/module behavior must be validated on the actual EAP target image.

## Build System Analysis

Gradle `java` and `war` plugins build `primefaces-homeoffice.war`; no additional Gradle plugins or build script dependencies are declared. Versions are centralized in `gradle/libs.versions.toml`. Java EE APIs are `providedCompile`; PrimeFaces uses `implementation`. Java compile encoding is UTF-8. The archive filename is fixed in `build.gradle:30-32`.

The expected pre-migration command is `./gradlew clean build`. It was not run for this assessment. Target validation should execute the same command under Java 21 with the updated catalog/runtime configuration. The existing wrapper is 8.4; the stage recipe suggests upgrading as needed, but exact minimum must be established by build evidence rather than assumption.

## Application Server Analysis

Current deployment targets EAP 7.3.10 OpenJDK 8. The Dockerfile copies the WAR to `/opt/eap/standalone/deployments/ROOT.war`; Compose maps port 8080 and explicitly selects `linux/amd64`. Target assets specify EAP 8.1/OpenJDK 21. The Jakarta switch requires a consistent application API, Faces servlet, XML descriptors, and server runtime. See `eap-target-analysis.md` for details and unresolved image/access checks.

## Package / Library Compatibility

| Dependency | Current | Target | Status | Action |
|---|---|---|---|---|
| PrimeFaces | `org.primefaces:primefaces:6.2.30` | `15.0.16` with `jakarta` classifier | UPGRADE REQUIRED | Follow eight staged transitions; verify artifact coordinate and local-JAR fallback |
| Java EE aggregate API | `javax:javaee-api:8.0` | `jakarta.platform:jakarta.jakartaee-api:10.0.0` (target recipe) | REPLACEMENT REQUIRED | Keep provided scope; confirm exact server API alignment |
| JSF/Faces | Not separately declared; server-provided | Jakarta Faces 4.0 via EAP 8.1 | UNKNOWN (implementation version) | Confirm server-provided implementation; do not bundle duplicate implementation |
| Servlet API | Not separately declared; implicit in Java EE API/server | Jakarta Servlet API provided by Jakarta EE 10 server | UPGRADE REQUIRED (transitive platform) | Update web descriptor and servlet class; retain server-provided scope |
| CDI / Inject | Included by Java EE API | Jakarta CDI / Inject in EE 10 | UPGRADE REQUIRED (namespace/platform) | Convert annotation imports, preserve bean discovery behavior |
| JPA, Validation, Logging, Security | No explicit use/dependency found | Not required by application inventory | COMPATIBLE / NOT USED | No migration work identified; reassess only if hidden dependencies exist |
| Gradle plugins | Core `java`, `war` plugins | Same model | COMPATIBLE, subject to JDK test | Verify Gradle 8.4 on Java 21; update wrapper only if required |
| Tests | No testing libraries | None currently | UNKNOWN / ABSENT | No test-framework migration; add/agree regression evidence before cutover |
| Local PrimeFaces JAR | Optional untracked `libs/primefaces-<version>.jar` path | Target-specific Jakarta JAR if local override retained | PRIVATE / INTERNAL (conditional) | Determine whether supplied; verify provenance, artifact version/classifier and checksum |

Full status table is in `dependency-compatibility.md`.

## API Compatibility

Direct Java EE imports appear in five beans, with twelve imports: CDI context and injection in four ordinary beans plus CDI/session, Faces message/context, and injection in `ElementsBean.java`. `web.xml` contains two `javax.faces.*` context parameters and the old Faces servlet class. PrimeFaces Java API imports are `FileUploadEvent` and `org.primefaces.model.UploadedFile`; the repository skill calls out the target package as `org.primefaces.model.file.UploadedFile`.

XHTML impact is concentrated in `elements.xhtml`: `p:calendar`, `p:growl`, file upload, table sort/filter, exporter, editor, and messages. The staged reports call out possible attribute/API behavior changes; exact fixes are conditional on target taglib/API validation. Full location mapping is in `api-compatibility.md` and `primefaces-migration-matrix.md`.

## Jakarta EE Compatibility

The current app is consistently on Java EE 8 / `javax` APIs; the target is Jakarta EE 10. This is a package namespace and runtime boundary, not a drop-in API version update. No application source currently imports `jakarta.*`. Source imports, Faces servlet/context parameters, three XML descriptors, provided dependency coordinates, and PrimeFaces artifact classifier must move together. Detailed namespace inventory, automate-vs-review classification, and descriptor coverage are in `jakarta-migration.md`.

No `faces-config.xml`, `persistence.xml`, tag library descriptor, JPA entity, Servlet filter/listener, validation import, or application server-specific Java API was found. Their absence is a finding about current scope, not a migration task.

## Java EE to Jakarta EE Findings

1. **Java API coordinates:** replace the Java EE 8 API dependency at `gradle/libs.versions.toml:2,6` with Jakarta EE 10 API while retaining provided semantics.
2. **Java namespace:** five bean source files contain twelve `javax.*` imports. These package renames are mechanical but all affected imports must compile against the selected Jakarta API.
3. **Faces web descriptor:** `web.xml` is Java EE 4.0/JCP namespace and references `javax.faces.*` and `javax.faces.webapp.FacesServlet`.
4. **CDI descriptor:** `beans.xml` uses Java EE beans 1.1 namespace/schema; convert schema/version for the Jakarta EE target and preserve `bean-discovery-mode="annotated"`.
5. **JBoss descriptor:** `jboss-web.xml` uses current JBoss web schema/version. Verify accepted descriptor form for EAP 8.1; context root `/` must remain.
6. **PrimeFaces Jakarta artifact/API:** use the target Jakarta artifact and relocate the `UploadedFile` import as prescribed by the project skill. Confirm all behavior against exact artifact.

## Descriptor Compatibility

| File | Current evidence | Target assessment |
|---|---|---|
| `src/main/webapp/WEB-INF/web.xml` | Java EE/JCP `web-app_4_0.xsd`, version 4.0; `javax.faces` params; `javax.faces.webapp.FacesServlet`; multipart limits 1 MiB/file and 2 MiB/request | Use Jakarta EE web descriptor schema/version appropriate for Servlet 6.0; rename Faces params/servlet class; preserve URL mapping, welcome page, multipart limits |
| `src/main/webapp/WEB-INF/beans.xml` | Java EE beans 1.1 schema/version; annotated discovery | Update Jakarta CDI descriptor schema/version; preserve discovery mode |
| `src/main/webapp/WEB-INF/jboss-web.xml` | JBoss web schema 7.2; context root `/` | Check target EAP schema support; preserve context root |
| `faces-config.xml` | Not found | No conversion required unless hidden/untracked environment file exists |
| `persistence.xml` | Not found | No persistence unit migration |

Schema URI/version recommendations must be checked against target EAP documentation during implementation.

## PrimeFaces Compatibility

The assessed UI surface includes tables on `dashboard.xhtml`, `employees.xhtml`, `reports.xhtml`, and `elements.xhtml`; table `sortBy`/`filterBy` expressions are in employees and Elements. `elements.xhtml` also uses calendar, growl, messages, file upload, exporter, editor, auto-complete, AJAX, dialog, and several controls; `ElementsBean.java` is the only direct PF Java API consumer. The application uses CSS overrides in `app.css`.

Known repository-specific migration checks from the prior stage reports and modernization skill: verify upload listener/API signatures; update `UploadedFile` package for PF 15; migrate `p:calendar` to `p:datePicker`; address `p:growl` deprecation/removal; verify table attributes, exporter, editor, and theme classes. Do not assume every alleged removal is hit: check each against the stage's exact PF release taglib/migration documentation before editing.

The detailed stage-by-stage matrix is in `primefaces-migration-matrix.md`.

## Application Server Compatibility

EAP 7.3 provides the Java EE 8 APIs and Java 8 runtime that match current source and descriptors. EAP 8.1 is the declared target and must provide Jakarta EE 10 APIs and Java 21 runtime. Main compatibility work is:

- align WAR API dependency and namespaces with the new server;
- verify descriptor schemas and JBoss-specific descriptor acceptance;
- verify no duplicate JSF/CDI/Servlet API implementation is packaged;
- update container image and ensure its expected deployment path/user/ports match the Dockerfile;
- confirm Red Hat registry entitlement, image tag availability, and amd64 support;
- deploy and inspect EAP startup/deployment logs, CDI resolution, Facelets rendering, and resource loading.

The current `ROOT.war` deployment and port 8080 are intentional and should be preserved. See `eap-target-analysis.md`.

## Linux Compatibility

No Windows-specific application API/library was found. `gradlew.bat` is the standard Gradle Windows launcher. The container is Linux-oriented but hard-coded/configured as `linux/amd64` in Dockerfile and Compose. This indicates x86_64 Linux container intent, not ARM-native readiness. The target EAP image's architecture was not verified. Linux readiness is **partial** until a target image is pulled/built and starts successfully on the chosen Linux architecture.

## Database / Persistence Analysis

No database, JDBC driver, JPA API, ORM, datasource configuration, entity, `persistence.xml`, SQL migration, or database integration was detected. Sample lists are supplied by CDI beans. Database migration effort is zero for this defined target; confidence high for inspected repository content. Hidden environment configuration is outside repository evidence.

## Authentication / Security Dependencies

No authentication/authorization framework, login flow, identity provider, role annotations, security constraint, security descriptor, or security library dependency was found. This is consistent with the README and current-project-facts reference. The migration does not add authentication. Container registry access is an operational prerequisite, not an application authentication dependency. No security assessment beyond dependency/configuration inventory is implied.

## Configuration Analysis

Version data is in `gradle/libs.versions.toml`; build scope and Java versions are in `build.gradle`; Faces/CDI settings are in `web.xml` and `beans.xml`; context root is in `jboss-web.xml`; EAP image and platform appear in both Dockerfile and Compose; stage selection and commands are in Makefile/AWS YAML. These surfaces must be changed consistently. Multipart limits (1 MiB file / 2 MiB request) and root deployment are observable behavior/configuration to preserve unless a separately approved change is made.

## External Integrations

No runtime external API/service, database, broker, identity provider, storage service, or messaging integration was identified in source. Build/deployment depend on Maven Central or an optional local PrimeFaces JAR, Red Hat registry image access, and AWS Transform/ATX for the staged automation workflow. None of those external services was contacted in this assessment.

## Testing Assessment

No `src/test`, test framework dependency, test classes, browser tests, or CI pipeline was found. The existing shell validators check generated assessment/modernization acceptance conditions but are not application behavior tests. Manual validation must cover all five pages; the Elements page is the critical component regression surface. Confidence in unchanged behavior is therefore lower than compilation-only evidence can establish.

## Build Validation Status

**Not run.** No build, dependency resolution, Docker configuration validation, image pull, container startup, AWS Transform assessment run, or server deployment was executed. This report does not imply the current baseline builds or that target coordinates/image exist. Before migration, record `./gradlew clean build` against the current baseline; target acceptance includes the same command on the agreed Java 21 toolchain and a real EAP 8.1 deployment.

## Migration Complexity

| Area | Complexity | Rationale |
|---|---|---|
| Project topology | LOW | One Gradle WAR; no subprojects or inter-module dependency edges |
| PrimeFaces UI/API | LOW-MEDIUM | Few files but multiple interactive widgets and CSS override surface |
| Java namespace | LOW-MEDIUM | Twelve direct namespace imports across five beans; mechanical rename with compile/runtime validation |
| Descriptor/runtime transition | MEDIUM | Three XML descriptors and server-provided APIs change with the platform |
| Build/runtime Java 21 | LOW-MEDIUM | Small source surface; build/runtime not yet validated |
| EAP container/deployment | MEDIUM | Image entitlement, target image architecture, deployment path and server startup are external dependencies |
| Regression testing | MEDIUM | Broad showcase controls but no automated functional suite |
| Overall | LOW-MEDIUM (final stage MEDIUM) | Small codebase; risk concentrated in final cross-stack cutover and limited test evidence |

## Migration Readiness

**Overall: MODERATE.** Target path and stage recipes exist, source surface is bounded, and intended scope is clear. Readiness is limited by absent baseline build evidence, absent automated functional tests, unverified target image/artifact access, and the final namespace/server transition.

Stage 1 entry conditions: establish current successful build and behavior baseline, verify dependency resolution. Final stage entry conditions: all PrimeFaces gates pass, EAP image access is confirmed, Java 21 build is supported, target API/artifact coordinates are resolved, and Jakarta descriptor plan is approved. Detailed readiness gates are in `migration-readiness.md`.

## Automation Potential

**Medium overall.** High automation potential: version-catalog edits, obvious package renames, descriptor coordinate updates, target image strings, scripted `javax` scans. Human review required: resolving exact PF API/tag changes, descriptor schema acceptance, uploaded-file semantics, default theme/CSS regressions, CDI behavior, target EAP image/runtime and functional validation. Automated migration cannot replace container startup or user-visible regression checks.

## Migration Risks

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| EAP 8.1 image unavailable or registry entitlement missing | Medium | High | Confirm access and image reference before final stage |
| Mixed Java EE/Jakarta APIs or stale descriptors | Medium | High | Coordinate dependency/import/descriptor changes; scan source and WAR |
| PrimeFaces upload API/signature mismatch | Medium | Medium | Check exact PF artifact and test upload end-to-end |
| Date/messages/table/export/editor regression | Medium | Medium | Stage-specific targeted smoke tests and visual comparison |
| Gradle/JDK 21 mismatch | Low-medium | Medium | Verify wrapper/build on chosen JDK before platform cutover |
| No automated behavior tests | High | Medium | Manual QA gate for every stage; add automation only by approved scope |
| Architecture mismatch (amd64 vs target image) | Medium | Medium | Verify manifest/platform and test on target Linux architecture |
| Local private artifact overrides repository artifact | Low/unknown | Medium | Inspect local `libs` content/provenance before running transformation |

## Migration Blockers

**No source-level hard blocker was proven**, but these are release gates:

1. Verify Red Hat EAP 8.1 Java 21 image access and approved tag (the repository's documented target is `registry.redhat.io/jboss-eap-8/eap81-openjdk21-runtime-openshift-rhel9:latest`).
2. Confirm PrimeFaces 15.0.16 Jakarta artifact coordinate and any local/private replacement artifact.
3. Establish current baseline build and target Java 21 Gradle build.
4. Obtain stage-by-stage functional QA capacity because no application regression suite exists.
5. Confirm target container architecture and that the deployment filesystem/user assumptions match the selected image.

## Detailed Findings

Canonical findings are recorded once in `findings.md`, `assessment.json`, and `findings.csv`. Finding IDs are stable across those representations. High-priority items concern the namespace/runtime cutover, target image, and test coverage; no database/authentication findings require remediation.

## Effort Projection

| Scenario | Engineering | Engineering days (7.5 h/day) | Agent execution estimate | Elapsed calendar estimate |
|---|---:|---:|---:|---:|
| Best | 25.5 h | 3.4 | 121 min | 10 business days |
| Most likely | 38.5 h | 5.1 | 196 min | 12 business days |
| High risk | 59 h | 7.9 | 312 min | 18 business days |

Effort values use the prior product-delivery estimate and stage reports as primary numerical evidence. AWS Transform minutes are not engineering hours; elapsed business days include QA sequencing and environment delay. Rates are estimates, not measured execution. The existing product report's $0.035/min cost assumption is dated 2026-06-24 and is intentionally not treated as current pricing. Full line-item ranges and confidence are in `effort-estimate.md`.

## Recommended Migration Strategy

Use the repository's staged recipes, one stage at a time; stop and fix any stage that fails compilation or QA before continuing. Establish a baseline; progress through PF 7, 8, 10, 11, 12, 13, and 14 while retaining EAP 7.3/Java 8; then perform the PF 15 Jakarta, Jakarta EE 10, Java 21, EAP 8.1 cutover as a single gated platform stage. Do not run aggregate transformations across QA gates.

## Recommended Migration Sequence

1. Baseline build, artifact-source inspection, image access/architecture check, and five-page smoke test.
2. PF 6.2.30→7.0; build and QA gate.
3. PF 7.0→8.0; build and QA gate.
4. PF 8.0→10.0.0; build and QA gate.
5. PF 10.0.0→11.0.0; build and QA gate.
6. PF 11.0.0→12.0.0; build and QA gate.
7. PF 12.0.0→13.0.0; build and QA gate.
8. PF 13.0.0→14.0.0; build and QA gate.
9. PF 14.0.0→15.0.16 Jakarta plus Java 21, Jakarta EE 10, EAP 8.1; build, deployment, full regression gate.
10. Final acceptance and artifact review.

This sequence is dependency-derived: the current framework dependency is upgraded through the project-approved PrimeFaces path, and the `javax`/server platform boundary is deferred to the final target stage. The workflow reference explicitly skips a normal public PF 9 stage.

## Post-Migration Validation Requirements

- `./gradlew clean build` succeeds under the agreed Java 21 build environment and resolves intended target artifacts.
- WAR contains PrimeFaces Jakarta dependency but does not package duplicate server APIs/Faces implementation.
- No application-owned Java EE `javax.*` imports or stale Java EE descriptors remain; inspect packaged WAR and source while accounting for Java SE namespaces.
- `web.xml`, `beans.xml`, and `jboss-web.xml` are accepted by EAP 8.1; CDI beans resolve; Facelets servlet mapping works.
- Container builds and starts on approved Linux architecture; no deployment/classloading errors in logs.
- Root URL `/`, ROOT.war deployment, port 8080 and multipart behavior remain correct.
- All five pages load; navigation, validation/messages, date control, AJAX, table sorting/filtering, CSV export, text editor, file upload, dialogs, autocomplete, progress and poll are tested.
- Visual regression checks cover `app.css` overrides and browser console.
- QA approves stage-by-stage evidence and final acceptance.

## Conclusions

This repository is a small, well-bounded WAR modernization with a clear target path and unusually strong migration instructions. The principal challenge is not project scale but the final coupled Jakarta/EAP/Java 21 cutover and the lack of automated behavior coverage. Proceed with assessment-approved staged modernization only after prerequisite gates are met. This report is an assessment artefact and does not indicate migration has started.
