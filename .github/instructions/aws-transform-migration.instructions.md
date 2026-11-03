---
description: Repository-specific gated instructions for the assessed PrimeFaces, Jakarta EE, Java 21 and EAP 8.1 migration.
applyTo: "**/*"
---

# AWS Transform Migration Instructions — `primefaces-homeoffice`

These instructions implement the approved assessment in `docs/modernization/assessment/`. Read `migration-state.json`, the assessment manifest/JSON and transformation plan before acting. This file is not authorization to migrate: wait for an explicit user request.

## Target and invariants

| Concern | Current | Assessed target |
|---|---|---|
| PrimeFaces | 6.2.30 | 15.0.16 Jakarta classifier |
| Java | 8 source/target; EAP OpenJDK 8 runtime | Java 21 |
| Platform | Java EE 8, `javax.*` | Jakarta EE 10 |
| Application server | JBoss EAP 7.3.10 | JBoss EAP 8.1 |
| Build/package | Gradle 8.4 wrapper; single WAR | Keep Gradle WAR; verify wrapper on Java 21 |
| Deployment | `ROOT.war`, context `/`, port 8080 | Preserve |

Preserve all sample functionality and existing pages. Do not introduce persistence, security/authentication, REST, messaging, or unrelated refactoring. Keep platform APIs server-provided. A local `libs/primefaces-<version>.jar` may override repository resolution; inspect and verify before use.

## Authoritative sequence decision

The assessment plan defines baseline, the eight PrimeFaces version transitions, a final combined PF15 Jakarta/EE10/Java21/EAP8.1 cutover, and final acceptance. Therefore use:

```text
MIG-00 Baseline gate
  → MIG-01 PF 6.2.30 → 7.0
  → MIG-02 PF 7.0 → 8.0
  → MIG-03 PF 8.0 → 10.0.0
  → MIG-04 PF 10.0.0 → 11.0.0
  → MIG-05 PF 11.0.0 → 12.0.0
  → MIG-06 PF 12.0.0 → 13.0.0
  → MIG-07 PF 13.0.0 → 14.0.0
  → MIG-08 Coordinated PF14 → PF15 Jakarta + Jakarta EE 10 + Java 21 + EAP 8.1
  → MIG-09 Final acceptance
```

The user-suggested PF7→8 start omits the repository's current PF6.2.30→7 transition. The user-suggested separately buildable Jakarta/Java/EAP steps differ from the assessed final stage, which couples those changes. The final cutover must be treated as one atomic source/build/deployment change set with ordered subphases and one build gate; do not commit or checkpoint a broken mixed-namespace state as complete. No PF 9 stage is defined.

## Stage execution contract

Before each stage, verify:

- all prior stages and their build/test/QA gates are recorded complete;
- assessment blockers for this stage are cleared;
- there is no unrelated dirty/conflicting change;
- an identifiable Git checkpoint exists (record commit hash or branch/base reference; do not make a commit unless requested).

Run the build loop after each stage: resolve dependencies → `./gradlew clean build` → analyze failures → make narrowly scoped remediation → rebuild → `./gradlew test` → manual QA/validator gate → checkpoint and state/log update. Do not proceed while the prior stage is uncompilable or its validation gate is incomplete.

`./gradlew test` is the available Gradle test task, but there are no test sources/framework or CI tests in the assessed repository. Report this accurately. Manual behavior validation is required and cannot be replaced by an empty test task.

### Mandatory theme and browser report for every remaining phase

Read `docs/modernization/migration/theme-browser-gates.md` and the matching `remainingPhaseGates` state entry before MIG-04 through MIG-08. Complete the following report with release-specific evidence before marking any stage complete:

| Field | Controlled values |
|---|---|
| Theme compatibility | PASS / LEGACY / CHANGES REQUIRED / REPLACEMENT REQUIRED / RUNTIME VALIDATION REQUIRED |
| Current theme / target theme | Actual concrete names; previous declared baseline Omega, explicit user-approved Saga replacement implemented in MIG-04; never infer historical Saga deployment |
| Omega status | SUPPORTED / LEGACY / INCOMPATIBLE / REPLACED |
| Custom CSS impact | NONE / LOW / MEDIUM / HIGH |
| Visual validation | PASS / PARTIAL / DEFERRED |
| Browser compatibility | PASS / CHANGES REQUIRED / PRODUCT DECISION REQUIRED |
| IE-specific code detected | YES / NO with scope/evidence |
| IE support impact | NONE / LOW / MEDIUM / HIGH / CRITICAL; unknown business requirement requires a decision, not inferred NONE |

