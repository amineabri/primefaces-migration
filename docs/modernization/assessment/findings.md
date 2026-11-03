# Detailed Assessment Findings

Findings are ordered by migration relevance. Severity is LOW, MEDIUM, HIGH, or CRITICAL. Confidence reflects repository evidence and specificity, not probability of failure. Finding IDs are stable and match `assessment.json` and `findings.csv`. Individual effort is indicative and overlaps staged/project QA allocations; do not sum finding effort to produce the project total.

## ATX-FIND-001 — Java 8 build/runtime must move to Java 21

- **Category:** JAVA VERSION; RUNTIME
- **Affected project:** `primefaces-homeoffice`
- **Affected files:** `build.gradle:10-13`; `Dockerfile:1`
- **Current technology/API:** Java 8 source/target and EAP OpenJDK 8 image
- **Target technology/API:** Java 21
- **Evidence:** `build.gradle` declares `VERSION_1_8`; Dockerfile image is eap73-openjdk8.
- **Severity / complexity:** HIGH / MEDIUM
- **Migration impact:** Align build compiler and runtime; source has not been tested on Java 21.
- **Automation potential:** HIGH for settings; MEDIUM for validation
- **Estimated remediation effort:** 1.5 engineering hours
- **Confidence:** HIGH
- **Recommended remediation:** Set Java 21 compatibility/toolchain after verifying Gradle and runtime; build and run on the target JDK.
- **Validation requirement:** Run clean build on Java 21 and start the target container.

## ATX-FIND-002 — Gradle wrapper 8.4 requires Java 21 compatibility verification

- **Category:** BUILD
- **Affected project:** `primefaces-homeoffice`
- **Affected files:** `gradle/wrapper/gradle-wrapper.properties:3`; `build.gradle`
- **Current technology/API:** Gradle wrapper 8.4
- **Target technology/API:** Retain or update wrapper based on Java 21 build evidence
- **Evidence:** `distributionUrl` pins `gradle-8.4-bin.zip`; no Java 21 build was run.
- **Severity / complexity:** MEDIUM / LOW-MEDIUM
- **Migration impact:** Toolchain incompatibility could prevent target build.
- **Automation potential:** MEDIUM
- **Estimated remediation effort:** 1.5 engineering hours
- **Confidence:** MEDIUM
- **Recommended remediation:** Test wrapper 8.4 with the selected JDK; upgrade only if required by build evidence or policy.
- **Validation requirement:** Run `./gradlew clean build` using Java 21.

## ATX-FIND-003 — Java EE API dependency must be replaced with Jakarta EE 10 API

- **Category:** DEPENDENCY; JAVA EE; JAKARTA EE
- **Affected project:** `primefaces-homeoffice`
- **Affected files:** `gradle/libs.versions.toml:2,6`; `build.gradle:17-18`
- **Current technology/API:** `javax:javaee-api:8.0`, provided
- **Target technology/API:** Jakarta EE 10 API, provided
- **Evidence:** Version catalog declares Java EE aggregate API and build places it in `providedCompile`.
- **Severity / complexity:** HIGH / MEDIUM
- **Migration impact:** Old API namespaces cannot serve as target Jakarta API.
- **Automation potential:** HIGH
- **Estimated remediation effort:** 1.5 engineering hours
- **Confidence:** HIGH
- **Recommended remediation:** Replace version catalog coordinate with approved Jakarta EE 10 API while retaining provided scope.
- **Validation requirement:** Inspect resolved graph and WAR to ensure target API compiles and is not bundled.

## ATX-FIND-004 — Application bean imports use javax namespace

- **Category:** NAMESPACE; JAVA EE; JAKARTA EE
- **Affected project:** `primefaces-homeoffice`
- **Affected files:** `DashboardBean.java:10-11`; `ElementsBean.java:13-16`; `EmployeeBean.java:9-10`; `HomeBean.java:9-10`; `ReportsBean.java:9-10`
- **Current technology/API:** Twelve `javax.enterprise`, `javax.inject`, and `javax.faces` imports in five files
- **Target technology/API:** Jakarta equivalents
- **Evidence:** Twelve `javax` EE imports across all five view beans; no `jakarta` imports currently found.
- **Severity / complexity:** HIGH / LOW-MEDIUM
- **Migration impact:** Mixed namespaces can prevent CDI/Faces linkage.
- **Automation potential:** HIGH mechanical; compile/runtime review required
- **Estimated remediation effort:** 2 engineering hours
- **Confidence:** HIGH
- **Recommended remediation:** Replace imports with corresponding `jakarta` packages and verify CDI names/scopes.
- **Validation requirement:** Compile; confirm every named bean resolves on EAP 8.1.

## ATX-FIND-005 — Web, CDI and JBoss descriptors require target validation/conversion

