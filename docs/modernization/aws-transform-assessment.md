# AWS Transform Modernization Assessment

**Repository:** `primefaces-migration`  
**Assessment date:** 2026-10-27  
**Scope:** Static assessment of the complete repository for the documented PrimeFaces and Jakarta modernization path. No application, build, deployment, or transformation code was changed.

## Executive assessment

This is a small, single-module Java EE web application with a modest UI component surface and a substantial relative platform jump at the final stage. The PrimeFaces-only stages are expected to be mechanical, but each requires a UI check. The final Java EE 8 / `javax.*` to Jakarta EE 10 / `jakarta.*` and EAP 7.3 / Java 8 to EAP 8.1 / Java 21 cutover is the main technical and delivery risk.

| Assessment area | Result |
|---|---|
| Overall complexity | **Low-to-medium**; medium at the final runtime cutover |
| Migration readiness | **Moderate**; staged recipes and migration checks exist, but no behavioral test suite or current baseline build result was established in this assessment |
| Linux readiness | **Partial**; application/container are Linux-oriented, but the configured image and Compose target are `linux/amd64` only |
| Automation confidence | **Medium**; high for mechanical edits, lower for API behavior, deployment, and visual validation |
| Migration risk | **Medium**, concentrated in Jakarta/EAP/Java 21, upload behavior, image access, and inadequate automated regression coverage |
| Recommended approach | Move one PrimeFaces stage at a time and require a QA gate before proceeding |

## Repository and solution inventory

The repository contains 90 tracked paths and approximately 4,612 total tracked lines, including documentation, generated wrapper files, AWS Transform recipes, and reports. The application-specific source/configuration surface is approximately **1,522 lines**: 571 Java lines and 951 webapp lines (XHTML, XML, and CSS). These are raw line counts, not comment- or blank-line-adjusted LOC. The counts are reproducible from the tracked `src/main` files; the application estimate excludes build tooling and modernization documentation.

| Area | Inventory |
|---|---|
| Application | `primefaces-homeoffice`, a Gradle Java WAR named `primefaces-homeoffice.war` |
| Java | 11 source files: six simple model/value classes and five CDI view beans |
| Web UI | Six XHTML files: five application pages plus a shared template; one CSS file |
| Descriptors | `web.xml`, `beans.xml`, and `jboss-web.xml` |
| Build and runtime | Gradle wrapper 8.4, Gradle Java/WAR plugins, Dockerfile, Docker Compose |
| Modernization assets | Eight staged PrimeFaces assessment definitions and eight migration definitions, configs, validators, and prior assessment reports |
| Tests / CI | No test source tree, test framework, or tracked CI pipeline found; repository includes shell validation scripts for assessment/report shape and modernization state |

### Project and module inventory

There is one Gradle root project and no subprojects or separately deployable modules:

| Project/module | Type | Primary responsibilities | Complexity |
|---|---|---|---|
| `primefaces-homeoffice` | Gradle `java` + `war` root project | CDI beans, JSF/Facelets UI, PrimeFaces components, WAR packaging | Low at present; medium for final platform cutover |

### Dependency and deployment graph

```text
Gradle wrapper 8.4
  └─ root Gradle project: primefaces-homeoffice
      ├─ javax:javaee-api:8.0 [provided by application server]
      └─ org.primefaces:primefaces:6.2.30 [implementation; or local libs JAR if present]
          └─ WAR: build/libs/primefaces-homeoffice.war
              └─ Docker build
                  └─ JBoss EAP 7.3.10 / OpenJDK 8 image (linux/amd64)
                      └─ ROOT.war deployed at context root /
```

The application server supplies the Java EE APIs; PrimeFaces is packaged as the application dependency. Docker image access requires the configured Red Hat registry image. Maven Central is configured for dependency resolution, with a `mavenLocal()` repository also present. The private/local PrimeFaces JAR path takes precedence when that exact file exists.

## Framework and runtime baseline

| Concern | Current repository setting | Intended target in modernization assets |
|---|---|---|
| Java | Source/target compatibility 1.8 | Java 21 |
| Enterprise APIs | Java EE 8 API, `javax.*` | Jakarta EE 10 API, `jakarta.*` |
| UI framework | PrimeFaces 6.2.30 | PrimeFaces 15.0.16 Jakarta artifact |
| Server | JBoss EAP 7.3.10.GA | JBoss EAP 8.1 |
| Build | Gradle wrapper 8.4 | Keep Gradle; target recipe anticipates a wrapper/toolchain update as required for Java 21 |
| Packaging | WAR, deployed as `ROOT.war` | Keep WAR and root context |
| View technology | JSF / Facelets | Jakarta Faces 4 / Facelets |

These are repository-declared versions and intended targets. This assessment did not resolve dependencies, verify external artifact availability, or execute a build against either runtime.

## Package compatibility and deprecated/incompatible APIs