Keep STATIC THEME COMPATIBILITY separate from RUNTIME VISUAL VALIDATION. No runtime means RUNTIME VISUAL VALIDATION DEFERRED; only explicit stage risk acceptance allows conditional visual completion. Stop for unresolved static theme choice/resource incompatibility or required product browser decision. Explicitly record framework default, application configuration and fallback status at every version. UNCONTROLLED VISUAL CHANGE from implicit fallback cannot be accepted as a passing gate.

Omega's bundled resources were removed at MIG-03/PF10. The missed static gate was resolved in MIG-04 after explicit user approval of Saga with existing CSS; runtime visuals remain DEFERRED. Revalidate concrete theme/resources every future phase rather than reopening an already approved choice or pretending Omega removal is a PF15-only task. PrimeOne is the design system, not a literal theme.

At IE-removal boundary, classify each detected workaround REMOVE / RETAIN FOR OTHER BROWSERS / REPLACE / UNKNOWN — MANUAL REVIEW. Do not remove any before proven obsolete. Record IE business requirements even when code scan finds none; unknown or mandatory IE stops the first unsupported target for MANUAL PRODUCT DECISION REQUIRED.

## MIG-00 — Baseline build and readiness

**Objective:** Establish an observed baseline and distinguish existing failures from migration-introduced failures.

**Preconditions:** Explicit migration authorization; clean, understood worktree; Java/Gradle and dependency repository access.

**Assessment findings addressed:** ATX-FIND-002, ATX-FIND-013, ATX-FIND-014; prerequisites for all later findings.

**Files/components affected:** None initially. Inspect `build.gradle`, `gradle/libs.versions.toml`, `gradle/wrapper/gradle-wrapper.properties`, `libs/`, `Dockerfile`, `docker-compose.yml`, and all five pages.

**Required changes:** No migration changes. Record the current JDK/Gradle versions, current `./gradlew clean build` result, all errors/warnings, `./gradlew test` result, exact PrimeFaces source (Maven/local), optional local JAR presence/provenance, runtime/deployment prerequisites, and five-page behavior. Mark unknown items unknown.

**Dependency changes — FROM / TO:** None / None.

**API/source transformations:** None.

**Build validation:** `./gradlew clean build`.

**Test validation:** `./gradlew test`; manual baseline smoke test. No automated functional suite is present.

**Completion criteria:** Baseline build result, warnings/errors, test result and deployment prerequisites are recorded in state/log. A failing baseline is documented and analyzed before any source transformation.

**Failure handling:** Resolve environment/dependency access if possible. Do not repair unrelated/pre-existing defects silently; establish whether failures are in scope. If baseline cannot be understood, stop before MIG-01.

**Rollback/checkpoint:** Preserve the original clean revision and record its hash. Do not modify application files in this gate.

## MIG-01 — PrimeFaces 6.2.30 → 7.0

**Objective:** Upgrade the current dependency to PF 7 while retaining Java EE 8/EAP 7.3/Java 8.

**Preconditions:** MIG-00 complete; PF 7 artifact resolves; baseline failures/warnings recorded.

**Assessment findings addressed:** ATX-FIND-006, ATX-FIND-010.

**Files/components affected:** `gradle/libs.versions.toml`; inspect `src/main/webapp/employees.xhtml`, `elements.xhtml`, `dashboard.xhtml`, `reports.xhtml`, `WEB-INF/templates/main.xhtml`, and `resources/css/app.css`.

**Required changes:** Change only the PF version/catalog entry and evidence-backed PF7 syntax/style changes. Inspect used table `sortBy`/`filterBy`, calendar/date behavior, menu/AJAX behavior, and CSS. Do not apply generic fixes unsupported by actual errors or PF7 tag metadata.

**Dependency changes — FROM / TO:** `org.primefaces:primefaces:6.2.30` → PF 7.0 artifact, same non-Jakarta Java EE line.

**API/source transformations:** Only PF7 changes proven relevant to current XHTML. No namespace conversion.

**Build validation:** `./gradlew clean build`.