- **Category:** DESCRIPTOR; CONFIGURATION; JAKARTA EE
- **Affected project:** `primefaces-homeoffice`
- **Affected files:** `WEB-INF/web.xml:2-5,10,15,26`; `WEB-INF/beans.xml:2-6`; `WEB-INF/jboss-web.xml:2-6`
- **Current technology/API:** Java EE web 4.0, CDI beans 1.1, JBoss schema 7.2
- **Target technology/API:** Jakarta descriptors accepted by EAP 8.1
- **Evidence:** Current namespaces, schemas, Faces names and root context are declared in these descriptors.
- **Severity / complexity:** HIGH / MEDIUM
- **Migration impact:** Stale schemas/classes can block deployment; root context must remain.
- **Automation potential:** HIGH for literals; MEDIUM for schema/runtime validation
- **Estimated remediation effort:** 2 engineering hours
- **Confidence:** HIGH
- **Recommended remediation:** Convert descriptors, retain CDI annotated mode, URL mapping, multipart limits and context root.
- **Validation requirement:** Deploy and inspect logs; test root route, Faces servlet and CDI.

## ATX-FIND-006 — PrimeFaces baseline must move through the documented staged path

- **Category:** FRAMEWORK; PRIMEFACES; DEPENDENCY
- **Affected project:** `primefaces-homeoffice`
- **Affected files:** `gradle/libs.versions.toml:3,7`; all XHTML
- **Current technology/API:** PrimeFaces 6.2.30
- **Target technology/API:** PrimeFaces 15.0.16 Jakarta
- **Evidence:** Version catalog and eight staged migration definitions/report pairs.
- **Severity / complexity:** HIGH / MEDIUM
- **Migration impact:** Eight version transitions can affect component tags, APIs and client resources.
- **Automation potential:** HIGH for version edits; MEDIUM for API changes
- **Estimated remediation effort:** 3 engineering hours
- **Confidence:** HIGH
- **Recommended remediation:** Use PF 7, 8, 10, 11, 12, 13, 14 and 15 stages with QA gates.
- **Validation requirement:** Build and test each stage before proceeding.

## ATX-FIND-007 — UploadedFile API package changes for PrimeFaces 15

- **Category:** PRIMEFACES; API
- **Affected project:** `primefaces-homeoffice`
- **Affected files:** `ElementsBean.java:5,49,202,206`
- **Current technology/API:** `org.primefaces.model.UploadedFile`
- **Target technology/API:** `org.primefaces.model.file.UploadedFile` per project migration skill
- **Evidence:** Current import/type locations and target package called out in repository skill.
- **Severity / complexity:** MEDIUM / LOW
- **Migration impact:** Stale type or methods can fail compilation/upload.
- **Automation potential:** HIGH for import; MEDIUM for method/API validation
- **Estimated remediation effort:** 1 engineering hour
- **Confidence:** HIGH
- **Recommended remediation:** Update package and validate PF 15 file methods and listener signature.
- **Validation requirement:** Compile and perform end-to-end file upload.

## ATX-FIND-008 — Calendar component is a staged deprecation/migration concern

- **Category:** PRIMEFACES; API
- **Affected project:** `primefaces-homeoffice`
- **Affected files:** `elements.xhtml:55-57`
- **Current technology/API:** `p:calendar` with pattern, `showOn`, and `dateSelect`
- **Target technology/API:** `p:datePicker` where required by target stages
- **Evidence:** Current component is used in Elements page; stage assessments identify calendar transition.
- **Severity / complexity:** MEDIUM / LOW-MEDIUM
- **Migration impact:** Date formatting, popup and AJAX selection can change.
- **Automation potential:** MEDIUM
- **Estimated remediation effort:** 1.5 engineering hours
- **Confidence:** MEDIUM
- **Recommended remediation:** Check stage taglib and migrate when required; preserve date pattern and update behavior.
- **Validation requirement:** Select, submit and display date; verify AJAX summary.

## ATX-FIND-009 — Growl component requires compatibility check or replacement

- **Category:** PRIMEFACES; API
- **Affected project:** `primefaces-homeoffice`
- **Affected files:** `elements.xhtml:18-22`
- **Current technology/API:** `p:growl` alongside `p:messages`
- **Target technology/API:** Supported messages component/update pattern
- **Evidence:** Growl and messages are both present; PF14 report identifies growl deprecation/removal.
- **Severity / complexity:** MEDIUM / LOW
- **Migration impact:** Feedback could disappear or duplicate.
- **Automation potential:** HIGH for markup; human behavior test
- **Estimated remediation effort:** 1 engineering hour
- **Confidence:** MEDIUM
- **Recommended remediation:** Apply target-supported messages pattern only after verifying release taglib.
- **Validation requirement:** Trigger validation and action messages; verify visibility and no duplicates.

## ATX-FIND-010 — PrimeFaces component and CSS regression surface requires staged validation