| Current dependency or API | Assessment for the target | Required action |
|---|---|---|
| `javax:javaee-api:8.0` | Java EE namespace is incompatible with a Jakarta EE 10 target; this is a provided dependency, not an application-bundled implementation | Replace with `jakarta.platform:jakarta.jakartaee-api:10.0.0` as provided, as described in the target recipe |
| PrimeFaces `6.2.30` | Legacy baseline relative to the intended PF 15 target; current README identifies it as an Elite/PRO maintenance artifact | Advance through the staged versions; verify the exact artifact coordinates and any local/private JAR at each stage |
| `javax.enterprise.*`, `javax.inject.*`, `javax.faces.*` | Namespace changes are required for Jakarta EE; found in five Java files and `web.xml` | Convert imports, context parameter names, and Faces servlet class together; check packaged output for residual Java EE references |
| `org.primefaces.model.UploadedFile` | Known migration check in repository's own skill: target PF 15 API uses `org.primefaces.model.file.UploadedFile` | Update the import and verify any associated methods against the exact target artifact |
| `p:calendar` | Identified by staged reports as deprecated in later PrimeFaces versions in favor of `p:datePicker` | Migrate and validate date selection, formatting, and AJAX behavior |
| `p:growl` | Staged PF 14 assessment identifies removal/deprecation; `elements.xhtml` currently uses it alongside `p:messages` | Replace/remove as required by the target version and confirm messages remain visible |
| PrimeFaces upload, exporter, editor, table, and component attributes | Staged reports call out API and behavior changes across the version path | Check each against the stage's matching migration guide/tag library and run functional checks |
| XML descriptors and JSF configuration | Current descriptors use Java EE/JCP namespaces and Faces 4 target expects Jakarta schema/configuration | Update all three descriptors in coordination with the runtime change; verify deployment on EAP 8.1 |

No evidence was found for additional third-party libraries, PrimeFaces Extensions, Spring, Hibernate, or a separately managed ORM. Unsupported status outside the explicit target incompatibilities above was not independently checked against vendor lifecycle records.

## Platform and operational assessment

**Windows-specific dependencies:** No application dependency on Windows APIs or Windows-only libraries was found. `gradlew.bat` is the standard Gradle Windows launcher, not a production dependency. The application and deployment are containerized for Linux.

**Linux readiness:** The runtime is explicitly configured for `linux/amd64` in the Dockerfile and Compose file, so an x86_64 Linux container host is the intended platform. This does not establish ARM-native support; current Docker configuration relies on emulation on ARM hosts. Linux readiness is therefore **partial**, with image availability, registry authentication, architecture, and EAP 8.1 startup still requiring an environment smoke test.

**Database and ORM:** None detected. Data in the sample app is held in Java beans/static collections; no JDBC, JPA, Hibernate, datasource, schema, or migration tool was found.

**Authentication and authorization:** None detected or in scope. No identity provider, security framework, login flow, or application roles were found.

**Configuration:** Configuration is small but spread across `gradle/libs.versions.toml`, `build.gradle`, `web.xml`, `beans.xml`, `jboss-web.xml`, Docker build arguments, Compose, Make targets, and AWS Transform YAML. Target namespace/version changes must be consistent across these surfaces. Registry access and the target EAP image are environment prerequisites.

**Build and deployment complexity:** Low-to-medium. The Gradle WAR build is simple, but the final image replacement, Java 21 build compatibility, EAP descriptor compatibility, registry entitlement, and container startup add external dependencies not covered by a compile-only check.

## Test and automation indicators

- No automated Java or browser test suite and no tracked CI configuration were found.
- The repository has validators for report structure and selected modernization acceptance conditions, but they are not functional regression tests.
- `elements.xhtml` is a broad component showcase. It includes file upload, date input, data tables, exporter, text editor, AJAX, dialog, progress, and other controls, which is useful for targeted smoke testing and is also the primary regression surface.
- AWS Transform recipes cover eight version steps: 6.2.30→7, 7→8, 8→10, 10→11, 11→12, 12→13, 13→14, and 14→15 Jakarta/EAP 8.1. The recipes and existing reports materially improve repeatability, but do not replace testing.
- Automation confidence is **medium**: high for version/catalog, namespace, and descriptor edits; medium-low for PrimeFaces behavior, themes, upload, EAP deployment, and full UI acceptance without tests.

## Modernization blockers and migration risks

1. **Target runtime and registry access:** The EAP 8.1 image and its access/subscription requirements must be confirmed before the last stage.
2. **Gradle/Java 21 compatibility:** The wrapper is 8.4; test the build with Java 21 and upgrade the wrapper only if required by the actual toolchain/build result.
3. **Jakarta boundary:** Five Java files and XML configuration currently use `javax.*`; mixed namespaces or stale descriptor schemas can prevent deployment.
4. **PrimeFaces compatibility:** Existing upload API, date component, growl, table attributes, exporter, and editor need per-stage checks.
5. **No automated behavioral coverage:** Manual QA is necessary until a minimal regression suite is introduced or equivalent repeatable test evidence is available.
6. **Architecture constraint:** Container configuration currently targets `linux/amd64`; do not assume ARM-native or multi-architecture support.
7. **Private artifact fallback:** A local PrimeFaces JAR can override Maven resolution; its provenance and target version need verification if supplied.

The scope deliberately contains no database, authentication, REST, messaging, or ORM modernization work, keeping the risk concentrated in the UI and runtime platform.

## Assessment evidence and confidence

Primary evidence was read from `README.md`, `build.gradle`, `settings.gradle`, `gradle/libs.versions.toml`, the Gradle wrapper properties, Dockerfile, Compose file, Java/XHTML/XML sources, and the repository's `.aws/atx` skill and `aws-transform/eap-primefaces-modernization` definitions/reports. Counts are repository inspections; the effort figures are inherited from the per-stage assessments and `reports/product-delivery-assessment.md` (dated 2026-06-24), not generated by a fresh AWS Transform run.

**Confidence:** High for project inventory, declared versions, namespace use, and absence of in-repository database/auth/test modules. Medium for compatibility conclusions grounded in repository migration recipes. Low-to-medium for effort and calendar estimates because they are historical planning estimates and no current build, live target deployment, or AWS Transform assessment run was performed.