**Test validation:** `./gradlew test`; manually load all pages; test tables, date control, navigation/AJAX and visual baseline.

**Completion criteria:** PF7 artifact resolved; build and tests pass relative to baseline; relevant UI checks pass; stage result is logged and checkpointed.

**Failure handling:** Retry/remediate deterministic PF7 errors. If API/tag semantics are ambiguous or behavior fails, stop for manual review.

**Rollback/checkpoint:** Record the pre-stage Git checkpoint; preserve the passing PF6.2.30 revision/artifact.

## MIG-02 — PrimeFaces 7.0 → 8.0

**Objective:** Move to PF8 on the same Java EE/EAP baseline and validate upload/date usage.

**Preconditions:** MIG-01 complete, build and QA gate passed.

**Assessment findings addressed:** ATX-FIND-006, ATX-FIND-007, ATX-FIND-008, ATX-FIND-010.

**Files/components affected:** `gradle/libs.versions.toml`; `src/main/java/com/example/homeoffice/view/ElementsBean.java`; `src/main/webapp/elements.xhtml`.

**Required changes:** Update PF catalog version. Inspect `FileUploadEvent`, `UploadedFile`, listener binding, `p:fileUpload`, date/calendar syntax, and methods against the exact PF8 artifact. Make only changes confirmed by compiler/taglib/migration documentation.

**Dependency changes — FROM / TO:** PrimeFaces 7.0 → PrimeFaces 8.0; Java EE 8 APIs unchanged.

**API/source transformations:** Update only demonstrated file-upload/date APIs. The PF15 `UploadedFile` target relocation is not automatically applied here unless PF8 evidence requires it.

**Build validation:** `./gradlew clean build`.

**Test validation:** `./gradlew test`; manually test upload listener, date selection, tables, exporter/editor, and all pages.

**Completion criteria:** Build/test pass; upload reaches the listener; date, tables and page smoke checks pass.

**Failure handling:** Remediate clear compile errors; inspect exact PF8 API for uncertain methods. Stop if upload behavior cannot be validated.

**Rollback/checkpoint:** Record pre-stage checkpoint; preserve passing PF7 state.

## MIG-03 — PrimeFaces 8.0 → 10.0.0

**Objective:** Advance to PF10 and address only relevant API/configuration changes.

**Preconditions:** MIG-02 complete and all stage gates pass.

**Assessment findings addressed:** ATX-FIND-006, ATX-FIND-007, ATX-FIND-010.

**Files/components affected:** Version catalog; `src/main/java/com/example/homeoffice/view/ElementsBean.java`; `src/main/webapp/WEB-INF/web.xml` uploader parameter if unsupported; `src/main/webapp/elements.xhtml`; `src/main/webapp/resources/css/app.css`.

**Required changes:** Update dependency version. Verify `UploadedFile` methods/package, `primefaces.UPLOADER` setting, autocomplete and table expressions, client resources/CSS. Remove the uploader parameter only if PF10 documentation/behavior confirms it is obsolete.

**Dependency changes — FROM / TO:** PrimeFaces 8.0 → 10.0.0; Java EE API remains provided and unchanged.

**API/source transformations:** Confirm actual file API changes before changing imports/methods; validate all used XHTML tag attributes.

**Build validation:** `./gradlew clean build`.

**Test validation:** `./gradlew test`; upload, autocomplete, table filter/sort, CSV export, browser console and CSS visual check.

**Completion criteria:** Build/test and targeted UI checks pass; obsolete configuration is not retained without a reason.

**Failure handling:** Fix clear compile/tag errors; stop on uncertain event/upload semantics or unresolved UI behavior.

**Rollback/checkpoint:** Record pre-stage checkpoint; preserve passing PF8 state.

## MIG-04 — PrimeFaces 10.0.0 → 11.0.0

**Objective:** Upgrade PF11 on the existing Java EE/EAP baseline.

**Preconditions:** MIG-03 complete and gate passed.

**Mandatory theme/browser gate:** Apply `docs/modernization/migration/theme-browser-gates.md`. The missed MIG-03 Omega-removal gate was resolved statically in MIG-04 after explicit user approval: Saga configured, bundled resources and supported icon classes verified, custom CSS retained. Read the actual state/log before repeating any stage. Check PF11 defaults/resources/browser policy independently; no implicit default fallback. Runtime visuals are separately DEFERRED if unavailable, never PASS.