- **Category:** PRIMEFACES; API; TESTING
- **Affected project:** `primefaces-homeoffice`
- **Affected files:** `elements.xhtml:74-250`; `employees.xhtml:16-35`; `dashboard.xhtml:26-39`; `reports.xhtml:41-48`; `app.css`
- **Current technology/API:** Tables, upload, exporter, editor, AJAX, dialog, autocomplete, date and custom styles
- **Target technology/API:** Components and styles compatible with each target release
- **Evidence:** Actual component usage and 412-line CSS file; prior stage reports identify UI behavior changes.
- **Severity / complexity:** MEDIUM / MEDIUM
- **Migration impact:** Runtime/taglib errors and visual or interaction regressions.
- **Automation potential:** MEDIUM
- **Estimated remediation effort:** 6 engineering hours
- **Confidence:** MEDIUM
- **Recommended remediation:** Use a per-stage UI regression checklist and inspect target taglib/API.
- **Validation requirement:** Test all five pages; upload/export/editor/table/date/AJAX; browser console and visuals.

## ATX-FIND-011 — EAP 7.3 container must be replaced and EAP 8.1 access confirmed

- **Category:** APPLICATION SERVER; DEPLOYMENT
- **Affected project:** `primefaces-homeoffice`
- **Affected files:** `Dockerfile:1-15`; `docker-compose.yml:1-13`
- **Current technology/API:** EAP 7.3.10 OpenJDK 8 image
- **Target technology/API:** EAP 8.1 OpenJDK 21 image
- **Evidence:** Current image and deployment paths are explicit; target image is declared by repository skill.
- **Severity / complexity:** HIGH / MEDIUM
- **Migration impact:** Entitlement, architecture, filesystem or runtime mismatch can prevent deploy.
- **Automation potential:** MEDIUM
- **Estimated remediation effort:** 3 engineering hours
- **Confidence:** HIGH
- **Recommended remediation:** Confirm approved target image, access and image conventions; update Docker/Compose consistently.
- **Validation requirement:** Build/start image, inspect logs, verify root WAR and port 8080.

## ATX-FIND-012 — Linux target is configured to amd64 pending target image verification

- **Category:** LINUX; DEPLOYMENT
- **Affected project:** `primefaces-homeoffice`
- **Affected files:** `Dockerfile:2,4`; `docker-compose.yml:3,6-10`
- **Current technology/API:** `linux/amd64` forced
- **Target technology/API:** Supported platform(s) of approved EAP 8.1 image
- **Evidence:** Dockerfile and Compose declare amd64; target image manifest has not been checked.
- **Severity / complexity:** MEDIUM / LOW
- **Migration impact:** No ARM-native or multi-architecture readiness can be assumed.
- **Automation potential:** MEDIUM
- **Estimated remediation effort:** 0.5 engineering hours
- **Confidence:** HIGH
- **Recommended remediation:** Confirm target manifest and build/run on intended Linux architecture.
- **Validation requirement:** Inspect image manifest and run container on target host.

## ATX-FIND-013 — No automated behavioral test coverage is present

- **Category:** TESTING
- **Affected project:** `primefaces-homeoffice`
- **Affected files:** No `src/test` or CI files found; `build.gradle`
- **Current technology/API:** No test framework, test source tree or tracked CI pipeline
- **Target technology/API:** Stage-by-stage repeatable regression evidence
- **Evidence:** Repository inventory; shell validators cover modernization checks, not UI behavior.
- **Severity / complexity:** HIGH / MEDIUM
- **Migration impact:** Behavioral regressions may escape compile-only checks.
- **Automation potential:** LOW for current manual scope
- **Estimated remediation effort:** 12 engineering hours
- **Confidence:** HIGH
- **Recommended remediation:** Require manual QA gates for every stage; consider tests only as separately approved scope.
- **Validation requirement:** Record all-page regression evidence for each version and final EAP deployment.

## ATX-FIND-014 — Optional private PrimeFaces JAR can override resolved module

- **Category:** DEPENDENCY; BUILD
- **Affected project:** `primefaces-homeoffice`
- **Affected files:** `build.gradle:15-23`; `libs/`
- **Current technology/API:** Conditional `libs/primefaces-<version>.jar` override
- **Target technology/API:** Verified PF 15.0.16 Jakarta artifact if override is retained
- **Evidence:** Gradle conditionally selects local file; no versioned PF JAR is tracked.
- **Severity / complexity:** MEDIUM / LOW
- **Migration impact:** Build may use stale, wrong-version or non-Jakarta artifact.
- **Automation potential:** MEDIUM
- **Estimated remediation effort:** 0.5 engineering hours
- **Confidence:** HIGH
- **Recommended remediation:** Inspect local artifact source/version/classifier; retain only verified target artifact.
- **Validation requirement:** Inspect resolved dependency and WAR contents.

## Finding Notes

- ATX-FIND-006 is an umbrella finding. Component/API details are in ATX-FIND-007 through ATX-FIND-010.
- ATX-FIND-010 and ATX-FIND-013 represent validation work spanning stages. The project effort projection is authoritative; finding-level estimates are not additive.
- No critical finding or source-level hard blocker was established. EAP image access/artifact verification and test evidence are required gates.
- Database, persistence, authentication and security-library absence is documented in the assessment; no remediation is identified.
- Namespace/API migration notes from prior reports are hypotheses until checked against exact target artifacts.