**Assessment findings addressed:** ATX-FIND-006, ATX-FIND-010.

**Files/components affected:** Catalog; `elements.xhtml`, `employees.xhtml`, other page tables, `app.css`.

**Required changes:** Version update plus only used-attribute fixes demonstrated by PF11 tag metadata/compiler. Check date defaults, table behavior, messages and CSS; no CSP header/custom JS use was detected.

**Dependency changes — FROM / TO:** PrimeFaces 10.0.0 → 11.0.0; enterprise API unchanged.

**API/source transformations:** No blanket component migration. Apply only exact PF11 changes affecting this app.

**Build validation:** `./gradlew clean build`.

**Test validation:** `./gradlew test`; all-page smoke, date/tables/messages, visual comparison.

**Completion criteria:** Build and gates pass; log/checkpoint saved.

**Failure handling:** Remediate deterministic failures; stop if changes exceed known PF11 impact.

**Rollback/checkpoint:** Record prior PF10 checkpoint and retain passing artifact.

## MIG-05 — PrimeFaces 11.0.0 → 12.0.0

**Objective:** Upgrade PF12 and protect export, upload, editor and table behavior.

**Preconditions:** MIG-04 complete and gate passed.

**Mandatory theme/browser gate:** Revalidate the explicitly selected theme on PF12, default-theme changes, resource dependencies and custom CSS. Omega is not presumed usable merely because old CSS exists. Record PF12 browser/IE support and business requirements in preparation for the removal gate. Use the mandatory report fields and stop on undecided static/theme compatibility.

**Assessment findings addressed:** ATX-FIND-006, ATX-FIND-007, ATX-FIND-010.

**Files/components affected:** Catalog; `ElementsBean.java`; `elements.xhtml:141-229`; `employees.xhtml`; `app.css`.

**Required changes:** Update PF version; inspect exporter, file upload, editor/Quill, table filter/sort and client resources against PF12. No API adjustment without evidence.

**Dependency changes — FROM / TO:** PrimeFaces 11.0.0 → 12.0.0; enterprise API unchanged.

**API/source transformations:** Apply target-confirmed changes only; preserve existing values and sample data.

**Build validation:** `./gradlew clean build`.

**Test validation:** `./gradlew test`; test CSV download/content, upload, editor submission, filters, browser console and visuals.

**Completion criteria:** Build/test and feature checks pass.

**Failure handling:** Remediate clear compatibility issues; stop if feature semantics or data handling is uncertain.

**Rollback/checkpoint:** Record prior PF11 checkpoint.

## MIG-06 — PrimeFaces 12.0.0 → 13.0.0

**Objective:** Upgrade PF13 and validate file upload, table and exporter.

**Preconditions:** MIG-05 complete and gate passed.

**Mandatory theme/browser gate:** Revalidate theme/resources/DOM/CSS. The PF12-to-PF13 IE gate was explicitly accepted before MIG-06 edits: user confirms IE NOT required, support dropped with PF13. No IE-only application code was found/removed; no speculative polyfills. Preserve that decision and reassess only if requirements change. Named modern-browser/version matrix and runtime checks remain outstanding. Static theme and runtime visual results remain separate.

**Assessment findings addressed:** ATX-FIND-006, ATX-FIND-007, ATX-FIND-010.

**Files/components affected:** Catalog; `ElementsBean.java:4-5,49,84,202-206`; `elements.xhtml:150-182,211-220`.

**Required changes:** Update PF version. PF13 removes p:repeat: migrate its sole usage to ui:repeat. TextEditor height becomes a CSS String: retain the intended size with 150px. Current upload/table/dialog/Saga controls remain supported and unchanged; do not apply stale uploader-removal or platform-minimum hypotheses from the historical assessment.

**Dependency changes — FROM / TO:** PrimeFaces 12.0.0 → 13.0.0; enterprise API unchanged.

**API/source transformations:** Exact PF13 changes only: ui:repeat and explicit editor height units; no Java API change required for current upload usage. Preserve table identity/sort/dialog controls and defer runtime behavior checks.

**Build validation:** `./gradlew clean build`.

**Test validation:** `./gradlew test`; upload metadata/content, CSV export, table sort/filter and all-page smoke.

**Completion criteria:** Build/test and targeted feature gates pass.

**Failure handling:** Fix clear compile issues; manual review for upload API/behavior discrepancies.

**Rollback/checkpoint:** Record prior PF12 checkpoint.

## MIG-07 — PrimeFaces 13.0.0 → 14.0.0

**Objective:** Upgrade PF14 with required Java11 and JSF2.3+ gates, not a dependency-only bump.

**Preconditions:** MIG-06 complete and gate passed.

**Mandatory theme/browser gate:** Verify selected concrete theme and resources against PF14, including DOM/CSS, icon/font and default-theme changes. Verify recorded post-IE product decision and modern-browser matrix still apply; do not assume PF13 evidence covers PF14. Report visual validation separately and carry deferred checks.

**Assessment findings addressed:** ATX-FIND-001, ATX-FIND-006 through ATX-FIND-011, ATX-FIND-014 (partial, runtime/target acceptance still required).

**Files/components affected:** Catalog/build, Dockerfile/Compose, directly related documentation. Existing Elements/table/CSS surfaces inspected but unchanged where exact PF14 supports them.

**Required changes:** PF14 version and Java source/target/release11, with same EAP7.3.10 Java11/RHEL8 image alignment. Actual server JSF2.3+ module selection must be confirmed or explicitly deferred for conditional completion; stock EAP7.3 documentation is not actual runtime evidence. Calendar/growl/editor and existing table/dialog controls remain supported; do not replay historical growl removal. Legacy allowTypes/sizeLimit are deprecated but supported; keep until next authorized target review. No custom UploadedFile implementation needs the new getWebkitRelativePath method. All SearchExpressions, client locale/ARIA resources and reduced-motion behavior require runtime checks.

**Dependency changes — FROM / TO:** PrimeFaces 13.0.0 → 14.0.0, default non-Jakarta artifact; Java8 source/target/configured runtime -> Java11; retain Java EE8/EAP7.3.10/descriptors/namespaces.

**API/source transformations:** Only PF14-confirmed tag/API updates. Do not begin Jakarta conversion in this stage.

**Build validation:** `./gradlew clean build`.

**Test validation:** `./gradlew test`; date selection/format/AJAX, messages, tables, all pages, browser console and visual compare.

**Completion criteria:** PF14 Java11 build/static/WAR/theme gates pass; actual JSF2.3+/runtime checks either validated or explicitly recorded DEFERRED under conditional acceptance. No unresolved PF14 static incompatibility; all inherited risks visible. MIG-08 requires separate authorization.

**Failure handling:** Remediate deterministic issues; require manual review for component removal/message behavior.

**Rollback/checkpoint:** Record passing PF13 revision/artifact.

## MIG-08 — Atomic PF14 → PF15 Jakarta / Jakarta EE 10 / Java 21 / EAP 8.1 cutover

**Current user-authorized boundary (supersedes runtime-execution requirements below):** MIG-08A-F is a Jakarta build/static phase with Java21 as approved final build target. User explicitly selected guarded deployment pending a provisioned EAP8.1 image; no image assembly/pull/start and no MIG-09 execution. Build/static completion is conditional, not final runtime acceptance. A uses PF14 Jakarta classifier bridge and exposes source diagnostics; B migrates imports and resolves compilation; C descriptors/Faces namespaces; D PF15Jakarta and required upload attrs; E explicit saga-blue; F static/WAR/residual namespace checks. Build after each, preserve diagnostics/checkpoints; do not claim A mixed-state build passed.

Observed final evidence: provided EE10/Faces4 APIs, sole PF15.0.16Jakarta JAR,12exact imports, web6/CDI4 and Jakarta XHTML namespaces,125PFoccurrences/44tags/293attrs/unsupported0,11major65classes. Current UploadedFile package already correct, calendar/growl retained, validateFile required for removed allowTypes/sizeLimit and dragDropSupport renamed. Explicit saga-blue bundled in core; no themes artifact. Gradle8.4 stays on JDK11 with Java21 compiler toolchain. Context-root vendor schema retained. Bare EAP runtime image has no server: Docker/Compose require approved provisioned EAP_IMAGE and /opt/server guard; do not replace with bare image.

Residuals: app/source/build config0javax; PF vendor JavaSE/build metadata and4serialized-lambda signature strings are classified, not unexplained legacy API dependencies. Strings may affect deserialization; preserve risk and do not patch vendor JAR silently. All runtime/visual/behavior checks remain DEFERRED; exact EAP8.1 deployment and final acceptance require separate authorization/environment.

**Objective:** Move the entire application across the Jakarta platform boundary and deployable runtime as one coordinated assessed stage. This is the dedicated Jakarta boundary; do not interleave it with MIG-01–07.

**Preconditions:** MIG-07 COMPLETED_CONDITIONAL and prior risks retained; exact Jakarta coordinate/local provenance/toolchain confirmed; pre-cutover checkpoint recorded. Current user scope defers EAP image/provisioning/runtime QA rather than requiring it to pass before build/static migration.

**Mandatory theme/browser gate:** Omega must be resolved/replaced, not left UNDECIDED. Verify PF15 concrete theme names, any renamed/moved resources, target theme artifact/classifier and Jakarta Faces resource serving. PrimeOne is the design system, not a dependency/theme name. Explicit configuration must match actual target resource library; no alias/default assumptions. Require full selected-theme/component regression on the approved modern browser matrix; deferred visuals prevent final acceptance.

**Assessment findings addressed:** ATX-FIND-001 through ATX-FIND-007 and ATX-FIND-010 through ATX-FIND-014. Findings ATX-FIND-008/009 should already be resolved or dispositioned in MIG-07 and rechecked against PF15.

**Files/components affected:**

- `build.gradle`, `gradle/libs.versions.toml`, `gradle/wrapper/gradle-wrapper.properties` only as evidence requires;
- all five view beans under `src/main/java/com/example/homeoffice/view/`;
- `src/main/webapp/WEB-INF/web.xml`, `beans.xml`, `jboss-web.xml`;
- `src/main/java/com/example/homeoffice/view/ElementsBean.java`;
- `src/main/webapp/elements.xhtml`, table pages and `resources/css/app.css` only for confirmed PF15 changes;
- `Dockerfile`, `docker-compose.yml`;
- `libs/` only if a verified local Jakarta PF JAR is intentionally retained.

**Required changes and subphase order:**

1. A: JakartaEE10 provided APIs, PF14Jakarta classifier bridge and Java21 toolchain/release; verify classifier resolution and capture namespace compile diagnostics without retaining javax APIs.
2. B: Convert12known CDI/Inject/Faces imports; never blanket-convert Java SE. Compile immediately and resolve A diagnostics.
3. C: web6/CDI4/Faces4 identifiers/namespaces; preserve mapping/welcome/multipart/discovery/root. Retain vendor descriptor where supported; build again.
4. D: PF15.0.16Jakarta classifier; exact taglib/API audit; move used upload regex/size into validateFile and rename dragDrop; remove unread UPLOADER. Preserve already-correct UploadedFile package/calendar/growl and other supported controls; build again.
5. E: Explicit saga-blue/resource gate, guarded external provisioned EAP_IMAGE under /opt/server; no runtime/image assembly. Preserve root WAR/port/platform with unverified image assumptions visible; build again.
6. F: final clean build/test/static/WAR/taglib/residual namespace checks and checkpoints. Tests NO-SOURCE is no behavioral validation; all runtime/image/visual gates deferred.

The subphases form a coordinated atomic migration. Do not represent an intermediate mixed namespace/dependency state as a passed stage or move to MIG-09 until the full gate passes.

**Dependency changes — FROM / TO:**

- `org.primefaces:primefaces:14.0.0` → `org.primefaces:primefaces:15.0.16` with `jakarta` classifier.
- `javax:javaee-api:8.0` (`provided`) → `jakarta.platform:jakarta.jakartaee-api:10.0.0` (`provided`), as stated by the PF15 assessment; confirm approved coordinate/EAP alignment.
- Java source/runtime 11 → 21 (MIG-07 establishes the Java11 minimum).
- EAP 7.3.10 OpenJDK 11 image → approved EAP 8.1 OpenJDK 21 image.
- Gradle wrapper 8.4 → unchanged unless Java 21 build evidence/policy requires a compatible update.

**API/source transformations:** Convert only actual Jakarta EE imports/descriptor identifiers in evidence; PF UploadedFile package already correct, revalidate event/methods; keep PrimeFaces XHTML namespace; no JPA, validation, transaction, servlet filters/listeners or security APIs exist to transform. If new usage is discovered, stop and reassess scope.

**Build validation:** `./gradlew clean build`.

**Test validation:** `./gradlew test` (no automated tests currently); `bash .aws/atx/skills/eap-primefaces-modernization/scripts/validate-modernized.sh`; `docker compose config`; build/start target container only when authorized environment is available. Inspect WAR for duplicate EE APIs and unintended `javax` EE references.

**Completion criteria:** Conditional MIG-08: Java21 build, target classifier/graph, exact source/descriptor/static tag/theme/WAR and residual-classification gates pass, all runtime risks visible. Actual descriptor acceptance/CDI/Faces/UI/upload/visual/container startup remain final acceptance obligations, not claims made from compilation.

**Failure handling:** Fix unambiguous migration-related compile errors and rebuild. Retry dependency resolution only after verifying coordinates/repository. Stop for manual review on ambiguous API/tag mapping, schema support, image filesystem/classloading, or behavior. EAP8.1 runtime validation is DEFERRED per user scope; final deployment acceptance remains BLOCKED — ENVIRONMENT REQUIRED until a provisioned environment exists. Do not claim deployment success.

**Rollback/checkpoint:** This is the highest-risk change. Record the passing PF14/EAP7.3 checkpoint and WAR/container artifact first. If the coordinated cutover fails, restore only changes introduced by this stage using Git-aware non-destructive procedures; preserve unrelated user changes. Do not commit unless requested.

## MIG-09 — Final acceptance

**Objective:** Verify target artifact and evidence after MIG-08.

**Preconditions:** MIG-08 conditional build/static gates passed; separate user authorization and a provisioned EAP8.1 environment required for runtime prerequisites/full acceptance.

**Assessment findings addressed:** Verify ATX-FIND-001 through ATX-FIND-014 are resolved with validation or explicitly dispositioned.

**Files/components affected:** Final WAR/container/configuration and all five pages.

**Required changes:** No new transformation by default. Correct only migration defects under a recorded stage/checkpoint.

**Dependency changes — FROM / TO:** None.

**API/source transformations:** None unless a logged defect fix is approved.

**Build validation:** `./gradlew clean build`; `docker compose config`; target image build/deployment check if environment is available.

**Test validation:** `./gradlew test`; repository validator; manual full regression on all five pages and component checklist.

**Completion criteria:** QA acceptance; reproducible build; successful EAP 8.1 deployment and startup evidence; no unresolved blocking finding; root route `/` and behavior preserved.

Theme/browser acceptance additionally requires actual resource-request and visual evidence, a selected supported concrete theme, resolved Omega disposition and approved browser matrix. All persistent deferred interaction/visual items must pass; a build-only or deferred result cannot close final acceptance.

**Failure handling:** Return to the owning stage for defects; do not declare complete on an unavailable environment.

**Rollback/checkpoint:** Keep the pre-MIG-08 PF14 checkpoint and final candidate artifacts until acceptance is recorded.

## Baseline record format

Before MIG-01, record in `migration-state.json` and `transformation-log.md`:

- current build command/result, JDK and Gradle versions;
- existing errors and warnings verbatim or with a durable log path;
- `./gradlew test` result and explicit absence of functional tests;
- local PrimeFaces JAR presence/source and dependency resolution outcome;
- deployment prerequisites, including Red Hat registry access, target image/tag, architecture and runtime availability;
- manual baseline observations for Home, Dashboard, Employees, Reports and Elements.

Use “not run”, “unknown”, or “blocked” when that is the evidence. Never convert unknown baseline status into success.

## Manual validation checklist

- Home, Dashboard, Employees, Reports and Elements render; shared navigation works.
- CDI-backed content resolves.
- Elements validation/messages, AJAX, date selection/format, autocomplete, data tables, sorting/filtering, CSV export, text editor, file upload, dialog, progress and poll work.
- Upload listener receives metadata/content within descriptor limits.
- No browser-console errors; compare custom styling in `app.css`.
- On target: EAP startup/deployment logs clean, `ROOT.war` accessible at `/`, port 8080 and approved Linux architecture verified.

## Traceability and progress

Log each stage in `docs/modernization/migration/transformation-log.md`, naming all relevant `ATX-FIND-001`…`ATX-FIND-014` IDs. Update `docs/modernization/migration/migration-state.json` from observed evidence after every gate. Finding IDs listed in a stage are not automatically resolved by that stage; use validation results.
