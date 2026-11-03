# Migration Transformation Log

This log records gated migration execution. Historical entries retain the results known at the time; the latest status and migration-state.json describe the current stage.

**Latest status:** MIG-00 through MIG-08 COMPLETED_CONDITIONAL. MIG-09 actual pinned EAP8.1 Update8.0/Java21 fresh startup/deployment and54/54unchanged browser checks PASS. Same-container restart FAILS cloud KUBE_PING reconfiguration; fresh immutable replacement passes. Visual MINOR DIFFERENCES, application-state invalidation mandatory, rollback PARTIAL. Final decision **TECHNICALLY MIGRATED — EAP RUNTIME ACCEPTANCE INCOMPLETE**, production not approved. See latest additive EAP entry; earlier outcomes are historical. No additional modernization.

## Initial state

- **Status:** Execution started at MIG-00; blocked before any application transformation.
- **Assessment source:** `docs/modernization/assessment/manifest.json` and `assessment.json`.
- **Approved sequence:** MIG-00 through MIG-09 in `docs/modernization/migration/migration-runbook.md`.
- **Checkpoint:** `83b075f38cbb6b1d2722a8c96a8241070ada3f4a`; worktree was clean before baseline commands.
- **Baseline build:** `./gradlew clean build` FAILED at `:compileJava`: Gradle could not resolve `org.primefaces:primefaces:6.2.30` from Maven local or Maven Central.
- **Artifact evidence:** `libs/` contains only `README.md`; it documents `libs/primefaces-6.2.30.jar` as the expected private PrimeFaces artifact. That JAR is absent.
- **Tests:** `./gradlew test` FAILED before test execution on the same unresolved compile dependency. The assessment found no automated behavioral suite.
- **Runtime/deployment prerequisites:** Host is Temurin OpenJDK 11.0.30, Gradle 8.4, macOS aarch64. Docker is available and reports linux/aarch64; Dockerfile/Compose force linux/amd64. EAP 8.1 image access and target architecture remain unverified. No baseline WAR or manual page smoke test could be produced.
- **Warnings:** No Gradle deprecation/build warnings were observed before dependency resolution failed.
- **Source changes:** None. No application, build, descriptor, or deployment file was modified.
- **Outcome:** BLOCKED at MIG-00. Do not begin MIG-01 until an approved baseline PrimeFaces 6.2.30 artifact is supplied or made resolvable and the baseline build/test gates can be recorded.

### MIG-00 — Baseline build and readiness

Related findings:
- ATX-FIND-002
- ATX-FIND-006
- ATX-FIND-013
- ATX-FIND-014

Checkpoint:
- `83b075f38cbb6b1d2722a8c96a8241070ada3f4a` (clean before baseline commands; no commit created)

Files changed:
- `docs/modernization/migration/migration-state.json`
- `docs/modernization/migration/transformation-log.md`

Reason:
- Record observed baseline command results and the missing private PrimeFaces 6.2.30 artifact without changing application code.

Validation:
- Build: `./gradlew clean build` — FAILED, `org.primefaces:primefaces:6.2.30` not found in Maven local or Maven Central.
- Tests: `./gradlew test` — FAILED before test execution on the same compileClasspath resolution error; no test results produced.
- Manual/deployment gates: Not run; no WAR was built. Docker daemon is linux/aarch64 while repository deployment config forces linux/amd64. EAP registry access and target image architecture remain unverified.

Outcome:
- BLOCKED
- Findings resolved: None.
- Findings remaining: ATX-FIND-001 through ATX-FIND-014.
- Follow-up/blockers: Obtain the approved PrimeFaces 6.2.30 artifact or configure its authoritative repository, then rerun the baseline gate. No subsequent stage may begin before MIG-00 can be understood and its prerequisites recorded.

### MIG-00 — Approved BASELINE RECONSTRUCTION (2026-10-27)

**Classification:** BASELINE RECONSTRUCTION, not MIGRATION TRANSFORMATION.

**Related findings:** ATX-FIND-002, ATX-FIND-006, ATX-FIND-010, ATX-FIND-013, ATX-FIND-014.

**Authorization:** User approved Recommendation B, CONDITIONAL BASELINE SUBSTITUTE, for MIG-00 only. Do not start MIG-01.

**Checkpoint:** `84b34d4fd1b8fedaab6f2c20289802789bcb9cbd`; worktree clean before reconstruction. No commit created.

**Files changed:**
- `gradle/libs.versions.toml`: only `primefaces = "6.2.30"` to `primefaces = "6.2"`.
- `docs/modernization/migration/migration-state.json`: record authorization, artifact, results and remaining runtime gate.
- `docs/modernization/migration/transformation-log.md`: this entry.

**Baseline identity and reason:**
- Original configured baseline: PrimeFaces 6.2.30 Elite/PRO maintenance release.
- Original artifact status: UNAVAILABLE.
- Reconstructed baseline: Public PrimeFaces 6.2.
- Reconstruction confidence: MEDIUM. Reconstruction risk: MEDIUM.
- Reason: The original private PrimeFaces 6.2.30 artifact could not be recovered. Repository analysis demonstrated source-level compatibility with public PrimeFaces 6.2, with one known XHTML attribute compatibility concern.
- This is a reconstructed public-6.2 baseline, never a verified PrimeFaces 6.2.30 baseline. It does not prove functional equivalence and is approved only for migration baseline work, not production release.

**Artifact resolution:**
- `./gradlew dependencyInsight --dependency org.primefaces:primefaces --configuration runtimeClasspath --console=plain` selected `org.primefaces:primefaces:6.2`.
- A disposable session-local Gradle init task inspected the resolved artifact file: `/Users/amineabri/.m2/repository/org/primefaces/primefaces/6.2/primefaces-6.2.jar`, through configured `mavenLocal()`. Local Maven resolver metadata records original source `central`.
- JAR SHA-256: `007bdea064f20cecad6773442a08062149b197d8a57329d070d945c06274f0cf`.
- No `libs/primefaces-6.2.jar` override exists. No JAR was renamed or installed under false coordinates.

**Build validation:**
- `./gradlew clean build --console=plain`: BUILD SUCCESSFUL.
- Dependency resolution and `compileJava` passed; `war`, `assemble`, `check` and `build` completed successfully.
- `processResources`, `compileTestJava`, `processTestResources` and `test` reported NO-SOURCE. No compilation/build warnings were emitted, and no build failures occurred.
- Generated artifact: `build/libs/primefaces-homeoffice.war`, 4,015,101 bytes.
- WAR SHA-256: `2bbfc9e954759633d8feff6da2c84b1979cb9cee0cfa5bddc3d3f9e59a10cd2b`.
- WAR inspection: 11 application class files; its only dependency JAR is `WEB-INF/lib/primefaces-6.2.jar`, byte-identical to the resolved artifact. Java EE APIs remain provided, not bundled.
- Build host: Temurin JDK11.0.30, Gradle8.4; source/target remain Java8. No Java21 validation was performed.

**Independent test validation:**
- `./gradlew test --console=plain`: BUILD SUCCESSFUL, `test NO-SOURCE`.
- Tests discovered: 0; executed: 0; passed: 0; failed: 0; skipped: 0.
- No test sources or test-result XML files exist. There are no meaningful automated behavioral tests; the empty test task is not functional acceptance.

**Known textEditor limitation:**
- `src/main/webapp/elements.xhtml:189-193`: `p:textEditor secure="false"` is not declared by public PrimeFaces6.2's embedded tag library.
- Java/XHTML were not changed. The original attribute is retained in both source and packaged WAR.
- MANUAL RUNTIME VALIDATION REQUIRED: whether Facelets ignores the attribute, warns, throws, prevents rendering, or changes editor behavior has not been established. A successful WAR build does not process Facelets as a deployed server would.
- Carry this concern into MIG-01/MIG-02 planning; do not remove the attribute merely to obtain a passing gate.

**Runtime/functional validation:**
- Docker is available, but no local baseline EAP image was found.
- `docker manifest inspect registry.redhat.io/jboss-eap-7/eap73-openjdk8-openshift-rhel7:7.3.10-2` failed with `unauthorized`; Red Hat Customer Portal registry authentication is required. No authentication changes, replacement server, image pull, or deployment were attempted.
- Deployment status: BLOCKED — ENVIRONMENT REQUIRED.
- Startup/deployment, Home and Elements rendering, the other application pages, dialogs, AJAX, native upload, text-editor submission, data-table interactions and date selection were not runtime-tested. Each remains MANUAL RUNTIME VALIDATION REQUIRED.
- Existing config requires linux/amd64 on a linux/aarch64 Docker daemon; emulation compatibility remains unverified.

**Outcome:** Build/packaging gate PASS on the reconstructed baseline; manual runtime gate BLOCKED (ATX-BLOCK-006). ATX-BLOCK-005 is mitigated by approved reconstruction, not recovery of PF6.2.30. No findings are marked fully resolved. MIG-00 is not complete and MIG-01 remains pending and unauthorized. Supply access to the configured legacy runtime and complete the manual baseline checks before advancement.

### MIG-00 — User acceptance of reconstructed baseline with runtime deferral

- **Status:** COMPLETED_CONDITIONAL — RECONSTRUCTED BASELINE WITH RUNTIME VALIDATION DEFERRED.
- **Baseline type:** RECONSTRUCTED; public PF6.2, not verified private PF6.2.30.
- **Build validation:** PASS (recorded above).
- **Runtime validation:** DEFERRED; explicitly accepted migration risk.
- **Automated tests:** NONE; `./gradlew test` was NO-SOURCE, not functional validation.
- **Confidence / risk:** MEDIUM / MEDIUM.
- The original private maintenance artifact and required EAP7.3 runtime remain unavailable. This acceptance changes the gate disposition, not the underlying evidence.
- The authorization applies to MIG-01 only; no authorization for MIG-02 or blanket waiver of future gates is inferred.

### MIG-01 — PrimeFaces 6.2 to 7.0

**Status:** COMPLETED_CONDITIONAL. Runtime validation DEFERRED, not passed.

**Findings:** ATX-FIND-006 and ATX-FIND-010; ATX-FIND-014 artifact provenance also checked. None is fully resolved: the umbrella target is PF15 Jakarta and regression/runtime evidence remains outstanding.

**Pre-stage checkpoint:**
- Base Git revision: `84b34d4fd1b8fedaab6f2c20289802789bcb9cbd`.
- The existing MIG-00 catalog/state/log changes were inspected and preserved, not reverted.
- Session directory: `/Users/amineabri/.copilot/session-state/b576bbf4-7254-42d8-992a-9e42c392510e/files/`.
- `pre-mig01.patch`: pre-stage Git binary diff, SHA-256 `afaa4fea1b1dd5dc23b9b8467d89fc241ed70620ab81a6dabe1ad4d2f2785859`.
- `pre-mig01-pf62.war`: preserved passing reconstructed baseline WAR, SHA-256 `2bbfc9e954759633d8feff6da2c84b1979cb9cee0cfa5bddc3d3f9e59a10cd2b`.
- No commit created. To reconstruct the pre-stage state safely, use a separate worktree at the base revision and apply the preserved patch; do not overwrite unrelated working changes.

**Expected changes and evidence:**
- Stage definition requires the PF7 dependency and preserves Java8/EE8/EAP7.3 and `javax`.
- Historical commit `8987f83` changed only catalog, build description and local-library documentation; this was supporting evidence, not a source patch copied blindly.
- Exact PF7 taglib/API inspection, rather than historical generic warnings, determines whether application edits are required. No PF8 upload-package/listener, date-picker, namespace or later-stage change was applied.

**Files changed and reason:**
- `gradle/libs.versions.toml`: PF6.2 reconstructed baseline to public PF7.0.
- `build.gradle`: description updated to PF7.0; compiler, WAR and dependency-resolution logic unchanged.
- `libs/README.md`: actual PF7 fallback name/coordinate, verified-artifact guidance, and explicit reconstruction disclaimer.
- `docs/modernization/migration/migration-state.json`: conditional stage dispositions, persistent deferred checks, artifact and build evidence.
- `docs/modernization/migration/transformation-log.md`: acceptance and this stage entry.
- **Java source changes:** None.
- **XHTML/CSS changes:** None. In particular `secure="false"`, `fileUploadListener`, legacy UploadedFile, `p:calendar`, growl and EL sort/filter expressions are retained.

**Resolution/build/test gate:**
- `./gradlew clean build --console=plain`: BUILD SUCCESSFUL; compileJava and WAR packaging passed. No warnings, unexplained compilation failures or remediation loop were needed.
- `./gradlew test --console=plain`: BUILD SUCCESSFUL, `test NO-SOURCE`. AUTOMATED TEST COVERAGE UNAVAILABLE; discovered/executed/passed/failed/skipped counts all zero.
- `./gradlew dependencyInsight --dependency org.primefaces:primefaces --configuration runtimeClasspath --console=plain`: selects `org.primefaces:primefaces:7.0`.
- No Maven-local PF7.0 or local override existed; the configured remaining repository is Maven Central. Resolved Gradle-cache JAR: `/Users/amineabri/.gradle/caches/modules-2/files-2.1/org.primefaces/primefaces/7.0/918c09395b22502668c4948d103e3a98cd83578d/primefaces-7.0.jar`.
- PF7 JAR SHA-256: `282d1f8ff8eac6492857cb5c50f8f125f88a732fcb956e3031296c240e650623`.
- WAR: `build/libs/primefaces-homeoffice.war`, 4,593,592 bytes, SHA-256 `7e5495fa8c9870f65940cecaade9c181f2a012056f1568ea44956e8dba82febb`.
- WAR contains PF7.0 as its only dependency JAR; no server-provided EE API is bundled.

**Static compatibility: PASS with one known baseline exception (not an unqualified pass).**

| Surface | Inspection and outcome |
|---|---|
| All six XHTML files | Parsed; all 44 distinct PF tags / 125 occurrences exist in embedded PF7 taglib. |
| Attributes | 128 distinct tag/attribute pairs, 291 occurrences checked; 290 occurrences declared, one preserved baseline exception: textEditor.secure. |
| Java imports and calls | Full Gradle compilation succeeds. `FileUploadEvent.getFile()`, legacy `UploadedFile.getFileName()/getSize()` exist in target signatures. |
| Explicit AJAX events | `dateSelect` and `itemSelect` occur in target Calendar/AutoComplete implementations. Four remaining ajax tags use implicit component defaults; no explicit event was added. Actual event dispatch and EL listener behavior remain runtime checks. |
| Widgets | PF7 dialog implementation has show/hide methods used by `PF('elementDialog')`; widgetVar is declared. Browser registration/execution remains deferred. |
| Upload | `fileUploadListener` and used attributes declared; native decoder present; renderer supports configured native mode (JSF2.2+). Multipart limits and config unchanged. |
| Editor | textEditor exists, but secure is absent from both PF7 taglib and component accessors, as in public PF6.2. Retained untouched; Facelets handling and submission behavior remain unverified. |
| Tables/export | All used column/dataTable/exporter attributes declared; CSVExporter class present. EL expressions preserved; no evidence requires PF7 syntax edits. |
| Calendar/autocomplete/messages | Used tags/attributes exist, including calendar, growl, autoUpdate and completeMethod. Deprecation alone does not require replacing supported components in this phase. |
| Poll/progress | Used tag attributes present; actual polling and AJAX updates deferred. |
| CSS | All 26 ui-* classes referenced by local CSS occur in PF7 components.css. This lexical check does not prove equivalent DOM, theme styling or visuals. |
| Converters/validators/renderers/extensions | No custom implementations, registrations or PrimeFaces Extensions were found; standard JSF validation and built-in conversions remain unchanged. |

No newly introduced source/API incompatibility was found. The undeclared editor attribute is explicitly carried as the accepted baseline/runtime-only concern, not treated as verified supported configuration. Runtime-only risks also include AJAX target resolution, file-transfer behavior, editor semantics, theme changes and default component-event dispatch.

**Historical comparison with `8987f83`:**

| Difference | Classification | Reason |
|---|---|---|
| Catalog ends at PF7.0 | EXPECTED | Same phase target. |
| Starts from public PF6.2 rather than private PF6.2.30 | EXPECTED | Explicitly approved reconstructed baseline. |
| Build description and fallback filename updated | EXPECTED | Same metadata/doc surfaces; fallback path itself is already version-derived. |
| Local-library docs explain public version and preserved reconstruction history | IMPROVED CURRENT IMPLEMENTATION | Avoids falsely presenting public PF7 as an Elite-only dependency or concealing the baseline substitute. |
| No Java/XHTML changes | EXPECTED | Historical commit also changed none; exact artifact checks did not establish a new PF7 incompatibility. |
| Literal local-fallback logic rewrite | HISTORICAL CHANGE NOT REQUIRED | Neither implementation needs it: build.gradle derives the filename from the catalog. |
| Missing phase-required change | CURRENT CHANGE MISSING: none identified | One inherited editor configuration uncertainty is documented, not silently deleted or claimed supported. |

**Persistent deferred runtime validation — all remain DEFERRED:**
- application deployment/startup
- home page rendering
- elements.xhtml rendering
- p:textEditor secure="false"
- dialogs
- AJAX behaviour
- file upload
- data tables
- date selection
- autocomplete
- CSV export
- messages/growl
- polling/progress behaviour

Also validate other pages/navigation, CSS/theme visuals and browser console. These items remain visible in state and must be executed once a compatible runtime is available. The previously observed EAP registry authorization failure remains the environmental limitation; no deployment or runtime success is claimed.

**Remaining risk:** MEDIUM. Conditional completion relies on explicit user acceptance of absent runtime evidence and the reconstructed-baseline limitation; it is not acceptance for production release.

**Stop:** MIG-01 only is complete conditionally. MIG-02 has NOT started; wait for explicit approval.

### MIG-02 — PrimeFaces 7.0 to 8.0

**Status:** COMPLETED_CONDITIONAL — build and static gates passed; runtime validation remains DEFERRED, not passed.

**Authorization:** User approved the next phase after the conditional MIG-01 report. This authorizes MIG-02 only within the phased conditional workflow, not MIG-03 or a blanket waiver of future validation.

**Assessment traceability:** ATX-FIND-006, ATX-FIND-007, ATX-FIND-008 and ATX-FIND-010; artifact provenance checked under ATX-FIND-014. No assessment finding is fully closed: end-to-end upload/UI and final PF15/Jakarta validation remain outstanding. The UploadedFile import portion of ATX-FIND-007 is remediated now because PF8 actually requires it, not postponed merely because the finding names PF15.

**Checkpoint/rollback:**
- Base Git revision: `84b34d4fd1b8fedaab6f2c20289802789bcb9cbd`.
- Pre-existing catalog, build description, library docs, migration state and log changes were inspected and preserved.
- Session directory: `/Users/amineabri/.copilot/session-state/b576bbf4-7254-42d8-992a-9e42c392510e/files/`.
- `pre-mig02.patch`: pre-stage Git binary diff, SHA-256 `e5c4c33eee3fd4a985ece4184745c219e3f2e0e37d84ef6939be32e9fab2493e`.
- `pre-mig02-pf70.war`: prior passing PF7 WAR, SHA-256 `7e5495fa8c9870f65940cecaade9c181f2a012056f1568ea44956e8dba82febb`.
- No commit created. Recover the prior source in a separate worktree at the base revision using the preserved patch; never discard unrelated working changes.

**Application/dependency changes:**

| File | Change | Evidence/reason |
|---|---|---|
| `gradle/libs.versions.toml` | PF7.0 to PF8.0 | Authorized stage target; non-Jakarta artifact. |
| `src/main/java/com/example/homeoffice/view/ElementsBean.java:5` | `org.primefaces.model.UploadedFile` to `org.primefaces.model.file.UploadedFile` | Old class absent from PF8; `FileUploadEvent.getFile()` returns relocated type. `getFileName()` and `getSize()` remain available. No method/body behavior changes. |
| `src/main/webapp/elements.xhtml:215` | `fileUploadListener` to `listener` | Old attribute absent from PF8 taglib; `FileUpload.broadcast()` invokes getListener with the event. Same `#{elementsBean.handleUpload}` binding retained. |
| `build.gradle:8` | Description updated to PF8.0 | Metadata only; Java8, provided EE8, WAR and local override logic unchanged. |
| `libs/README.md` | PF8 coordinate/fallback filename | Build derives fallback path from catalog; preserve reconstruction disclaimer. |
| Migration state/log | Record checkpoint, actual validation and conditional outcome | Resumable traceability; persistent deferred runtime checks. |

No Jakarta, Java, EAP, descriptor, CSS, table-expression, date-control or other unrelated transformation was performed.

**Build/resolution/test gate:**
- `./gradlew clean build --console=plain`: BUILD SUCCESSFUL, compileJava and WAR packaging passed; no warnings or build failures.
- `./gradlew test --console=plain`: BUILD SUCCESSFUL, `test NO-SOURCE`. AUTOMATED TEST COVERAGE UNAVAILABLE. Discovered/executed/passed/failed/skipped counts all zero; no result XML. This is not a functional pass.
- `./gradlew dependencyInsight --dependency org.primefaces:primefaces --configuration runtimeClasspath --console=plain`: selected `org.primefaces:primefaces:8.0`.
- Disposable session-local Gradle init task inspected the resolved artifact: `/Users/amineabri/.m2/repository/org/primefaces/primefaces/8.0/primefaces-8.0.jar`, from configured Maven local. Maven resolver metadata records original origin Central. No local `libs/` override used, no renamed/relabelled JAR.
- PF8 JAR SHA-256: `5e1960a064a4dfb0e8420dff06231c152f20c8dc3446e74e39fa08d1be614c73`.
- WAR: `build/libs/primefaces-homeoffice.war`, 4,878,669 bytes; SHA-256 `db052e7c23cdea2b3445d1fcad135a382b70f91d07dc3643b7d898e19a6d7b8b`.
- WAR inspection: 11 application class files; its only dependency JAR is PF8.0, byte-identical to the resolved Maven-local JAR. Java EE APIs remain provided, not bundled.

**Static validation: PASS**

| Surface | Evidence and result |
|---|---|
| All six XHTML files | Parsed; all 44 distinct PF tags / 125 occurrences exist in PF8 embedded taglib. |
| Every PF attribute | 128 distinct tag/attribute pairs and 291 attribute occurrences checked; zero undeclared tags/attributes after listener rename. |
| Java upload API | Full compilation passes; exact FileUploadEvent and UploadedFile signatures checked. No application calls use removed getContents/getInputstream names. |
| AJAX/listener | Explicit Calendar dateSelect and AutoComplete itemSelect recognized in target implementation. FileUpload.broadcast invokes renamed listener with event. Implicit events/EL dispatch and update targets still require runtime validation. |
| Dialog/widgets | Target dialog JavaScript implements show/hide used by the application; existing widgetVar retained. Browser execution deferred. |
| Calendar/date | Existing p:calendar, pattern, showOn and dateSelect are supported in PF8. Deprecation does not prove a required replacement; preserve java.util.Date binding and behavior. |
| Tables | Existing sortBy/filterBy EL attributes declared; target sort/filter implementation accesses ValueExpressions. Retain expressions; do not copy historical conversion to literal strings. Actual sorting/filtering deferred. |
| CSV export | PF8 internally relocates implementation to DataTableCSVExporter; DataTableExporterFactory instantiates it. Existing p:dataExporter type=csv attributes remain supported; no custom exporter exists to update. Download contents deferred. |
| Native upload | NativeFileUploadDecoder and native-mode renderer branch present; JSF2.2+ required. Existing EE8/EAP7.3 target, multipart settings, upload limits and primefaces.UPLOADER=native retained. Upload transfer behavior deferred. |
| Editor | PF8 taglib and TextEditorBase now declare secure; renderer checkSecurity honors false. Preserve secure=false. Runtime rendering, HTML submission and sanitization behavior remain deferred. |
| CSS/other components | All 26 locally referenced ui-* CSS classes occur in target components.css. Growl/messages, repeat, polling/progress and other used attributes exist. Lexical checks are not visual/behavior validation. |
| Custom integrations | No custom renderer/converter/validator or PrimeFaces Extensions remediation identified. |

**Important editor finding:** Unlike public PF6.2/PF7, PF8 supports `secure`. Its default is true. Renderer bytecode throws a FacesException if secure=true and the HTML sanitizer is unavailable. The WAR contains no added sanitizer library; preserving the explicit existing false value avoids introducing that default precondition. This does not constitute a security approval or claim sanitized input. Removing the attribute as the historical migration did would be an unsupported behavior change and could cause rendering failure.

**Historical comparison with `e80a2ca`:**

| Historical change vs current | Classification | Decision |
|---|---|---|
| PF8 catalog, build description and fallback docs | EXPECTED | Same target; current docs preserve public/private reconstruction context. |
| UploadedFile package and fileUpload listener rename | EXPECTED | Required by exact PF8 classes/taglib and applied. |
| Calendar to datePicker | HISTORICAL CHANGE NOT REQUIRED | Calendar and used attributes still supported; avoid unnecessary widget/behavior change. |
| Table EL to literal field-name strings | HISTORICAL CHANGE NOT REQUIRED | Existing EL syntax supported; target features consume ValueExpressions. Keep both Elements and Employees expressions intact. |
| Remove secure=false | IMPROVED CURRENT IMPLEMENTATION | Retain now-supported configuration; omission would enable default secure=true and could require an absent sanitizer dependency. |
| Additional phase-required change missing | CURRENT CHANGE MISSING: none identified | Runtime-only concerns explicitly deferred, not represented as a proven functional pass. |

**Persistent runtime validation:** All 13 items remain DEFERRED: deployment/startup; Home; Elements; textEditor secure=false; dialogs; AJAX; upload; tables; date selection; autocomplete; CSV export; messages/growl; polling/progress. Also validate other pages/navigation, visuals and browser console. PF8 resolves the editor attribute's static declaration concern only; do not remove its runtime check from the list.

**Runtime environment/risk:** Previously observed EAP7.3 registry authorization failure remains the limitation; no new runtime was substituted and no deployment success is claimed. Risk MEDIUM: no behavioral suite, runtime gates deferred, private PF6.2.30 equivalence never established. All deferred checks must be completed when a compatible runtime becomes available.

**Stop:** MIG-02 COMPLETE — CONDITIONAL. Next phase MIG-03, PF8 to PF10. MIG-03 has NOT started; wait for approval.

### MIG-03 — PrimeFaces 8.0 to 10.0.0

**Status:** COMPLETED_CONDITIONAL. Runtime validation DEFERRED, never inferred from compilation.

**Authorization/scope:** User explicitly authorized MIG-03 only, with conditional completion permitted when build/static/package gates pass and runtime risks remain documented. No PF11+, Java, EAP, Jakarta, descriptor migration or unrelated refactoring.

**Findings:** ATX-FIND-006, ATX-FIND-007, ATX-FIND-010 and ATX-FIND-014 partially addressed/revalidated; ATX-FIND-008 reviewed and calendar replacement deferred. No assessment finding fully closed without its required target/runtime evidence.

**Pre-stage baseline and checkpoint:**
- Current phase starts from the actual conditional PF8 application, not historical PF8 source or a claimed verified PF6.2.30 application.
- Git base revision: `84b34d4fd1b8fedaab6f2c20289802789bcb9cbd`.
- All existing MIG-00 through MIG-02 changes inspected and preserved. No unrelated edits detected.
- Session directory: `/Users/amineabri/.copilot/session-state/b576bbf4-7254-42d8-992a-9e42c392510e/files/`.
- `pre-mig03.patch`, SHA-256 `a7d952bd3017d69a17866f661592425fc4197063a16e4f933029ba02ca63f1d2`, records the pre-stage binary Git diff.
- `pre-mig03-pf80.war`, SHA-256 `db052e7c23cdea2b3445d1fcad135a382b70f91d07dc3643b7d898e19a6d7b8b`, preserves the passing PF8 artifact.
- Restore in a separate worktree at the base revision by applying that patch; do not overwrite/discard existing working changes. No commit was created.

**Exact MIG-03 changes:**

| File | Change | Reason |
|---|---|---|
| `gradle/libs.versions.toml:3` | PF8.0 to PF10.0.0 | Authorized non-Jakarta phase target. |
| `build.gradle:8` | PF10 description | Metadata only; Java8 source/target, EE8 provided dependency and WAR logic unchanged. |
| `libs/README.md` | PF10 coordinate/fallback filename | Keep directly related local-artifact instructions accurate; preserve baseline reconstruction disclaimer. |
| `src/main/webapp/elements.xhtml` | Add `sortMode="single"` to recordsTable | PF8 defaults to single, PF10 defaults to multiple. Preserve prior configuration/UX rather than silently change to multi-sort. |
| `src/main/webapp/employees.xhtml` | Add `sortMode="single"` to employee table | Same behavior-preserving PF10 compatibility change. |
| `docs/modernization/migration/migration-state.json` | Results, conditional state, persistent/new risks, checkpoint | Resume without chat history. |
| `docs/modernization/migration/transformation-log.md` | This entry | Stage/finding traceability and historical comparison. |

**Java source changes in MIG-03:** None. The existing relocated UploadedFile import is a prior MIG-02 change, not new work in this phase.

**XHTML changes in MIG-03:** Only two sortMode attributes. No change to sortBy/filterBy EL, calendar, editor secure=false, repeat, upload listener, process/update targets, CSV command or widgets. The remaining three nonsortable tables need no behavior pin.

**Evidence hierarchy and sources:**
- Actual resolved PF10 binary: taglib, Java bytecode/signatures, JavaScript/CSS resources.
- Matching public source artifact: `https://repo.maven.apache.org/maven2/org/primefaces/primefaces/10.0.0/primefaces-10.0.0-sources.jar`.
- Official release-tag migration guide: `https://github.com/primefaces/primefaces/blob/10.0.0/docs/migrationguide/10_0_0.md`.
- Official release-tag calendar documentation: `https://github.com/primefaces/primefaces/blob/10.0.0/docs/10_0_0/components/calendar.md`.
- Historical `a6bb2fd` is supporting evidence, not authority. Prior reports' claims that native is the only mode and repeat is removed are not supported by this exact artifact; do not propagate them as facts.

**Build/test/resolution:**
- Initial `./gradlew clean build --console=plain` after version change: PASS. No compilation or packaging failures; static inspection then identified sorting default behavior to preserve.
- Final `./gradlew clean build --console=plain` after both XHTML additions: BUILD SUCCESSFUL, compileJava and WAR completed, no warnings or unexplained failures.
- Independent `./gradlew test --console=plain`: BUILD SUCCESSFUL, `test NO-SOURCE`.
- AUTOMATED BEHAVIORAL TEST COVERAGE UNAVAILABLE: discovered 0, executed 0, passed 0, failed 0, skipped 0; no test-result XML. This is not passing behavioral validation.
- `./gradlew dependencyInsight --dependency org.primefaces:primefaces --configuration runtimeClasspath --console=plain`: PF10.0.0 selected.
- Disposable Gradle init task inspected exact resolution: `/Users/amineabri/.gradle/caches/modules-2/files-2.1/org.primefaces/primefaces/10.0.0/e32fd22721d5cd0f89fb0cb025b073248196d721/primefaces-10.0.0.jar`.
- No Maven-local PF10 or local `libs/` override existed; resolution used configured Maven Central/Gradle cache. No renamed or falsely installed artifact.
- PF10 JAR SHA-256: `efdf40f0ee7f336f7fc795e1ebe3e00374221fc455cd47ec4c16d612a2549e17`.

**WAR gate: PASS**
- `build/libs/primefaces-homeoffice.war`: 4,936,410 bytes; SHA-256 `771211e4204bace19274b9bb2739c22100a27b767c3bb9433b0081fdcd32189b`.
- All 11 expected application classes present, matched to source paths. Class-file major version52 confirms Java8 bytecode.
- Exactly one dependency JAR, `WEB-INF/lib/primefaces-10.0.0.jar`, byte-identical to resolved artifact.
- No PF8 JAR, duplicate PF version, or bundled provided Java EE API.
- All three deployment descriptors are byte-identical to source and valid XML; mappings, root context and multipart limits unchanged.
- Expected Facelets structure, editor false setting, calendar and repeat retained.

**Static usage inventory:**

| Metric | PF8 phase baseline | Final PF10 |
|---|---:|---:|
| XHTML files | 6 | 6 |
| p:* tag occurrences | 125 | 125 |
| Distinct tags | 44 | 44 |
| Attribute occurrences | 291 | 293 |
| Distinct tag/attribute pairs | 128 | 129 |
| Unsupported tags | 0 | 0 |
| Unsupported attributes | 0 | 0 |

All six files parsed and every PF tag/attribute checked against embedded PF10 taglib. Two added sortMode occurrences account for count changes; no stale namespace or speculative future-stage tags introduced.

**Component/API review:**

| Surface | PF10 evidence / decision |
|---|---|
| Java upload APIs | FileUploadEvent.getFile returns model.file.UploadedFile; getFileName/getSize still exist. Compilation passes without Java changes. No removed legacy getContents/getInputstream calls in application. |
| Upload listener | Existing listener binding maps to FileUpload.getListener; target broadcast invokes it with FileUploadEvent. handleUpload signature unchanged. |
| Native uploader / web.xml | PrimeConfiguration still reads primefaces.UPLOADER. PrimeApplicationContext.resolveFileUploadDecoder uses configured native value to select a service-loaded NativeFileUploadDecoder; native and commons services are present. Preserve explicit native mode and original multipart configuration. No descriptor migration. |
| Calendar/date | One p:calendar in Elements, binding reviewDate (java.util.Date), pattern dd/MM/yyyy, showOn button, dateSelect updating selectionSummary. All supported. No custom date converter or date widget API. Reports dueDate is only a display String. Preserve component/type/pattern/event; round-trip/time-zone behavior still needs runtime validation. |
| Calendar deprecation | Official PF10 migration guide: Calendar is deprecated but retained; DatePicker recommended. Calendar docs also mark java.util.Date a legacy deprecated value type. SUPPORTED BUT DEPRECATED; no forced replacement this phase. Binary lacking a Deprecated annotation is not used to override official documentation. |
| Grid layout | Three panelGrid layout=grid usages in Home, Elements and Reports rely on legacy Grid CSS. Official guide deprecates Grid CSS; target PanelGridRenderer still supports grid. SUPPORTED BUT DEPRECATED; no new PrimeFlex dependency/refactor. |
| Tables/sorting/filtering | Target SortMeta.of and FilterMeta.of read column ValueExpressions, so existing EL syntax remains supported. Application does not bind table-level sort/filter meta maps or use LazyDataModel/custom SortEvent/FilterEvent listeners. New default multiple sorting corrected via explicit single on two tables. |
| Pagination/row expansion/selection | Used tag attributes present; existing paginator/rows/rowToggler/rowExpansion and selection controls preserved. Runtime interactions deferred. |
| Autocomplete | completeMethod remains compatible with bean's String query/List<String> result. itemSelect recognized. Changed moreText event is unused. Suggestion/default/item conversion remains runtime-sensitive. |
| AJAX/process/update | Six ajax tags, explicit dateSelect/itemSelect and current attributes supported. No migration-required event rename found. Implicit defaults and actual target resolution/dispatch deferred; no speculative expression edits. |
| Dialog/menu/widgets | Target dialog implements show/hide used by PF('elementDialog'); widgetVar, menus and confirmation attributes present. No resolveWidgetVar function/custom widget requiring migration found. Browser execution deferred. |
| TextEditor | SUPPORTED; secure=false declared and honored, not identified deprecated or removed. Renderer checkSecurity only requires sanitizer when secure=true. Preserve false; runtime rendering/value submission still required. |
| Editor behavior change | BEHAVIOR CHANGED at library level: PF10 decoder sanitizes only if secure is true and sanitizer available; PF8 decoder gated only on sanitizer availability. WAR has no sanitizer. If one becomes visible through the container, false now bypasses that processing. RUNTIME VALIDATION REQUIRED; no security/sanitization claim. |
| CSV export | DataTableExporterFactory instantiates DataTableCSVExporter for CSV. Only declarative CSV is used, no custom exporter interface to update and no PDF/Excel integration to migrate. Keep ajax=false download behavior even though PF10 also supports AJAX export. |
| Messages/growl, poll/progress, reset/auto-update | Used tags/attributes and handlers present; no required replacements. Actual feedback, timed updates and reset validation remain runtime checks. |
| CSS | All 26 locally referenced ui-* classes occur in target components.css. This lexical result does not prove DOM/visual equivalence. Official guide removes Aristo/Omega and changes default theme to Saga; no explicit theme configured here. Visual/icon regression risk recorded rather than hidden by speculative CSS/theme edits. |
| Custom integrations | No custom renderer, converter, validator, PrimeFaces Extension or custom widget implementation found to transform. Standard JSF required/conversion validation retained. |

**Issue classification:**

| Classification | Issue / disposition |
|---|---|
| INHERITED ISSUE | Original PF6.2.30 unavailable and public6.2 reconstruction not equivalent; no automated behavioral suite; runtime unavailable; all 13 deferred checks persist. |
| NEW MIG-03 ISSUE | Default sortMode changes single to multiple on the two sortable tables. |
| RESOLVED IN MIG-03 | Pin single on those tables, preserving prior configuration. No unresolved static incompatibility remains. |
| DEPRECATED BUT SUPPORTED | Calendar, its java.util.Date value, and three grid-layout panelGrids remain deliberately unchanged. |
| RUNTIME-ONLY RISK | Default theme/DOM/icons, PF10 table metadata interactions, date conversion, editor sanitizer guard, native decoder service loading, CSV and autocomplete behavior. |

**Historical comparison (`a6bb2fd`) — all relevant changes accounted for:**

| Historical/current change | Classification | Evidence/disposition |
|---|---|---|
| PF8 to PF10 catalog and library doc coordinate | REQUIRED NOW | Applied to current PF8 baseline. |
| Remove primefaces.UPLOADER=native | NO LONGER REQUIRED | Not reproduced: actual PF10 reads parameter and selects native decoder; removal would unnecessarily rely on auto selection. Historical edit is not evidence that the option is unsupported. |
| Replace p:repeat with ui:repeat | NO LONGER REQUIRED | Not reproduced: PF10 taglib and UIRepeat class support current repeat; avoids unneeded component/state behavior change. |
| Prior PF8 UploadedFile relocation/listener rename | ALREADY PRESENT | Revalidated; no Java source changes required in MIG-03. |
| Prior historical calendar/table/editor alterations | HISTORICAL ONLY | Not part of historical PF10 diff and not replayed; actual target supports current retained usage. |
| Explicit legacy single sorting absent from historical PF10 patch | CURRENT MIGRATION MISSING CHANGE (detected, now resolved) | Current implementation adds both single pins; no remaining missing phase change identified. |

**Runtime status and persistent risks:**
- Runtime validation: DEFERRED — ENVIRONMENT REQUIRED. Prior EAP7.3 image manifest request was unauthorized; no new compatible runtime was supplied and no deployment success is claimed.
- All 13 inherited checks remain DEFERRED: deployment/startup; Home; Elements; p:textEditor secure=false; dialogs; AJAX; upload; tables; date selection; autocomplete; CSV export; messages/growl; polling/progress.
- Also retain other page rendering/navigation, custom CSS/theme visuals and browser console checks.
- New explicit checks in state cover Saga/default-theme and menu icons; single-sort behavior/filtering/pagination/expansion; deprecated date/grid behavior; secure=false sanitizer guard; service-loaded native upload; CSV/autocomplete interaction.
- Confidence in compilation/static/package evidence: HIGH. Overall remaining migration risk: MEDIUM because runtime and behavioral regression evidence is absent.
- Deferred checks must be validated once a compatible runtime becomes available; conditional completion is not approval for production release.

**Completion checkpoint:** Preserve `mig03-conditional.patch` and `mig03-pf1000.war` in the session directory, using the same base revision above; no commit. The WAR checksum above identifies the completed artifact.

**Stop:** MIG-03 COMPLETE — CONDITIONAL. Next phase MIG-04, PF10 to PF11. MIG-04 has NOT started; wait for explicit approval.

### Planning amendment — mandatory theme and browser gates

**Authorization/scope:** User requested planning, instructions and state updates only, before MIG-04. No dependency upgrade, application/descriptor edit, Omega resource change or IE code removal. MIG-04 NOT started.

**Theme finding:** Current user-declared theme is **Omega**, not Saga. Historical PF6.2/PF8 artifacts bundle Omega CSS/fonts/images; PF10 removes it (upstream migration guide and local artifact agree). Current tracked application has no explicit `primefaces.THEME`, separate theme dependency, copied Omega resources or Omega template. Actual deployed selection remains UNKNOWN, requiring configuration/resource URLs/screenshots. Do not equate PF10's `saga` framework default with the application's declared visual baseline.

**Corrective gate:** Bundled Omega required replacement at **MIG-03**, already crossed. Historical build/API/WAR evidence stays valid but never established theme/visual acceptance. The missed theme gate is reopened and blocks PF11 edits before MIG-04. Concrete theme remains **UNDECIDED**; target design system is PrimeOne-based modern theming, not a literal theme name. Replacement implementation needs separate authorization. Any implicit/default fallback is **UNCONTROLLED VISUAL CHANGE**.

**Version evidence:** PF11-14 framework default `saga`; PF15 `saga-blue`. PF15 renames `saga`/`arya`/`vela` to `-blue` names, retaining aliases temporarily; only `saga-blue` remains bundled, with other listed themes in `org.primefaces:primefaces-themes`. Verify exact 15.0.16 Jakarta artifact/resources at execution. See release-tag citations and all five phase matrices in `theme-browser-gates.md`.

**CSS/browser inventory:** Rule-group register covers the full custom stylesheet, including legacy ui-* menus, icons, panels, inputs, tables, dialogs, messages and responsive dependencies. No proven Omega-specific local class or application IE-only code/polyfill/workaround found. Modern Grid/flex/gap rules are not IE-only code to delete. Business IE requirement is UNKNOWN; no user-impact conclusion can be inferred from code absence.

**IE decision gate:** Upstream PF13 migration guide explicitly removes IE support, so **MIG-06/PF12 -> PF13** requires a recorded product decision. PF12 is the last major line before that complete removal, not proof this application supports IE. If IE is still required or requirement remains unknown, stop for MANUAL PRODUCT DECISION REQUIRED. No speculative cleanup or unsupported polyfill strategy.

**Records updated:** Dedicated agent, scoped instructions, invocation prompt, migration runbook, assessment transformation-plan addendum, state model v1.1 and this log; new `theme-browser-gates.md` contains inventory, CSS classifications, per-version theme/default/browser matrices, visual checklist, source confidence and mandatory reporting. State records theme/browser decisions separately and all MIG-04 through MIG-08 gates as unevaluated, not started and not eligible for completion.

**Validation boundaries:** STATIC THEME COMPATIBILITY is currently REPLACEMENT REQUIRED; RUNTIME VISUAL VALIDATION DEFERRED. All 13 inherited deferred runtime checks remain visible, plus prior phase risks. No new build/test/runtime result claimed for this documentation-only amendment; automated behavioral coverage remains unavailable. High-confidence release boundaries do not resolve low-confidence deployed provenance/business impact.

**Stop:** THEME AND BROWSER MIGRATION GATES ADDED. Next version phase MIG-04, PF10 -> PF11, remains subject to theme prerequisite and approval. MIG-04 has NOT started.

### MIG-04 — PrimeFaces 10.0.0 to 11.0.0

**Status:** COMPLETED_CONDITIONAL. Runtime and visual validation DEFERRED, not passed.

**Scope/authorization:** User authorized MIG-04 only. Initial preflight confirmed MIG-03 COMPLETED_CONDITIONAL and the open Omega prerequisite. Asked for the concrete theme decision before changing the version; user chose **"Approve explicit Saga replacement with existing custom CSS, then run MIG-04 only"**, after being informed that visuals would remain DEFERRED. This authorizes explicit replacement, not implicit fallback. No PF12+, Java/EAP/EE version, Jakarta namespace, descriptor schema or unrelated refactor.

**Preflight evidence:** Read migration state/log/runbook, assessment matrix/findings, PF11 stage definition/report and historical commit `08cdc381c2d46d11a29ae363181ee8f1f179e6ee`. Current conditional PF10 source/artifact is the baseline. Old report's blanket "no breaking changes affecting current usage" is contradicted by actual PF11 row-expansion requirements; generic DatePicker/client-validation advice is inapplicable to current usage.

**Checkpoint/rollback:** Base revision `84b34d4fd1b8fedaab6f2c20289802789bcb9cbd`; prior uncommitted migrations and gate planning preserved. Session directory `/Users/amineabri/.copilot/session-state/b576bbf4-7254-42d8-992a-9e42c392510e/files/`:

| Artifact | SHA-256 |
|---|---|
| `pre-mig04.patch` (tracked pre-stage binary diff) | `f8a594f9fd0eb041d3ac2a273f79d5faf7c0404cbfff734ecb517c6c4651f151` |
| `pre-mig04-theme-browser-gates.md` (then-untracked gate document) | `0a44cbed222b72190077f8201665783f6961f777053f3f2bae9b3fe10c37caaa` |
| `pre-mig04-pf1000.war` | `771211e4204bace19274b9bb2739c22100a27b767c3bb9433b0081fdcd32189b` |

Restore only in a separate worktree at the base revision, applying the checkpoint patch plus the separately preserved document; keep the prior WAR. No commit created and no pre-existing work discarded.

**Required application changes:**

| File | Change and evidence |
|---|---|
| `gradle/libs.versions.toml` | PF10.0.0 -> 11.0.0, default non-Jakarta artifact. |
| `build.gradle`, `libs/README.md` | Matching description/coordinate/fallback filename only; Java8, provided EE8 and WAR/local override logic retained. |
| `src/main/webapp/elements.xhtml` | Add `rowKey="#{record.reference}"` to recordsTable: target renderer calls getRowKey for rowExpansion; List-backed model throws without key. References EL-001..EL-004 are non-null, immutable and unique. Other four tables use neither row expansion nor row selection and need no key. |
| `src/main/webapp/elements.xhtml` | Add dialog `responsive="false"`: PF10 bytecode default false, PF11 source default true. Preserve prior fixed-dialog behavior; runtime sizing remains deferred. |
| `src/main/webapp/WEB-INF/web.xml` | Add explicit `primefaces.THEME=saga` under separate user approval; no descriptor migration. Native upload, Faces class/mapping and multipart limits unchanged. |
| `src/main/webapp/WEB-INF/templates/main.xhtml`, `elements.xhtml` | Approved Saga resource remediation: four legacy names absent from both PF10/PF11 CSS mapped to bundled PrimeIcons at five usages: signal-diag -> pi-chart-line, person -> pi-user (two), document -> pi-file, refresh -> pi-refresh. All final icon classes have target CSS definitions. Other supported icon names retained. |

**Java changes:** None. No CSS, font, image or IE workaround rewritten/removed. Template changes are limited to the three evidenced icon attributes above; both MIG-03 `sortMode="single"` settings retained.

**Build/test/dependency gates:**
- Initial and final `./gradlew clean build --console=plain`: BUILD SUCCESSFUL, compileJava/WAR passed; no warnings or unexplained failures. Final build follows targeted icon remediation.
- Independent `./gradlew test --console=plain`: command SUCCESS, `test NO-SOURCE`. **AUTOMATED BEHAVIORAL TEST COVERAGE UNAVAILABLE**. Discovered/executed/passed/failed/skipped all zero; not passing behavioral validation.
- `./gradlew dependencyInsight --dependency org.primefaces:primefaces --configuration runtimeClasspath --console=plain`: 11.0.0 selected.
- Resolved cache artifact: `/Users/amineabri/.gradle/caches/modules-2/files-2.1/org.primefaces/primefaces/11.0.0/2045a16b2897ec7163be9d36c922c444ac221635/primefaces-11.0.0.jar`, byte-identical to public Maven Central binary and packaged WAR dependency; no local override.
- PF11 SHA-256: `644f9d0432a7292b9c7cbc4e27692194631dd5b1f77f029a01a4d057d305828d`.

**WAR validation: PASS.** `build/libs/primefaces-homeoffice.war`, 4,442,033 bytes; SHA-256 `259ce9a63cc6c043a44a372a526e6858b06c67e01127570210504aa87864cd91`. All 11 expected application classes, major52/Java8. Sole JAR `WEB-INF/lib/primefaces-11.0.0.jar`; no PF10/duplicate PF/provided EE APIs. Three descriptors parse and match source; only web.xml's theme parameter changed. Facelets, Saga CSS and bundled PrimeIcons resources present.

**Static compatibility: PASS (not functional/visual validation).**

| Metric | Baseline PF10 | Final PF11 |
|---|---:|---:|
| XHTML files | 6 | 6 |
| p:* tag occurrences | 125 | 125 |
| Distinct tags | 44 | 44 |
| Attribute occurrences | 293 | 295 |
| Distinct tag/attribute pairs | 129 | 131 |
| Unsupported tags | 0 | 0 |
| Unsupported attributes | 0 | 0 |

All six XML files parsed and every PF tag/attribute compared with the embedded PF11 taglib. Presence checks alone do not validate EL evaluation, markup, state or browser execution.

| Surface | Exact target evidence and decision |
|---|---|
| Java/upload | FileUploadEvent.getFile returns model.file.UploadedFile; getFileName/getSize exist and compile. FileUpload.broadcast invokes getListener with the event. PrimeConfiguration reads UPLOADER; service selection supports native. Keep listener, method signature, native mode and original multipart limits. |
| Calendar/date | One p:calendar binding java.util.Date with dd/MM/yyyy/showOn=button/dateSelect; all declared and event implemented. DEPRECATED BUT SUPPORTED (calendar inherited PF10 deprecation; PF11 docs explicitly deprecate java.util.Date value). No custom converter/date-widget call. Keep unchanged; conversion/time-zone/round trip RUNTIME VALIDATION REQUIRED. |
| TextEditor | SUPPORTED, secure=false declared/honored; no identified deprecation/removal. checkSecurity requires sanitizer only when true; sanitizeHtml bypasses when false, as in PF10. No new required PF11 behavior edit; preserve false. Rendering/value round trip RUNTIME VALIDATION REQUIRED; no sanitization/security claim. |
| Tables | Both single-sort settings valid/necessary because default remains multiple. Current column sortBy/filterBy ValueExpressions supported. No LazyDataModel/count override or custom sort/filter event API. Stable key resolves actual row-expansion requirement. Pagination/filter/expansion postback still unvalidated. |
| AJAX/selection | Six ajax tags; explicit dateSelect/itemSelect remain implemented. Existing default events, completeMethod, process/update and selection controls retained. No used event rename; naming-container target resolution and listener dispatch require runtime. |
| Dialog/widgets/menus | Actual target dialog JS defines show/hide used by PF('elementDialog'); no widget API rewrite. Responsive default pinned. Declarative menu actions/confirmation retained; no DefaultMenuItem Java builder. |
| CSV/messages/progress | CSV exporter factory still selects DataTableCSVExporter; no custom exporter implementation. Growl/messages, poll/progress, reset/autoUpdate and p:repeat remain supported. Download content, feedback/timing and reset behavior deferred. |
| CSS/layout/icons | All 26 locally referenced ui-* classes occur in target components CSS; no custom use of renamed autocomplete-empty-message selector. Three legacy grid-layout panelGrids remain supported/deprecated. Menu/icon/font/cascade equivalence NOT proven. |
| Unused changes | Removed collector/ribbon/themeSwitcher/FontAwesome, barcode/chart APIs, carousel/galleria overhaul, LazyDataModel count and PrimeFlex3 conversion do not apply. No such tags/APIs/dependencies or custom CSV client validation/CSP setup. No speculative future-stage changes. |

**Issue classification:**

| Classification | Findings |
|---|---|
| INHERITED | Reconstructed baseline not private6.2.30 equivalence; no behavioral suite/runtime; all deferred risks; missing bundled Omega/config discrepancy from PF10. |
| NEW MIG-04 ISSUE | rowExpansion requires rowKey; dialog responsive default changes. |
| RESOLVED IN MIG-04 | Stable reference key and explicit prior responsive behavior; inherited static theme blocker resolved by approved explicit Saga, including five icon mappings from four undefined legacy names. |
| DEPRECATED BUT SUPPORTED | Calendar, java.util.Date value and three legacy grid panelGrids. |
| RUNTIME-ONLY RISK | Saga visual change, legacy icon/CSS cascade, row identity/postback, updated client libraries and all existing interactions. |

**Historical comparison — all actual historical changes and current differences:**

| Change | Classification | Decision |
|---|---|---|
| Historical PF11 catalog bump and fallback filename/coordinate | REQUIRED NOW | Applied. Historical commit touched only catalog and libs README. |
| Upload relocation/listener and explicit single sorting | ALREADY PRESENT | Prior current migrations, not new historical PF11 edits; retained/revalidated. |
| Historical private-artifact wording | HISTORICAL ONLY | Current public-artifact/provenance and reconstruction disclaimers retained. |
| Generic old-assessment DatePicker/client-validation advice | NO LONGER REQUIRED | Those features/configurations are not present; do not convert supported Calendar. |
| Historical omission of required key and changed dialog default; no controlled theme decision | CURRENT MIGRATION MISSING CHANGE (detected and resolved) | Current implementation adds key, pins responsive false and applies separately approved Saga. No outstanding missing change. |

**Theme gate:**

| Field | Outcome |
|---|---|
| Theme compatibility | PASS — STATIC ONLY |
| Theme before / user-declared baseline | Omega; historical deployed supply remains unknown |
| Current configured / target theme | Saga, explicit approved replacement; not inferred from default |
| PF11 Omega status | REMOVED / REPLACED; bundled removal was PF10 |
| Omega replacement required at this gate | YES, corrective prerequisite implemented in MIG-04 |
| Framework default | saga, unchanged from PF10; source explicitly names it so no implicit fallback relied upon |
| Theme artifact | Bundled PF11 `META-INF/resources/primefaces-saga/theme.css`; no separate dependency needed |
| Custom CSS impact | HIGH potential visual/cascade risk; existing stylesheet unchanged |
| Visual validation | DEFERRED under user acceptance, not equivalent/verified |

PF11 HeadRenderer reads configured theme and requests primefaces-saga/theme.css. The CSS has no external url() font/image references; PrimeIcons resources are bundled. Legacy ui-icon rendering and all custom visual surfaces still need runtime inspection. No local Omega resource or template was found to preserve; no claim that an arbitrary external Omega stylesheet is supported.

**Browser gate:** Scoped static PF11 compatibility PASS; no application IE-specific documentMode/userAgent/ActiveX/ms-prefixed API/-ms-CSS/conditional comment/X-UA-Compatible/polyfill/workaround detected. Framework PF11 retains IE detection/polyfills; no new PF11 IE-removal boundary identified. Incremental **IE impact LOW / MEDIUM confidence**, not proof of app IE support. Business requirement remains UNKNOWN, full supported-browser validation DEFERRED, and MIG-06/PF12->13 still requires a recorded product decision. No IE cleanup. Existing modern Grid/flex/gap are not IE-only workarounds.

**Runtime risks retained:** All 13 original checks remain DEFERRED: deployment/startup; Home; Elements; editor secure=false; dialogs; AJAX; upload; tables; date selection; autocomplete; CSV; messages/growl; polling/progress. All prior additional risks remain in state. New checks: approved Saga resource requests/cascade/icons/focus/contrast/responsive comparison on all five pages; row key identity across expansion/sort/filter/pagination/postbacks; fixed dialog behavior and confirmation overlays; PF11 client-library/editor/upload/table/export behavior and browser console.

**Findings:** ATX-FIND-006/007/008/010/014 partially addressed or revalidated; none fully closed because final-target/runtime evidence remains outstanding. ATX-BLOCK-007 resolved STATIC only; historical provenance/visual comparison remains deferred. No compatible EAP environment became available or was substituted. Overall risk MEDIUM with HIGH potential visual/CSS impact; no runtime claim.

**Records changed:** migration state/log, theme-browser-gates execution addendum, runbook, assessment transformation-plan/matrix corrections, agent/instructions/prompt current-theme guidance. These keep future resumptions from treating approved Saga as either an implicit default or an unresolved choice.

**Sources:** [PF11 migration guide](https://github.com/primefaces/primefaces/blob/11.0.0/docs/migrationguide/11_0_0.md), [PF11 theme documentation](https://github.com/primefaces/primefaces/blob/11.0.0/docs/11_0_0/core/themes.md), [PF11 calendar docs](https://github.com/primefaces/primefaces/blob/11.0.0/docs/11_0_0/components/calendar.md); matching Maven Central binary/source JARs inspected directly. Target source: DataTable/Renderer row-key path, DialogBase, TextEditorRenderer, PrimeConfiguration/PrimeApplicationContext, HeadRenderer, Calendar/AutoComplete events, exporter factory and dialog JS. Local historical commit is supporting evidence, not authority.

**Stop:** MIG-04 COMPLETE — CONDITIONAL. Next phase MIG-05, PF11 -> PF12. **MIG-05 has NOT started** and is not authorized.

### MIG-05 — PrimeFaces 11.0.0 to 12.0.0

**Status:** COMPLETED_CONDITIONAL. Runtime and visual validation DEFERRED, never inferred from build/static success.

**Authorization/scope:** User authorized MIG-05 only and conditional completion with deferred runtime/visual checks. Preserve explicitly configured Saga, all MIG-00 through MIG-04 risks, Java8 source/target, EE8 provided APIs, EAP7.3, namespaces/descriptors and application behavior. No PF13+, IE-removal cleanup, Jakarta conversion or unrelated refactoring. MIG-04 was confirmed COMPLETED_CONDITIONAL before edits.

**Preflight:** Read state/log/runbook/theme-browser gates, assessment matrix and relevant ATX-FIND-006/007/008/010/013/014, matching stage definition/report, historical PF12 commit and official PF12 migration guide. Actual conditional PF11 source/WAR is the baseline. The report's old fileUploadListener wording is stale: current markup already uses listener. Generic exporter/Quill/client-library statements require exact-artifact verification, not speculative edits.

**Checkpoint/rollback:** Base revision `84b34d4fd1b8fedaab6f2c20289802789bcb9cbd`. Existing uncommitted migrations and planning records preserved; no commit created. Session folder `/Users/amineabri/.copilot/session-state/b576bbf4-7254-42d8-992a-9e42c392510e/files/`:

| Artifact | SHA-256 |
|---|---|
| `pre-mig05.patch` — tracked pre-stage binary diff | `d7a22e095a926758ab84dbb66c92f7133ec7c95392f36f45d6d0799355c9c24c` |
| `pre-mig05-theme-browser-gates.md` — separately preserved then-untracked gate document | `1c3f003bfc6d394bd970ab20e8068c8376cc50e7ad218f0b25c56383322d7246` |
| `pre-mig05-pf1100.war` — prior passing PF11 artifact | `259ce9a63cc6c043a44a372a526e6858b06c67e01127570210504aa87864cd91` |

Restore only in a separate worktree at the base revision, applying the pre-stage patch and separately preserved gate document. Keep the prior WAR; do not overwrite current/unrelated changes.

**Required changes:**

| File | Change |
|---|---|
| `gradle/libs.versions.toml` | org.primefaces:primefaces 11.0.0 -> 12.0.0, default non-Jakarta artifact. |
| `build.gradle` | Matching PF12 description only; build model/Java/EE scope unchanged. |
| `libs/README.md` | Public PF12 coordinate and local fallback filename; preserve original reconstruction disclaimer. |
| Migration state/log/runbook/theme-browser gates and assessment matrix | Actual gate outcomes, new supported deprecation and future decision boundary; no future phase execution. |

**Source/XHTML/configuration changes:** NONE. Every application web resource (including all XHTML, template, CSS and descriptors) and all 11 compiled Java classes match the prior PF11 WAR byte-for-byte. Existing rowKey, two single-sort settings, responsive=false, native upload parameters/limits, secure=false, Saga and icon mappings retained.

**Build/test/dependency gates:**
- `./gradlew clean build --console=plain`: BUILD SUCCESSFUL, compilation and WAR packaging PASS; no warnings or unexplained failures.
- Independent `./gradlew test --console=plain`: command SUCCESS, `test NO-SOURCE`. **AUTOMATED BEHAVIORAL TEST COVERAGE UNAVAILABLE**. Discovered/executed/passed/failed/skipped counts all zero; not passing behavioral validation.
- `./gradlew dependencyInsight --dependency org.primefaces:primefaces --configuration runtimeClasspath --console=plain`: 12.0.0 selected.
- Resolved artifact: `/Users/amineabri/.gradle/caches/modules-2/files-2.1/org.primefaces/primefaces/12.0.0/19c3e01940e8fb0d7cef82ca6a950aa7fa64fa88/primefaces-12.0.0.jar`, matches public Maven Central binary and WAR dependency. No local override or renamed artifact.
- PF12 SHA-256: `a4bd010668aee7a59727531a02cf841fdc79ef08163df6ad06aa5a1e3c51720d`.

**WAR validation: PASS.** `build/libs/primefaces-homeoffice.war`, 4,504,253 bytes; SHA-256 `671abf1dca009397ecd922a79797ac3bd87181ee33be21bd528b6d60698f98ca`. All 11 expected application classes, major52/Java8; sole dependency `WEB-INF/lib/primefaces-12.0.0.jar`. No PF11/stale/duplicate PF JAR or bundled provided EE APIs. All three descriptors parse and match unchanged source; Facelets and resource packaging valid. Saga CSS and bundled PrimeIcons present; static resource availability does not prove HTTP resolution on EAP.

**Static compatibility: PASS.**

| Metric | PF11 baseline | PF12 |
|---|---:|---:|
| XHTML files | 6 | 6 |
| p:* tag occurrences | 125 | 125 |
| Distinct tags | 44 | 44 |
| Attribute occurrences | 295 | 295 |
| Distinct tag/attribute pairs | 131 | 131 |
| Unsupported tags | 0 | 0 |
| Unsupported attributes | 0 | 0 |

All six XML files parsed and every PF tag/attribute checked against embedded PF12 taglib. Component value/default/implementation checks supplement tag presence; EL evaluation, actual DOM, naming-container update resolution and interaction behavior remain runtime-only.

| Surface | Target evidence / decision |
|---|---|
| Java/upload | FileUploadEvent.getFile returns model.file.UploadedFile; getFileName/getSize compile. FileUpload.broadcast invokes getListener with event. PrimeConfiguration still reads UPLOADER; service loader selects native and service descriptor includes NativeFileUploadDecoder. Keep native, advanced listener and multipart limits unchanged. Transfer/listener/metadata checks remain deferred. |
| Tables / row identity | DataTableRenderer still obtains row key for rowExpansion; List-backed DataTable throws without configured key. Keep reference key (four immutable unique references). Request-scope evaluation resolves it against the current row. Postback identity, expansion state and sort/filter/pagination interactions require runtime checks, not a row-index substitute. |
| Sort/filter/pagination/selection | Default sortMode remains multiple; both single settings remain necessary to preserve UX. Existing column ValueExpressions remain supported. No removed range filter or renamed checkbox rowSelectMode used; no row-selection/lazy model API requiring edits. Existing form selection controls retained. |
| Dialogs | Responsive default true, same as PF11; explicit false preserves prior fixed behavior. Target source dialog JS still defines show/hide used by application. Confirmation overlay, sizing/focus/responsiveness remain deferred. |
| Calendar/date | One p:calendar with java.util.Date, dd/MM/yyyy, showOn=button, dateSelect remains DEPRECATED BUT SUPPORTED; RUNTIME VALIDATION REQUIRED. No custom converter/date-widget call requiring edits; do not convert merely because DatePicker exists. |
| Editor | SUPPORTED, secure=false declared/honored; no evidence of removal/deprecation of used option. Relevant sanitizer guard still depends on secure=true and sanitizer presence; no sanitization claim. BEHAVIOR CHANGED: PF12 editor is theme-aware. Exact CSS consumes --surface-a/--text-color and Saga defines both, so no additional CSS required. Rendering/placeholder/toolbar contrast and value/HTML round trip RUNTIME VALIDATION REQUIRED. |
| Repeat | **New PF12 deprecation:** p:repeat remains in taglib and UIRepeat class is @Deprecated; guide recommends ui:repeat on specified MyFaces/Mojarra versions. Exact EAP-provided Faces version is unverified. Retain supported existing repeat; do not replay old PF10 replacement or assume a forced migration. Add actual-runtime repeat/state check. |
| Grid / PrimeFlex | Three panelGrid layout=grid usages remain supported/deprecated. Renderer keeps legacy grid path and emits ui-g/ui-g-12/ui-md-6, all present in bundled PF12 CSS. PrimeFlex3 affects flex path; application has no layout=flex or PrimeFlex dependency. Do not introduce PrimeFlex3/CSS refactor for unused path. |
| AJAX/autocomplete/widgets | Six ajax tags, explicit dateSelect/itemSelect and current implicit events/completeMethod retained; no used event or widget-method rename identified. Existing process/update targets still declared; actual resolution and listener dispatch deferred. |
| CSV | Existing declarative type=csv attributes remain supported; factory still selects DataTableCSVExporter. No custom exporter contract or Excel/PDF dependency to migrate. Keep ajax=false download. CSV headers/rows/encoding/download require runtime checks. |
| Menus/icons/styles | All used PrimeIcons and remaining legacy icon classes have target CSS definitions; PrimeIcons font assets are packaged. All 26 locally referenced ui-* classes exist in target components CSS, not proof of DOM or visual equivalence. Custom CSS/layout/menu/form/table/dialog/message overrides unchanged. |
| Other used features | Growl/messages, poll/progress, reset/autoUpdate and menu/confirmation handlers remain supported; rendering, feedback, timing and reset behavior deferred. |

**Issue classification:**

| Classification | Findings / disposition |
|---|---|
| INHERITED | No behavioral suite/runtime; reconstructed baseline not private6.2.30 equivalence; all 13 original checks and MIG-03/MIG-04 additions; HIGH potential Omega-to-Saga CSS/visual risk. |
| NEW MIG-05 ISSUE | Repeat deprecation; editor theme-awareness; PrimeFlex3 guidance requires actual-path review. No unresolved required static application edit identified. |
| RESOLVED IN MIG-05 | PF12 dependency/packaging verified; Saga supplies editor variables, legacy grid remains supplied, used icons compatible. No new application changes needed. |
| DEPRECATED BUT SUPPORTED | Calendar, java.util.Date, three grid-layout panelGrids and now p:repeat. |
| RUNTIME-ONLY RISK | Editor styling/HTML round trip, deprecated repeat on server Faces, row identity/state, CSV/upload/client resource interactions and inherited Saga visual risk. |

**Historical comparison (`66e5702e182fbc260af0fec426dd79c6e551a220`):**

| Change | Classification | Decision |
|---|---|---|
| Historical PF12 version and fallback filename/coordinate | REQUIRED NOW | Applied; actual historical commit touched only catalog and libs README. |
| Current upload relocation/listener, rowKey, single-sort, responsive=false and explicit Saga/icons | ALREADY PRESENT | Prior current work, not new historical PF12 edits; retained/revalidated. |
| Historical Elite/PRO wording | HISTORICAL ONLY | Current public-artifact/provenance and reconstruction context retained. |
| Generic fileUploadListener wording / unconditional PrimeFlex conversion or exporter rewrite | NO LONGER REQUIRED | Current listener already correct; retained grid path and declarative CSV supported. No speculative replay. |
| Additional required change absent from current implementation | CURRENT MIGRATION MISSING CHANGE: NONE | No missing required change identified. Deprecation/theme behavior explicitly recorded instead of ignored. |

**Theme gate:** PASS — STATIC ONLY. Current/target Saga; **theme change NO**; Omega remains REPLACED in MIG-04. Same explicit web.xml value saga, exact `META-INF/resources/primefaces-saga/theme.css` in PF12 JAR; no additional artifact/dependency required. HeadRenderer default also remains saga, but no implicit fallback relied upon. Saga CSS has no external url() font/image references. **PrimeIcons PASS**, **custom CSS impact HIGH** inherited potential risk, **visual validation DEFERRED**. No assertion of Omega equivalence or successful browser rendering.

**Browser gate:** PASS for scoped static PF11->PF12 transition; IE-specific application code **NO** after repeat Java/XHTML/XML/CSS/resources scan (documentMode, userAgent, ActiveX, ms APIs, -ms- CSS, conditional comments, compatibility mode, polyfills/workarounds). Packaged PF12 core.js still contains msie detection/msMatchesSelector polyfill; source core.env/core.polyfills corroborate. This is not a comprehensive IE support certification or proof existing Grid/gap/editor styling works on IE. Incremental **IE impact LOW / MEDIUM confidence**; business requirement UNKNOWN, runtime browser validation DEFERRED. **IE product decision required now: NO**; mandatory decision remains before **MIG-06/PF12->13**. No IE cleanup or product decision executed early.

**Inherited runtime checks:** All 13 remain DEFERRED: deployment/startup; Home; Elements; editor secure=false; dialogs; AJAX; upload; tables; date selection; autocomplete; CSV; messages/growl; polling/progress. All prior additional checks retained. No compatible runtime was substituted and no deployment claimed. Add explicit PF12 editor theme/contrast/HTML check, repeat/state check on actual Faces, legacy panelGrid responsive check and row key interactions. HIGH potential visual risk from MIG-04 is carried forward, not reset to low by lexical CSS validation.

**Findings/remaining risk:** ATX-FIND-006/007/008/010/014 partially addressed/revalidated, none fully closed without target/runtime acceptance. Overall risk MEDIUM with inherited HIGH potential CSS/visual impact. Browser decision blocker ATX-BLOCK-008 remains scheduled before MIG-06.

**Sources:** [PF12 migration guide](https://github.com/primefaces/primefaces/blob/12.0.0/docs/migrationguide/12_0_0.md), [PF12 theme docs](https://github.com/primefaces/primefaces/blob/12.0.0/docs/12_0_0/core/themes.md), exact public Maven Central `primefaces-12.0.0.jar` and matching sources JAR; embedded taglib, DataTable/Renderer/Base, DialogBase/widget JS, FileUpload/event/model/services, PrimeConfiguration/PrimeApplicationContext, TextEditorRenderer/CSS, UIRepeat, PanelGridRenderer/GridLayoutUtils, CSV factory, HeadRenderer, theme/icon/core resources inspected. Repository history is supporting evidence, not authority.

**Stop:** MIG-05 COMPLETE — CONDITIONAL. Next phase MIG-06, PF12 -> PF13. **MIG-06 has NOT started**; require separate authorization and recorded browser product decision before its edits.

### MIG-06 — PrimeFaces 12.0.0 to 13.0.0

**Status:** COMPLETED_CONDITIONAL. Runtime/visual validation DEFERRED, not a functional pass.

**Preflight/authorization:** User authorized MIG-06 only with conditional completion/runtime deferral. Read migration state/log/runbook/theme gates, assessment matrix/findings, PF13 stage definition/report, historical commit and official PF13 guide. MIG-05 confirmed COMPLETED_CONDITIONAL. Actual conditional PF12 application/WAR is baseline; all prior changes/risks preserved. Before dependency edits asked the mandatory IE question; user selected **"IE is not required — accept dropping IE support with PF13 and continue MIG-06 only."** No PF14+, Java/EAP/EE upgrade, Jakarta/descriptor migration or unrelated refactor.

**IE product gate: ACCEPTED.** IE business requirement **NO**; **IE SUPPORT DROPPED WITH PRIMEFACES 13**. Repeated application Java/XHTML/XML/CSS/resource scan found no IE-only documentMode, ActiveX, navigator.userAgent check, ms API, -ms- CSS, conditional comment, compatibility meta tag, polyfill or workaround. No items to REMOVE NOW/REPLACE/MANUAL REVIEW; retain Grid/flex/gap for other browsers. No cleanup or unsupported IE hack. IE impact **LOW / MEDIUM confidence** based on explicit product decision and negative code scan, not user analytics or runtime evidence. Bundled third-party IE strings do not override official support removal. Named modern-browser/version/OS acceptance matrix remains QA work.

**Checkpoint/rollback:** Base `84b34d4fd1b8fedaab6f2c20289802789bcb9cbd`; no commit created. Session folder `/Users/amineabri/.copilot/session-state/b576bbf4-7254-42d8-992a-9e42c392510e/files/`:

| Artifact | SHA-256 |
|---|---|
| `pre-mig06.patch` — tracked pre-stage binary diff | `a70ab34d954c77e1d32ebde150546f39a39bbfe6edc0df3158ce947f71f7af9b` |
| `pre-mig06-theme-browser-gates.md` — separately preserved then-untracked document | `22a57b88a86f0eeff3eb415314a55e210bb4e03a0a7db8a58b2e83804ef2d022` |
| `pre-mig06-pf1200.war` — prior passing PF12 artifact | `671abf1dca009397ecd922a79797ac3bd87181ee33be21bd528b6d60698f98ca` |

Recover in a separate worktree at the base revision, applying checkpoint patch and separately preserved document; keep prior WAR. Never discard existing working changes.

**Required changes:**

| File | Change / evidence |
|---|---|
| `gradle/libs.versions.toml` | PF12 -> 13.0.0, default non-Jakarta artifact. |
| `build.gradle`, `libs/README.md` | Matching description, public coordinate/local fallback filename; build model/Java/EE provided scope unchanged. |
| `src/main/webapp/elements.xhtml` | Sole p:repeat -> existing JSF ui:repeat namespace, identical value/var/children. PF13 removes tag and component classes; migration REQUIRED NOW. |
| `src/main/webapp/elements.xhtml` | Editor height 150 -> 150px. PF13 height is String and renderer emits CSS length without appending units. secure=false unchanged. |
| State/log/runbook/theme gates/assessment matrix and agent/instructions | Record actual evidence, accepted IE decision and conditional outcome so future agents do not reopen it as UNKNOWN. |

No Java, custom CSS, descriptor, template, theme configuration, font/image/icon or IE-code change. All application class bytes match PF12; all web resources except the two precise Elements transformations are unchanged.

**Build/test/resolution:** `./gradlew clean build --console=plain` BUILD SUCCESSFUL, compile/package PASS; no warnings or unexplained failures. Independent `./gradlew test --console=plain` command SUCCESS but test NO-SOURCE: **AUTOMATED BEHAVIORAL TEST COVERAGE UNAVAILABLE**, all discovered/executed/passed/failed/skipped counts zero. DependencyInsight selects org.primefaces:primefaces:13.0.0. Resolved cache `/Users/amineabri/.gradle/caches/modules-2/files-2.1/org.primefaces/primefaces/13.0.0/965262fed2ebe005078f8bb1de7b0dbc29fd55ab/primefaces-13.0.0.jar`, byte-identical to public binary and WAR dependency. PF13 SHA-256 `54e525741c6727504270f3a94cf4a7e2111edabe0fa150e3ec26d72e244ca3e9`; no local override.

**WAR gate PASS:** `build/libs/primefaces-homeoffice.war`, 4,104,826 bytes, SHA-256 `3e4c0d4a644751480a72bc8887611959b46d321b83590f291ce56e5da6cc0206`. All 11 expected application classes, major52/Java8; sole JAR `WEB-INF/lib/primefaces-13.0.0.jar`. No PF12/duplicate PF/provided EE APIs. All three descriptors parse/match unchanged source. Saga theme and PrimeIcons resources supplied in packaged PF13; actual HTTP serving remains DEFERRED.

**Static inventory:**

| Metric | PF12 baseline | PF13 final |
|---|---:|---:|
| XHTML files | 6 | 6 |
| p:* occurrences | 125 | 124 |
| Distinct PF tags | 44 | 43 |
| PF attribute occurrences | 295 | 293 |
| Distinct tag/attribute pairs | 131 | 129 |
| Unsupported tags | 0 | 0 |
| Unsupported attributes | 0 | 0 |

Initial target scan detected p:repeat as unsupported; final scan checks every tag/attribute against exact embedded taglib after remediation. Count reduction is solely repeat's move to JSF; no UI content removed. Tag presence is not EL/DOM/behavior validation.

| Surface | PF13 result / decision |
|---|---|
| Java/runtime prerequisites | Used FileUploadEvent/model.file.UploadedFile/getFileName/getSize compile unchanged. Public PF13 classes max bytecode52. Old report's Java11 minimum is unsupported; official guide deprecates JSF2.0/2.1 for PF14 removal rather than requiring JSF2.3 now. Preserve Java8 target/EE8/EAP7.3; actual server deployment remains deferred. |
| Upload | listener/event invocation, native decoder service and UPLOADER parameter remain in exact source. Old assessment's removal assertion is false for this artifact. Retain native/multipart limits/web.xml unchanged. |
| Tables | rowKey reference remains required for List-backed rowExpansion; default sortMode still multiple, so both single settings remain necessary. Existing sort/filter ValueExpressions, pagination/row toggler/expansion supported. Actual identity/state across postback, filtering and pagination deferred. |
| Dialog/AJAX/autocomplete | Responsive default true, explicit false retained. show/hide methods remain. Six ajax tags, dateSelect/itemSelect and implicit events retained; no used event/widget-method rename. Process/update targets unchanged, runtime resolution unverified. |
| Calendar/date | DEPRECATED BUT SUPPORTED / RUNTIME VALIDATION REQUIRED. Existing p:calendar/java.util.Date/dd/MM/yyyy/showOn=button/dateSelect retained; no converter/widget API requiring change. |
| Repeat | REMOVED / MIGRATION REQUIRED. One p:repeat -> ui:repeat completed; validate rendered department list/content/state on actual EAP-provided Faces. No future cleanup performed. |
| Editor | SUPPORTED / BEHAVIOR CHANGED / RUNTIME VALIDATION REQUIRED. String CSS height fixed to 150px. secure=false declared/honored; relevant sanitizer guard unchanged; Saga supplies --surface-a/--text-color. No sanitization/security claim. |
| PanelGrid/radio | All three panelGrids explicitly select grid, so PF13 default tabular->grid causes no new layout choice. Legacy ui-g/ui-md classes still shipped. SelectOneRadio default lineDirection intent retained with responsive renderer DOM; visual/keyboard/choice behavior must be checked, no speculative deprecated-layout pin. |
| Menus | Guide warns expanded defaults, but actual MenuRenderer uses expanded=!toggleable||submenu.isExpanded. Current menu defaults toggleable=false, so content remains expanded; no unnecessary expanded attributes. Existing confirm icon explicitly set, unaffected by removal of default icon. |
| CSV | PF13 uses DataExporters registry; PrimeApplicationContext registers csv -> DataTableCSVExporter. Declarative target/type/fileName remain supported; no custom exporter API to change. Preserve ajax=false; check actual rows/headers/quoting/line endings/encoding/download at runtime. |
| Feedback/other | Growl/messages, poll/progress, reset/autoUpdate and selection controls remain declared/supported; interaction/timing/validation deferred. |
| CSS/icons/theme | All 26 locally referenced ui-* classes occur in target CSS; every used pi/legacy icon class defined and PrimeIcons font assets supplied. No local Open Sans reference or custom removed-component/widget API. Lexical coverage does not prove rendered DOM/cascade. |

**Issue classification:**

| Class | Finding / disposition |
|---|---|
| INHERITED | No behavioral suite/runtime, reconstructed private-baseline equivalence unproven, all original 13 interactions plus prior additions, HIGH Omega-to-Saga visual risk. |
| NEW MIG-06 ISSUE | IE support removed, repeat removed, editor height type changed; radio DOM/exporter internals require regression checks. |
| RESOLVED IN MIG-06 | Explicit IE product acceptance, ui:repeat replacement, 150px length; exact target API/theme/packaging verification. |
| DEPRECATED BUT SUPPORTED | Calendar/java.util.Date and legacy Grid CSS; tabular radio alternative deprecated (not forced onto current markup). |
| REMOVED / MIGRATION REQUIRED | p:repeat migrated. Other removed Chart/Lightbox/Ring/ContentFlow unused. |
| RUNTIME-ONLY RISK | JSF repeat rendering/state, editor dimensions/value, responsive radio markup/keyboard, CSV output and inherited table/upload/theme/client behavior. |

**Historical comparison (`953ba70edaf077e35ba9efbcaea644418f10df66`):**

| Historical/current difference | Classification | Decision |
|---|---|---|
| PF13 version + fallback coordinate/name (all actual historical edits) | REQUIRED NOW | Applied. Historical commit touched only catalog and libs README. |
| Upload relocation/listener, rowKey, single sort, responsive=false, Saga/icons | ALREADY PRESENT | Prior current work, revalidated; not newly present in historical PF13 diff. |
| Old report event relocation, uploader removal/calendar replacement | NO LONGER REQUIRED | Retained exact-artifact-supported usage, not speculative replay. |
| Elite/PRO wording and bump-only completion claim | HISTORICAL ONLY | Preserve current public-artifact/reconstruction context and stricter gates. |
| Missing repeat/height fixes and IE decision in historical bump | CURRENT MIGRATION MISSING CHANGE (detected/resolved) | Current phase adds all three; none outstanding. |

**Theme report:** PASS (static), current/target **Saga**, change **NO**, Omega **REPLACED in MIG-04**. Bundled resource remains `META-INF/resources/primefaces-saga/theme.css`; no relocation/new dependency. Explicit configuration unchanged; framework default saga unchanged, no fallback relied upon. Editor variables/used icons verified. **Custom CSS impact HIGH** inherited potential risk; **PrimeIcons PASS**; **visual validation DEFERRED**. No assertion of visual equivalence.

**Runtime/risk carry-forward:** All original 13 checks remain: deployment/startup; Home; Elements; editor secure=false; dialogs; AJAX; upload; tables; date selection; autocomplete; CSV; messages/growl; polling/progress. Preserve every MIG-03/04/05 addition. New MIG-06 checks cover JSF repeat, editor units, responsive radio DOM, modern-browser behavior after accepted IE drop and exporter registry/output. Runtime remains unavailable; no substitute EAP deployment or browser success claimed. Overall risk MEDIUM, inherited potential visual/CSS risk HIGH.

**Findings:** ATX-FIND-006/007/008/010/014 partially addressed/revalidated, none fully closed without target/runtime acceptance. ATX-BLOCK-008 resolved by explicit product decision; named modern-browser acceptance matrix/runtime evidence remains outstanding. Full migration-state and transformation log retain historical conditional results.

**Sources:** [PF13 migration guide](https://github.com/primefaces/primefaces/blob/13.0.0/docs/migrationguide/13_0_0.md), [PF13 themes](https://github.com/primefaces/primefaces/blob/13.0.0/docs/13_0_0/core/themes.md), exact public Maven Central binary/source JARs and embedded taglib/renderer/config/export registry/resources. Local history is supporting evidence, not authority.

**Stop:** MIG-06 COMPLETE — CONDITIONAL. Next MIG-07, PF13 -> PF14. **MIG-07 has NOT started** and is not authorized.

### MIG-07 — PrimeFaces 13.0.0 to 14.0.0 / Java 11 minimum

**Status:** COMPLETED_CONDITIONAL — valid Java11 build/static/WAR evidence, not a runtime/behavioral pass. JSF **LIKELY 2.3+ BUT RUNTIME UNVERIFIED**. No MIG-08/Jakarta/Java21/EAP8 migration.

**Preflight:** User authorized MIG-07 only and expressly required Java11/Faces2.3 gates, permitting explicit deferred runtime risks for conditional completion. Read migration state/log/runbook/theme gates, assessment matrix/findings, PF14 historical report/stage definition and actual historical commit. MIG-06 confirmed COMPLETED_CONDITIONAL. Clean starting HEAD `b254429990b48e414914769217a3fd94daeb46ed` includes previous phases; all earlier deferred checks/validation records preserved. The old stage recipe's Java8 instruction conflicts with exact PF14 requirements and this authorization: corrected, not blindly followed.

**Checkpoint/rollback:** Starting revision above, `pre-mig07.patch` is empty (SHA-256 `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`). Saved prior passing `pre-mig07-pf1300.war` SHA-256 `3e4c0d4a644751480a72bc8887611959b46d321b83590f291ce56e5da6cc0206`, in `/Users/amineabri/.copilot/session-state/b576bbf4-7254-42d8-992a-9e42c392510e/files/`. All pre-stage source/docs recoverable at the clean starting revision. Recover in a separate worktree, preserving unrelated work; roll back build/runtime settings together with PF coordinate. This phase created no commit.

#### Java and server/Faces gates

| Surface | Before | After / evidence |
|---|---|---|
| PrimeFaces | 13.0.0 | 14.0.0 non-Jakarta; exact binary has 1401 major55 classes, confirming Java11 minimum. |
| Source/target | Java8/8 | Java11/11; `options.release=11` also constrains Java API/bytecode level even on a later compiler. |
| Gradle runtime | Temurin11.0.30 / Gradle8.4 / macOS aarch64 | Unchanged; `java -version` and `./gradlew --version` observed before edits. Clean build succeeds. |
| Deployment config | EAP7.3.10 OpenJDK8/RHEL7 `7.3.10-2` | Same EAP7.3.10, OpenJDK11/RHEL8 `7.3.10-2`; Docker and Compose aligned, local image tag includes java11. Java11 WAR cannot run on prior Java8 image. |
| Actual deployment Java | Previous image config said8; no accessible deployment | UNKNOWN/unverified actual environment, configured11 minimum now. No pull/startup or registry authentication retry. |
| CI/CD Java | No tracked pipeline | No pipeline introduced; external CI UNKNOWN, must use Java11 minimum. |
| JSF compile/runtime | Java EE8 provided API; server uninspected | Stock EAP7.3 is documented Mojarra JSF2.3, so intended server supports PF14 minimum; actual module patch/default slot/per-app override unavailable. **LIKELY 2.3+ BUT RUNTIME UNVERIFIED**, not CONFIRMED. |

**Java classifications:** REQUIRED NOW: minimum11 compilation settings and matching deployment image. DEFER TO MIG-08: Java21, Jakarta/EE10, EAP8.1, any evidence-required wrapper change. BLOCKED BY RUNTIME: actual container/server startup and deployed JDK/JSF verification, not the successful local Java11 build.

Red Hat supports OpenJDK11 on EAP7.3 and publicly lists exact `registry.redhat.io/jboss-eap-7/eap73-openjdk11-openshift-rhel8:7.3.10-2`, EAP7.3.10/OpenJDK11/amd64. This is the minimal same-EAP Java11 image change; RHEL7->8 is an unavoidable image OS change, not an EAP8 upgrade. Image is catalog-deprecated; catalog metadata does not prove a successful entitled pull or current lifecycle support. Preserve user185, deployment path/root WAR, port8080 and linux/amd64, but verify these on actual image when environment becomes available.

JSF gate evidence: Red Hat Configuration Guide21.1.2 states EAP7.3 ships a single Mojarra-based JSF2.3 implementation; it also permits multiple installed implementations, `default-jsf-impl-slot` and application `org.jboss.jbossfaces.JSF_CONFIG_NAME` overrides. No faces-config.xml, per-app JSF override, custom module/deployment structure/server configuration is tracked. web.xml4.0, beans1.1 and jboss-web7.2 remain unchanged; they alone do not prove actual JSF version. Java EE8 APIs remain provided; no implementation bundled to mask uncertainty. **If actual server selects JSF<=2.2, deployment is incompatible and must not proceed without correction.**

#### Exact compatibility review

| Gate | PF14 result / action |
|---|---|
| SearchExpressions | **VALID statically / RUNTIME VALIDATION REQUIRED**. 13 update occurrences and one process=`@this`. Unique update strings: `selectionSummary`; `messages selectionSummary growl`; `formPanel messages growl`; `selectionSummary messages`; `messages growl`; `uploadStatus messages growl`; `progressPanel autoPanel`. Targets exist within enclosing elementsForm; whitespace ID lists and @this valid. No @parent/@form/@widgetVar, malformed composites or custom facade/resolver. DefaultCommand/export/reset/label/tooltip ID references retained. PF14 SearchExpressionUtils delegates to Faces SearchExpressionHandler; actual component tree, relative lookup and AJAX lifecycle must be exercised on server. Parsing is not runtime proof. |
| DataTables | Five tables/23 columns. No selection binding/selectionMode/rowSelectMode/disabledSelection/disabledTextSelection, selection column, custom sortFunction or LazyDataModel. Renames not applicable; do not add selectionBox or generic rewrites. Row expansion still calls getRowKey and List model requires key; preserve reference identity. Target default sortMode remains multiple; both explicit single controls remain necessary. Postback/sort/filter/pagination/expansion validation deferred. |
| Native upload | model.file.UploadedFile/listener/getFileName/getSize compile. Interface adds getWebkitRelativePath, but no app implementation exists, so no Java edit. Advanced mode/auto=true/dragDropSupport=false retained; no dropZone or simple-mode validation to convert. Native parameter still consumed; Servlet multipart limits1MiB/file and2MiB/request unchanged. |
| Upload validation | **DEPRECATED SETTINGS PRESENT:** allowTypes and sizeLimit still work in exact PF14 code. FileUpload.tryValidateFile retains legacy server checks; FileUploadRenderer.renderValidation creates FileValidator metadata from legacy attributes when no attached validator. No forced p:validateFile conversion now. fileLimit/error message overrides/Commons uploader unused. Existing p:messages and auto-updated growl/update targets retained; actual invalid extension/size boundary and visible validation feedback require QA. Review removal at next authorized phase only. |
| Client localisation | **RUNTIME VALIDATION REQUIRED**. CLIENT_SIDE_LOCALISATION now defaults true. No application locale, custom client locale, message bundle or AutoComplete/PickList/paginator override to migrate; PickList unused. Java FacesMessage literals unchanged. HeadRenderer loads locale by effective view/request/system language; English locale supplied. Check resource loading, autocomplete messages, paginator ARIA, file errors and language consistency in actual browser; no silent assumption of NO IMPACT. |
| Reduced motion | **RUNTIME VALIDATION REQUIRED**. PF detects prefers-reduced-motion reduce and disables animations. Existing confirmDialog fade effects are cosmetic; no app timer/callback/animation-dependent workflow found. No override/hack added. Verify focus, dialog/confirmation and progress/AJAX with preference on/off. |
| Calendar/date | **DEPRECATED BUT SUPPORTED / RUNTIME VALIDATION REQUIRED**. p:calendar/java.util.Date/dd/MM/yyyy/showOn=button/dateSelect retained. No locale firstDay setting to rename firstDayOfWeek. No required DatePicker migration. |
| TextEditor | **SUPPORTED / RUNTIME VALIDATION REQUIRED**. secure=false and height150px retained; same sanitizer guard, CSS String height rendering and Saga variables. No PF14-specific forced edit or sanitization claim. |
| Repeat | Sole ui:repeat retained from MIG-06; no p:repeat returned, no action required. |
| Growl/messages | Growl tag/class/used attrs still supported, not removed/deprecated by PF14 evidence. Preserve current feedback UX and autoUpdate rather than historical removal/movement. Real feedback behavior remains unvalidated. |
| Other API/client changes | Removed SearchExpressionFacade/Watermark/ImmutableSavedState/HazelcastCacheProvider/radio plain unused. DataTable selection renames, sortFunction third arg, JPALazyDataModel/loadOne, MenuBar delay rename unused. Used dateSelect/itemSelect remain; no used AJAX event rename. Dialog show/hide remain, responsive=true default still countered by explicit false. Tooltip delay now400ms versus150ms; add runtime check. Export/reset/autoUpdate/poll/progress/menu/grid paths retained. |

**Static inventory:** Six XHTML files; **124 p:* occurrences / 43 tags / 293 attributes / 129 distinct tag-attribute pairs**, unchanged from PF13. Checked every used tag/attribute against exact embedded PF14 taglib: **unsupported tags0, unsupported attributes0**. No unsupported API requires an application Java/XHTML change. Literal IDs/classes and taglib coverage do not establish EL/partial lifecycle/DOM/runtime behavior.

**Theme/browser:** STATIC THEME PASS, current/target **Saga**, theme change **NO**; Omega remains REPLACED in MIG-04. Core JAR still bundles `META-INF/resources/primefaces-saga/theme.css`, framework default saga unchanged, no relocation/extra artifact/fallback. Saga editor variables and used PrimeIcons/legacy icons/fonts supplied; all26 local ui-* CSS classes exist. App CSS unchanged. **Custom CSS impact HIGH** inherited potential risk, **PrimeIcons PASS**, **visual validation DEFERRED**. No browser runtime claimed. Modern-browser compatibility **RUNTIME VALIDATION REQUIRED**, particularly locale/ARIA/reduced-motion/tooltip changes. Accepted MIG-06 IE-not-required decision retained, not reopened as blocker; no IE compatibility hacks.

#### Historical comparison and issue classification

Historical commit `0aaee9db9a9a230f2632f8affc9b75bc6a2fe36d` touched catalog and Elements: removed growl, moved autoUpdate to messages and removed growl update targets.

| Change | Classification | Current disposition |
|---|---|---|
| PF13->14 catalog bump | REQUIRED NOW | Applied with matching metadata. |
| Growl removal / messages autoUpdate movement / update-target edits | NO LONGER REQUIRED | Exact PF14 supports growl; historical compatibility rationale disproved, preserve behavior. |
| Historical Java8-target build success | HISTORICAL ONLY | Does not establish Java8 runtime compatibility; PF14 classes require11. |
| Current ui:repeat/editor150px/upload listener/rowKey/sort/dialog/Saga/icon controls | ALREADY PRESENT | Revalidated; not newly introduced by historical PF14 diff. |
| Missing Java11 build/runtime alignment and JSF/SearchExpression gate in old migration | CURRENT MIGRATION MISSING CHANGE (detected/resolved) | Applied minimal Java11/image settings and explicit runtime-gap records now; no outstanding static incompatibility. |

Old report hypotheses of new default theme/growl removal/upload relocation/calendar replacement are not authority over exact artifacts. Stage recipe/instructions and current assessment addenda are corrected; original report retained as historical evidence.

| Class | Findings |
|---|---|
| INHERITED | Reconstructed baseline not proven private6.2.30 equivalent; no behavioral suite/compatible runtime; all original13 and prior added checks; HIGH Saga visual/CSS risk. |
| NEW MIG-07 ISSUE | Java11/JSF2.3 minimum; Faces search handler delegation; localisation default true; reduced motion; deprecated legacy upload attributes. |
| RESOLVED IN MIG-07 | Java11 compilation/configured runtime alignment; PF14 resource/API/tag/packaging verification; stock JSF2.3 evidence and explicit actual-runtime gap. |
| DEPRECATED BUT SUPPORTED | Calendar/java.util.Date, legacy Grid CSS, upload allowTypes/sizeLimit. |
| REMOVED / MIGRATION REQUIRED | Java8/JSF<=2.2 unsupported; build/config now11, real JSF version remains deferred. No used removed tag/API/property left. |
| RUNTIME-ONLY RISK | Java11/RHEL8 deployment and real JSF module selection; SearchExpression/locale/ARIA/accessibility/upload-error behavior plus inherited interactions/visuals. |

#### Build, test and WAR evidence

`./gradlew clean build --console=plain`: **BUILD SUCCESSFUL**, compile/WAR PASS, no warnings or unexplained failures. Independent `./gradlew test --console=plain`: command SUCCESS but **test NO-SOURCE**, zero discovered/executed/passed tests: **AUTOMATED BEHAVIORAL TEST COVERAGE UNAVAILABLE**. Not behavioral validation.

DependencyInsight selects PF14.0.0 on runtimeClasspath and provided javax:javaee-api8.0 on compileClasspath. Public PF14 SHA-256 **`fed912dd004dca5f366bfa2939174449d2e982d3a078aa9bc74e6fa3019d5c54`**, matches WAR dependency; no local override.

WAR `build/libs/primefaces-homeoffice.war`: **4,349,573 bytes**, SHA-256 **`5dc023c5faf09463f9b71055329314b3b88146bbb06e8f64777293670d388863`**. ZIP integrity PASS; all11 expected classes **major55/Java11**; sole dependency `WEB-INF/lib/primefaces-14.0.0.jar`, no PF13/duplicate PF/provided EE APIs. All three descriptors parse and remain unchanged; every application web resource byte-identical to prior PF13 WAR. Saga/icon resources packaged, actual HTTP serving DEFERRED. `docker compose config --quiet` passes merged configuration validation; it is not an image pull/container build/startup test.

**Files changed:** `gradle/libs.versions.toml`, `build.gradle`, `Dockerfile`, `docker-compose.yml`, `README.md`, `libs/README.md`; PF14 stage `definition/transformation_definition.md`; migration state/log/runbook/theme gates; assessment matrix/transformation-plan addendum; `.github/instructions/aws-transform-migration.instructions.md`. No src Java/XHTML/CSS/template/descriptor or wrapper change.

**Risk/finding carry-forward:** Original13 interactions and all prior runtime lists remain unchanged, with six MIG-07 checks added for Java11/RHEL8 startup, actual JSF/SearchExpressions, locale/ARIA, reduced motion, native upload boundaries/errors and date/tooltip/visual behavior. ATX-FIND-001/006/007/008/009/010/011/014 partially addressed/revalidated, none fully closed pending target/runtime acceptance. Overall runtime risk MEDIUM with inherited HIGH visual/CSS risk; no claim that deprecated EAP image is currently lifecycle-supported.

**Evidence sources:** [PF14 migration guide](https://github.com/primefaces/primefaces/blob/14.0.0/docs/migrationguide/14_0_0.md); exact Maven Central PF14 binary/source/taglib/renderers/config/client resources; [Red Hat EAP7 supported configurations, EAP7.3 section](https://access.redhat.com/articles/2026253); [EAP7.3 Configuration Guide, multi-JSF support](https://docs.redhat.com/en/documentation/red_hat_jboss_enterprise_application_platform/7.3/html/configuration_guide/jakarta_server_faces_configuration#multi_jsf_implementation_support); [EAP7.3 OpenJDK11 catalog/tag metadata](https://catalog.redhat.com/en/software/containers/jboss-eap-7/eap73-openjdk11-openshift-rhel8/5df2b327d70cc54e2d109df8). Public product metadata is not actual deployment validation.

**Persistent phase artifacts:** Session files `mig07-conditional.patch` and `mig07-pf1400.war` preserve final tracked changes and passing WAR alongside the pre-stage checkpoint. All changed documents are tracked and included in the patch. Disposable public artifact downloads removed after verification; Gradle-resolved dependency remains available through the normal cache.

**Stop:** MIG-07 COMPLETE — CONDITIONAL. Next MIG-08, PF14 -> PF15 Jakarta / Java21 / EAP8.1. **MIG-08 has NOT started** and is not authorized.

### MIG-08 — Jakarta boundary: PF14 to PF15.0.16 Jakarta / EE10 / Faces4

**Status: COMPLETED_CONDITIONAL.** MIG-08A-F executed in order with build attempts/checkpoints. **EAP 8.1 RUNTIME VALIDATION DEFERRED.** No provisioning, registry credential operation, image pull/build/start, community runtime substitution or MIG-09 execution.

**Preflight and explicit scope:** Read state/log/runbook/theme gates, Jakarta/EAP assessments, PF matrix/transformation plan, all relevant findings, PF15 recipe/report and historical `f2811fc`. Confirmed MIG-07 COMPLETED_CONDITIONAL. Approved plan explicitly assigns Java21/EE10/EAP8.1 to this boundary, but Red Hat's named runtime image has no server; asked user before implementation. User selected **“Follow the plan’s Java 21 build target; complete Jakarta migration and guard container deployment pending a provisioned EAP 8.1 image.”** This decision supersedes old bare-image replacement assumptions and separates build/static work from later authorized runtime prerequisites. Next existing phase remains MIG-09 final acceptance; no new numbered server phase invented.

**Checkpoint/rollback:** Base `b254429990b48e414914769217a3fd94daeb46ed` plus **pre-existing MIG-07** worktree diff `pre-mig08.patch` SHA-256 `05237997a5604a75881468ca69a18eccdca434f3be8ea036118e738cfca2b79f`. Prior passing `pre-mig08-pf1400.war` SHA-256 `5dc023c5faf09463f9b71055329314b3b88146bbb06e8f64777293670d388863`; pre-phase state `pre-mig08-state.json` also retained. Artifacts under `/Users/amineabri/.copilot/session-state/b576bbf4-7254-42d8-992a-9e42c392510e/files/`. Recover in a separate worktree from base+pre-phase patch; never discard prior/user work. This phase creates no commit.

#### MIG-08A — Jakarta dependency preparation

JavaEE8 aggregate replaced with `jakarta.platform:jakarta.jakartaee-api:10.0.0` as **providedCompile**. JakartaEE10 transitive APIs include Faces4.0.1, Servlet6, CDI4.0.1, Inject2.0.1, EL5.0.1, annotations2.1.1, Persistence3.1, Validation3.0.2 and Transactions2.0.1. They remain container-provided; unused platform APIs do not introduce app features.

| Dependency area | Classification / result |
|---|---|
| JavaEE aggregate/Faces/Servlet/CDI/Inject | JAKARTA REPLACEMENT REQUIRED, CONTAINER PROVIDED; resolved via EE10, no implementation packaged. |
| Persistence/Validation/Transactions/EL/annotations | CONTAINER PROVIDED; platform replacements resolved, no direct app persistence/validation/transaction imports to change. |
| PrimeFaces | JAKARTA REPLACEMENT REQUIRED. Temporary PF14 **Jakarta classifier** bridges A-C compilation; PF15 version remains in D. No javax/legacy PF artifact mixed into final graph. |
| Built-in Java/WAR plugins | ALREADY JAKARTA COMPATIBLE; Gradle8.4 unchanged. |
| Test dependencies | None; no framework added. |
| Legacy artifacts/settings | REMOVE JavaEE8 compile coordinate/unclassified PF fallback; no Commons library existed. Native selector removed only in D after exact PF15 inspection. |

Java source/target/**release21** and installed Java21 compiler toolchain selected per approved plan/user choice. Gradle8.4 daemon remains **Temurin11.0.30**; `compileJava --info` confirms compiler **Temurin21.0.9** at `/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home`. This is a supported toolchain path, not a claim Gradle8.4 can run on JDK21. No wrapper upgrade/download required.

Build attempt1 **FAIL**: Maven-local metadata had PF14 but not its Jakarta classifier; Gradle stuck to the first repository. Minimal root-cause fix excludes only `org.primefaces:primefaces` from mavenLocal, resolving public module from Central while preserving explicit classifier-specific local fallback. No shared Maven cache modified.

Retry **FAIL** with **30 compiler diagnostics** from12unmigrated javax imports. Dependencies/toolchain resolve; this isolates the source boundary. Full logs `mig08a-build.log` / `mig08a-build-retry.log` retained. No passing A WAR or deployment claimed; diagnostics are resolved immediately in B, not suppressed or bypassed with legacy APIs.

#### MIG-08B — source namespaces

Migrated exactly **12imports in5view beans**:5CDI scope imports,5Inject Named imports,2Faces message/context imports. Models, Java SE imports, bean names/scopes, actions/business state and session transient upload field unchanged. There are no application Servlet/JPA/Validation/Transaction imports to migrate.

`./gradlew clean build --console=plain` **PASS** with PF14Jakarta bridge/EE10/Java21. Saves `mig08b-checkpoint.patch` / `mig08b-pf14-jakarta.war`. This is an intermediate compile checkpoint, not a runtime-ready completed migration.

#### MIG-08C — descriptors and Faces namespaces

| Descriptor/surface | CURRENT -> TARGET | Change / validation |
|---|---|---|
| web.xml | JavaEE web4 -> Jakarta web6 | Jakarta schema/namespace/version; PROJECT_STAGE/FACELETS_SKIP_COMMENTS/FacesServlet names migrated. Preserve mapping/welcome/1MiB file/2MiB request. XML parse/static values PASS, server acceptance DEFERRED. |
| beans.xml | JavaEE CDI1.1 -> Jakarta CDI4 | Preserve annotated discovery. XML parse/static values PASS; actual CDI discovery/scopes/passivation DEFERRED. |
| jboss-web.xml | Vendor schema7.2/context-root=/ -> unchanged | No Jakarta EE package names in this vendor descriptor. Official schema/upstream parser support7.2/root context; no evidence requiring rewrite. Exact EAP8.1 parser/runtime acceptance DEFERRED. |
| faces-config/persistence/validation/custom taglib/deployment structure/server modules | ABSENT -> ABSENT | No unnecessary descriptor introduced. |
| Six XHTML files including shared template | old JCP Faces namespaces -> jakarta.faces.html/core/facelets as applicable | PF `http://primefaces.org/ui` unchanged. Jakarta Faces4 target; no JSP/custom handler/converter/validator/EL resolver to migrate. |

Clean build **PASS**, XML parsing/static checks PASS; `mig08c-checkpoint.patch` / `mig08c-pf14-jakarta.war` retained. Faces4 compile APIs and correct namespaces do not prove actual resource handling, EL, CDI or SearchExpression lifecycle.

#### MIG-08D — PF15 Jakarta and repository-relevant changes

Resolved **`org.primefaces:primefaces:15.0.16:jakarta`**, namespace family **jakarta.\***. Final WAR contains **`primefaces-15.0.16-jakarta.jar`** only; exact bytes match public Maven Central SHA-256 **`b78ca75ff08d9a9c776b397f3d45caf84fa9736048b510ae350819cb6721425f`**. FileUploadEvent binary and manifest exported types use Jakarta Faces; no local override exists. Classifier-specific fallback `libs/primefaces-15.0.16-jakarta.jar`; unclassified file is not eligible.

Initial exact PF15 taglib scan found **three unsupported attributes** on fileUpload: dragDropSupport, allowTypes, sizeLimit. Required remediation:

1. Rename `dragDropSupport="false"` -> `dragDrop="false"`.
2. Move **identical** `allowTypes="/(\.|\/)(txt|csv|pdf)$/"` and `sizeLimit="1048576"` onto attached **p:validateFile**; retain advanced/auto/listener/update/label.
3. Remove now-unread `primefaces.UPLOADER=native` parameter. Exact PF15 config removes selector/Commons support and uses native decoder automatically; multipart servlet limits unchanged.

No fileLimit/error override/dropZone/simple mode/custom UploadedFile implementation exists. Existing model.file.UploadedFile/getFileName/getSize/listener already correct. No new MIME/virus policy, client CSV global override or sanitization claim. Native extension/size validation intent preserved by exact validator/server paths and generated client metadata, but valid/invalid boundary tests and error visibility still need actual server/browser validation.

Clean build **PASS**; `mig08d-checkpoint.patch` / `mig08d-pf15-jakarta.war` retained.

| Other PF15 surface | Reassessment / disposition |
|---|---|
| DataTables | Five tables/23columns; reference rowKey remains necessary for List-backed rowExpansion; default sortMode still multiple, so both single settings retained. Selection/custom sorting/lazy/JPA models unused. Identity/sort/filter/pagination runtime checks remain. |
| Calendar/date | **DEPRECATED BUT SUPPORTED / RUNTIME VALIDATION REQUIRED**. Same p:calendar/java.util.Date/dd/MM/yyyy/showOn=button/dateSelect; changed defaultMillisec property unused. No aesthetic DatePicker conversion. |
| TextEditor | **SUPPORTED / RUNTIME VALIDATION REQUIRED**. secure=false and150px supported by same security guard/CSS-length renderer; editor variables supplied. No sanitizer introduced or sanitization claimed. |
| ui:repeat | Preserved; no p:repeat returned. Actual state/EL/rendering deferred. |
| AJAX/SearchExpressions | **STATICALLY VALID / RUNTIME VALIDATION REQUIRED**. Same13update occurrences and @this process, all named IDs in form. Faces4 handler/real tree/postbacks unverified. |
| Growl/messages/menu/dialog | Still supported, existing feedback UX/autoUpdate preserved; dialogs keep responsive=false and show/hide methods. Empty-menu-container change irrelevant to populated menus; no future cleanup. |
| Autocomplete/export/reset/poll/progress | Existing attributes/APIs remain declared; autocomplete labels/CSV registry/output and all inherited behavior checks persist. Progress label DOM changed; no local timing dependency found. |
| Removed/renamed unused APIs | Legacy charts/InputSwitch/Commons/old client selection/caret helpers/legacy widget namespace unused. UIData->PrimeUIData not directly imported. No generic rewrites. |

#### MIG-08E — explicit theme/resources and deployment guard

**Saga -> saga-blue (Saga Blue), rename required YES.** Explicit `primefaces.THEME=saga-blue`, target design system **PrimeOne**. Exact core Jakarta JAR bundles **`META-INF/resources/primefaces-saga-blue/theme.css`**; **no primefaces-themes.jar required**. Temporary saga alias/default is not relied upon. Saga Blue editor variables, all used pi/legacy icon classes/fonts and26locally used ui CSS classes supplied.

No local Omega/ThemeRoller/legacy theme JAR/copied Saga/obsolete theme assets exist to delete. Custom CSS unchanged; **impact HIGH** inherited potential risk with specific new PF15 surfaces: paginator actions now buttons can match app button/focus rules; ProgressBar label moves inside value div. Lexical class coverage does not prove rendered DOM/cascade. **PrimeIcons PASS; visual validation DEFERRED**. Accepted IE removal unchanged; modern-client locale/ARIA/reduced-motion/focus/browser-console checks retained.

Red Hat documents EAP8.1 EE10/Faces4/Servlet6 and Java21 support, but its runtime-only image has **no server**; server provisioning/chained image assembly is required. User explicitly selected deferral. Docker/Compose now **require external approved provisioned EAP_IMAGE**, no default. Server home uses documented **/opt/server**, with build-time checks for installed server/deployment directory before ROOT.war copy; port8080/UID185/platform unchanged pending real image verification.

No datasource/security domain/custom module/deployment structure/env-entry exists. Vendor root descriptor retained; actual parser/UID/permissions/entrypoint/scanner/architecture/immutable-image/access are **MANUAL REVIEW / DEFER TO AUTHORIZED RUNTIME WORK**. This configuration guards incompatible EAP7/bare-image deployment; it does not provision or certify an image.

Clean build **PASS**; `mig08e-checkpoint.patch` / `mig08e-pf15-jakarta.war` retained.

#### MIG-08F — final build/static/WAR and namespace evidence

Final `./gradlew clean build --console=plain` **PASS**; independent `./gradlew test --console=plain` command SUCCESS but test **NO-SOURCE**, zero discovered/executed/passed tests: **AUTOMATED BEHAVIORAL TEST COVERAGE UNAVAILABLE**. Logs `mig08f-build.log` / `mig08f-test.log` retained. Repository validator updated for actual Jakarta WAR/classifier/bytecode/theme/taglib/namespace checks and explicit provisioned-image guard rather than obsolete grep proxies; it **PASS**es without claiming runtime success.

| Static metric | PF14 baseline | PF15Jakarta |
|---|---:|---:|
| XHTML files | 6 | 6 |
| p:* occurrences | 124 | 125 |
| Distinct PF tags | 43 | 44 |
| Attribute occurrences | 293 | 293 |
| Distinct tag/attribute pairs | 129 | 129 |
| Unsupported tags/attributes | 0 / 0 | 0 / 0 |

Increase is attached validateFile; total attribute count unchanged because two attributes moved and dragDrop renamed. Every final tag/attribute checked against **exact classifier's** legacy-URI taglib; PF15 taglib filename changed to `META-INF/primefaces.taglib.xml` (additional Jakarta-URN taglib supplied). Declared taglib XML namespace is vendor metadata, not an unexplained javax Java dependency.

WAR **4,143,832bytes**, SHA-256 **`ab5d534c6f94edc2d5402f96863c4274f9a1ae710afd4ba48d69b1beaec1d198`**, ZIP integrity PASS. All11expected application classes **major65/Java21**, zero javax references. Sole JAR PF15Jakarta, no PF14/duplicatePF/platform API/implementation or javax-era Faces/Servlet/CDI/JPA library. Jakarta descriptors and explicit Saga Blue resources present; vendor context-root retained. API dependency graph is provided, not a bundled server substitute.

**Residual javax inventory — no unexplained occurrence:**

| Scope / classification | Count | Evidence / action |
|---|---:|---|
| Application source/build config/packaged app classes/descriptors | **0** | All applicable migration complete; no JavaSE javax import exists locally either. |
| VALID JAVA SE in PF classes/manifest | **24 literal occurrences** | javax.imageio and javax.xml.namespace/parsers/xpath; jdeps resolves java.desktop/java.xml. Retain. |
| LEGACY DEPENDENCY build metadata | **32 literal occurrences** | Embedded upstream Maven POM source dependencies/transformer rules, not resolved JavaEE dependencies or executable API links. Retain provenance. |
| LEGACY DEPENDENCY serialized-lambda strings | **4 literal occurrences in3classes** | AutoUpdateTagHandler ProjectStage; JPALazyDataModel.Builder EntityManagerFactory (unused model); PrimeApplicationContext Validator/ValidatorFactory. javap identifies old-signature string comparisons in `$deserializeLambda$`, **not legacy API type links**. This is potential deserialization failure, **not harmless debug metadata**; record runtime serialization/passivation risk, do not patch vendor binary or claim equivalence. |
| MISSED JAKARTA MIGRATION / UNKNOWN | **0 / 0** | Full nested dependency scan persisted in `mig08-namespace-evidence.json`; jdeps shows no javaxEE type links. |

Thus final dependency contains60raw javax token occurrences, all classified. The Jakarta artifact is genuine, not a legacy classifier despite residual strings. Build/static compatibility passes with **known upstream runtime risk**. Actual relevant serialization paths need QA/owner disposition; no source-level incompatibility was hidden.

**Deployment guard validation:** With EAP_IMAGE removed from child environment, `docker compose config --quiet` deliberately rejects with explicit required-image message. With `example.invalid/provisioned-eap81-java21:validation-only`, config syntax **PASS**; placeholder never pulled/built/started and not a candidate image. No runtime credential retry or unapproved image substitution.

#### Historical comparison and dispositions

Historical commit **f2811fc** changed build/APIs/imports/descriptors/XHTML/image strings and cosmetic labels. Its result is supporting evidence, not authority.

| Historical item | Classification | Current disposition |
|---|---|---|
| PF15Jakarta/EE10/12imports/web6/CDI4/Faces namespaces | REQUIRED NOW | Applied in ordered gates. |
| Java21 settings | REQUIRED NOW | Applied via toolchain/release21, no unsupported Gradle daemon assumption. |
| UploadedFile relocation/repeat/editor/table/dialog controls | ALREADY PRESENT | Revalidated prior work. |
| Historical growl removal/cosmetic page-text updates | HISTORICAL ONLY | Preserve current UX/sample content. |
| Bare runtime image plus /opt/eap WAR copy | NO LONGER REQUIRED | Public docs prove server absent/wrong path; user-approved guard/defer instead. |
| Missing validator/dragDrop/theme rename/resource gates | CURRENT MIGRATION MISSING CHANGE (detected/resolved) | Current D/E remedies all used breaks. |
| Blanket javax replacement/wrapper/calendar/growl/vendor-namespace rewrites | NO LONGER REQUIRED | No exact evidence requiring them; no speculative replay. |

**Inherited risks:** Every original13interaction and every MIG-03 through MIG-07/additional runtime list preserved verbatim as historical QA obligations, with current replacements cross-referenced by new checks. Baseline reconstruction not proven private6.2.30 equivalent; no behavioral suite, no runtime, HIGH inherited visual risk and modern-browser matrix still outstanding.

**New risks:** Real EAP8.1/Faces4/CDI4/Servlet6/Java21 integration/provisioning; attached native file validation/error feedback; Saga Blue resource serving and paginator/progress DOM/CSS; four upstream lambda signature strings. Five MIG-08 runtime check groups added. No finding fully closed without its required runtime/target acceptance; ATX-FIND-001..012/014 partially addressed/revalidated, ATX-FIND-013 remains. Artifact/build blockers statically resolved; environment/image/QA gates remain.

**Files changed in MIG-08 (33):** build/catalog/settings; five view beans; six XHTML pages/template; web.xml/beans.xml (jboss-web unchanged); Dockerfile/Compose; README/libs README; static validator; MIG-08 recipe; migration state/log/runbook/theme gates; current Jakarta/EAP/matrix/plan assessment addenda; agent/instructions/prompt. Exact paths recorded in migration state. Pre-existing MIG-07 edits preserved.

**Sources:** [PF15 major migration guide,15.0.0 release](https://github.com/primefaces/primefaces/blob/15.0.0/docs/migrationguide/15_0_0.md), exact Maven Central15.0.16Jakarta binary and matching unclassified source JAR (source remains javax before upstream transformation); [EAP8.1 supported standards](https://access.redhat.com/articles/113373); [Red Hat runtime/server provisioning procedure](https://docs.redhat.com/en/documentation/red_hat_jboss_enterprise_application_platform/8.1/html-single/using_jboss_eap_on_openshift_container_platform/index#proc_provisioning-the-jboss-eap-server-with-default-configuration_deploying-a-third-party-application-on-openshift); [vendor jboss-web7.2 schema](https://www.jboss.org/schema/jbossweb/jboss-web_7_2.xsd). Maintenance tag15.0.16 guide URL returned404, so use major guide plus exact binary/source evidence, not fabricated maintenance documentation.

**Persistent phase artifacts:** Final `mig08-conditional.patch`, `mig08-pf15016-jakarta.war`, per-gate logs/checkpoint patches/WARs and namespace evidence retained in session folder. Disposable download JARs removed after validation; normal Gradle cache retained.

**Stop: MIG-08 COMPLETE — CONDITIONAL.** Next approved phase **MIG-09 — Final acceptance**, including separately authorized runtime prerequisites. **MIG-09 has NOT started.**

### MIG-09 — Final acceptance attempt

**Status: BLOCKED — RUNTIME ACCEPTANCE BLOCKED — INFRASTRUCTURE PREREQUISITE.**

**Final migration decision: TECHNICALLY MIGRATED — RUNTIME ACCEPTANCE INCOMPLETE.** This report records a completed acceptance investigation/report, not completed runtime acceptance or a release waiver. User authorized MIG-09 only, including provisioning if an approved EAP8.1 environment is available; none is configured here. No broad modernization, source/configuration change or downstream phase.

**Preflight:** Read migration state/log/runbook/theme-browser gates, EAP analysis, approved plan/findings, MIG-08A-F evidence/namespace inventory/checkpoints; confirmed MIG-08 COMPLETED_CONDITIONAL. Verified B-E checkpoint hashes, final MIG-08 patch/WAR and all build logs (including A's2failures and B-F passes). All historical validation records, original13runtime checks and MIG-03–08additional deferred lists remain preserved, not reclassified as passed. Traceability **ATX-FIND-001 through014**; none closed by this attempt.

**Checkpoint:** base `b254429990b48e414914769217a3fd94daeb46ed` plus `pre-mig09.patch` SHA-256 `f5909d4893acc8846d0a273fa7236b1ee0e557b8b1161457d242c4c7958d4051`, exact `pre-mig09-state.json`. Contains existing MIG-07/08 work, which was not overwritten. Prior final `mig08-pf15016-jakarta.war` retained (SHA `ab5d534c6f94edc2d5402f96863c4274f9a1ae710afd4ba48d69b1beaec1d198`). No commit created. Artifacts directory `/Users/amineabri/.copilot/session-state/b576bbf4-7254-42d8-992a-9e42c392510e/files/`.

| Sub-gate | Observed result / evidence |
|---|---|
| MIG-09A Runtime prerequisites | ASSESSED. Docker29.9.2/linux-arm64 and Compose5.6.1 available, EAP_IMAGE/EAP_HOME/JBOSS_HOME unset, no cached EAP image or approved target endpoint. Official product/image/registry/channel/layers/config/ports/logging prerequisites and AVAILABLE/MISSING/MANUAL ACTION REQUIRED/BLOCKED EXTERNALLY classifications in final-acceptance.md. Registry access/entitlement UNKNOWN, not retried. No credentials read/fabricated/logged. |
| MIG-09B Provisioning | BLOCKED. No approved EAP8.1 product/image/access. Official runtime image has no server; documented builder assembly/channel-managed default layers required. No install/pull/provision/start or alternate runtime. Actual EAP/JDK/Mojarra/Weld/layers/config unobserved, documented targets only. |
| MIG-09C Deployment | NOT TESTABLE, not attempted. No server startup/deployment log or application defect observed. Errors/warnings NOT CAPTURED, not zero. Root cause ENVIRONMENT ISSUE/EXTERNAL DEPENDENCY ISSUE. |
| MIG-09D Functional | NOT TESTABLE for each page/startup/dialog/AJAX/upload/editor/table/sort/filter/page/expand/calendar/autocomplete/CSV/messages/poll/repeat/navigation check. No manually validated app interaction. |
| MIG-09E SearchExpression/Faces4 | NOT TESTABLE. Existing13updates and explicit process=@this statically retained; no explicit @form used. Actual ID resolution/partial responses/lifecycle unexercised; no production expressions added for testing. |
| MIG-09F Upload | NOT TESTABLE. Same regex/1MiB validator/1MiB-file2MiB-request multipart limits declared. Boundary/client-bypass/listener/metadata/success/error scenarios documented, not performed. |
| MIG-09G Theme/visual | NOT TESTED. Saga Blue explicit/core resource static PASS, HIGH potential CSS risk remains; no baseline/target screenshot or actual resource request evidence. No redesign/remediation without observed defect. |
| MIG-09H Browsers | Chromium/Firefox/Safari NOT TESTABLE without target. Safari executable present; Chrome/Chromium/Firefox not in standard app paths checked (alternate/remote tooling unknown). No JS/network/CSS/keyboard/motion check executed. IE decision unchanged. |
| MIG-09I Serialized lambda | Exact packaged binary ownership traced using javap. Overall REQUIRES MANUAL REVIEW; visible app graph LOW/MEDIUM-confidence, no direct app supplier/JPA model serialization, UploadedFile transient. AutoUpdate handler owns Lazy; serializable listener has ValueExpression/String, not handler. PrimeApplicationContext held in application/ServletContext map, not Serializable/session. JPA builder NOT APPLICABLE. Runtime state-saving/passivation/HA/rolling-update unknown. REQUIRES SESSION INVALIDATION for old cross-platform state; cold cutover does not prove same-version serialization safe. Vendor internals unchanged. |
| MIG-09J Coverage | Zero automated behavioral tests; independent test NO-SOURCE. No manual app behavior. Recommended separately authorized minimum future target-runtime/browser/feature/state suite documented, no test suite installed/added. |
| MIG-09K Matrix | Created docs/modernization/migration/final-acceptance.md, required Area/Status/Evidence/Residual Risk/Action columns plus full prerequisites/scenarios/findings. |
| MIG-09L Report | Created docs/modernization/transformation-report.md with baseline caveat, MIG-00–09 ledger, versions/theme/browser decisions, all acceptance gaps/manual actions, rollback and production-readiness decision. |

**Commands and available checks:** `./gradlew clean build --console=plain` PASS (`mig09-build.log`); independent `./gradlew test --console=plain` command SUCCESS/test NO-SOURCE (`mig09-test.log`); existing Jakarta validator PASS static/WAR (`mig09-static.log`); `./gradlew --version` confirms JVM11.0.30/Gradle8.4 (`mig09-gradle-version.log`). No source/test/dependency/config changes. `docker compose config --quiet` deliberately rejects absent EAP_IMAGE, PASS guard, evidence `mig09-environment-evidence.json`. No synthetic config pass was mislabeled as deployment.

**WAR:** `build/libs/primefaces-homeoffice.war`,4,143,832bytes, SHA-256 **`8668787e9348c04f051d37f195ed2c1ba142427c339b6cb73c4f995b9ae4d400`**. Every uncompressed entry byte-identical to MIG-08; outer ZIP timestamp checksum change only.11major65classes, sole15.0.16Jakarta binary SHA `b78ca75ff08d9a9c776b397f3d45caf84fa9736048b510ae350819cb6721425f`, no platform API/implementation JARs. App javax0; vendor60literals all classified (24JavaSE,32Maven metadata,4serialized-lambda signatures). Static125PFoccurrences/44tags/293attrs/unsupported0.

**Preserved evidence:** final candidate `mig09-pf15016-jakarta.war`, `mig09-acceptance.patch`, build/test/static/environment/version logs and `mig09-{AutoUpdateTagHandler,AutoUpdateListener,PrimeApplicationContext,JPALazyDataModel-Builder,Lazy}-javap.log`. Temporary extracted inspection JAR removed after review; no shared Gradle cache modified. Session artifacts must be promoted to controlled release storage before deployment.

**Files changed (7):** README.md; docs/modernization/migration/final-acceptance.md; migration-runbook.md; migration-state.json; theme-browser-gates.md; transformation-log.md; docs/modernization/transformation-report.md. Only documentation/state, prior work preserved.

**Risks/findings:** All prior risks open; no production-risk acceptance inferred. ATX-FIND-003/014 static validation requirements met for current build, but historical unresolved list retained until final sign-off. ATX-FIND-001/002 build verified/runtime missing;004/005CDI/schema runtime missing;006staged conditional/behavior missing;007upload runtime missing;008/009supported controls retained/behavior missing;010HIGHvisual/component risk;011/012runtime/platform blocked;013coverage absent. New detail is unknown actual state policy/HA and operational rollback, not a fabricated app defect.

**Manual unblocking/rollback:** Owner supplies supported EAP8.1product or approved provisioned immutable Java21image, secure registry/management access and intended architecture. Start empty server first, record versions/modules/config/logging and deploy root candidate; execute D-I and capture actual browser matrix evidence. Drain/invalidate only this application's old sessions/views/store at platform cutover, with user notification; inspect/passivation/failover current version if enabled. Retain prior compatible image+WAR and rehearse isolated rollback. Base+patch/WAR preservation is PARTIAL rollback readiness, not a tested runtime recovery. Never restore wrong-family WAR or old serialized state onto the new server.

**Stop: MIG-09 FINAL ACCEPTANCE recorded, runtime acceptance BLOCKED. TECHNICALLY MIGRATED — RUNTIME ACCEPTANCE INCOMPLETE.** No production release approval or further modernization work.

### MIG-09 — Resume attempt: runtime reference/access gate (2026-10-27)

**Status unchanged: TECHNICALLY MIGRATED — RUNTIME ACCEPTANCE INCOMPLETE.** Runtime acceptance BLOCKED; no acceptance result promoted. Read state/log/final acceptance/report/runbook; preserved all original evidence/checkpoints and prior unresolved risks.

Availability recheck: EAP_IMAGE/EAP_HOME/JBOSS_HOME unset, no cached EAP image or running Docker container. Docker available29.9.2/linux-arm64. Current WAR SHA remains `8668787e9348c04f051d37f195ed2c1ba142427c339b6cb73c4f995b9ae4d400`; no rebuild.

User selected provisioned-container route and supplied `registry.redhat.io/jboss-eap-8/eap81-openjdk21-runtime-openshift-rhel9`. Identified runtime-only base, not a verified provisioned server; no explicit tag/digest. `docker manifest inspect` at `2026-10-27T19:43:57.097463+00:00` requested implicit latest and returned **unauthorized**, with Red Hat registry login instructions. Classified **INFRASTRUCTURE ISSUE / EXTERNAL DEPENDENCY ISSUE**, not an application failure. No login/secret access/pull/start/deploy, no compatibility inferred from image name, no fallback server.

User selected **“I will configure secure registry access and provide an approved provisioned image reference.”** Paused awaiting secure access and actual provisioned-image identity. Exact EAP/JDK/Mojarra/CDI/Servlet/layers/config/session topology cannot yet be recorded. All functional/SearchExpression/upload/visual/browser gates remain NOT TESTABLE/NOT TESTED; serialized state REQUIRES MANUAL REVIEW with cross-version session invalidation requirement; rollback PARTIAL/unrehearsed.

Evidence: `mig09-resume-runtime-reference-evidence.json`; pre-resume state `pre-mig09-resume-state.json` in existing session artifacts directory. Prior `mig09-acceptance.patch` SHA `2ff15ce1797a8ffcfbc7838097af2179d893046032a63a23fa4d9107102dd0d1`, prior WAR/checkpoints unchanged. Updated only state, final acceptance, transformation report and this log with additive resume evidence; no production/configuration changes, no commit.

### MIG-09 — Provisional WildFly runtime acceptance (2026-10-27)

**PROVISIONAL RUNTIME VALIDATION COMPLETE. Final migration status: TECHNICALLY MIGRATED — EAP RUNTIME ACCEPTANCE INCOMPLETE. EAP8.1 validation STILL REQUIRED.** User explicitly authorized upstream runtime checks because Red Hat registry entitlement/access is unavailable; production target unchanged. Prior official EAP results/checkpoints/deferred lists preserved, no later modernization phase started.

**Environment:** official WildFly35.0.1.Final-jdk21 image pinned `quay.io/wildfly/wildfly@sha256:850129d5aa9564a080f9737eb18697171cecd452a33578f7ee4066a0611b71c0`, linux/arm64, container `mig09-provisional-wf35` / `9b3db443081d537af094a9530dfc2a39b1097fad821e612109eacaac3a7144b5`. Actual banner/module logs: Core27.0.1.Final, Temurin21.0.6+7, EE10 family, Mojarra4.0.8, Weld5.1.4.Final/CDI4.0.1, Servlet6.0.0/Undertow2.3.18.Final, PF15.0.16Jakarta. Stock full standalone/base module layer, no custom Galleon/server module/DB/security workaround. Empty server passed before initial WAR; loopback-only ephemeral HTTP, management private. Default transaction-node/self-signed-keystore warnings retained.

**Checkpoint:** `pre-mig09-provisional-state.json`, `pre-mig09-provisional-remediation.patch`; earlier `mig09-pf15016-jakarta.war` and hashes unchanged. Initial candidate deployed successfully, then interactions revealed real defects; original logs/failed test attempts preserved.

**Acceptance fixes:** PF in-place sorting requires mutable stable lists. Session Elements list corrected; user explicitly approved ViewScoped EmployeeBean/mutable view-owned list rather than shared mutable application data. Missing employee Faces form added. Hidden export table switched four raw text EL instructions to h:outputText values. PF15 validation metadata enabled using primefaces.CLIENT_SIDE_VALIDATION, unchanged allowTypes/size/native caps. Remaining app legacy icons switched to PrimeIcons; custom stylesheet last, top-icon inversion/contrast corrected. Seven source/config/CSS files only; no dependency/runtime-target/DB/upstream changes.

**Classification:** table/export/validation/icon compatibility = APPLICATION MIGRATION ISSUE; missing form = PORTABLE JAKARTA EE ISSUE, original provenance unknown; no app-specific WILDFLY-SPECIFIC ISSUE/workaround. EAP VALIDATION STILL REQUIRED. A discarded getter-copy model fix lost sort order and was not retained. Invalid temporary paginator rows2 was rejected correctly by PF; final tests use real Employees5+3rows. Early role/transition/key-event/WebKit-buffer automation mistakes and stale restart port were corrected only in the external harness.

**Final candidate:** `build/libs/primefaces-homeoffice.war`,4,143,924bytes, SHA256 **`e03949114666f2abce73dd9c3f6c3aca933f1db1c1190b1c779c6196304fb5a0`**, preserved `mig09-provisional-validated.war`. `./gradlew build --console=plain` PASS/test NO-SOURCE; existing Jakarta validator PASS (`mig09-provisional-final-{build,static}.log`). Root scanner deployment, descriptors/Faces/CDI/PF/resources/restart PASS upstream only, no observed linkage/classloading/module/bootstrap error or rollback.

**Behavior:**54/54 grouped checks PASS,18each Chromium156.0.8078.4/Firefox157.0/WebKit27.2; final page/console/HTTP/Faces-error totals0. Actual model/lifecycle/DOM/download checks include pages/nav, @this/@form/IDs/process/update, invalid-required Reset, dialogs/confirmation, table sorting/filter/clear/paging/expansion, date/autocomplete/editor persistence, upload/listener/metadata/success/errors, CSV exact tuples, growl/poll/progress/repeat. Supplemental txt/csv/pdf and1MiB boundary checks, server validateFile rejection after client-metadata bypass, distinct employee views in same session, disposable restart losing old session model all pass. UploadedFile stream bytes unconsumed; request-cap/other edge cases remain partial. No large/maintained test suite created: repository behavioral tests still0, isolated session harness only.

**Visual/browser:** MINOR MIGRATION DIFFERENCES, not product visual sign-off. Actual Saga Blue/PrimeIcons and five-page desktop plus Elements1440/900/390captures; representative desktop/mobile/dialog/table views inspected. Remaining inherited styling, generous spacing, narrow table/calendar wrapping and fixed modal mobile gaps recorded. No original Omega runtime baseline; WebKit is not Safari certification. Keyboard dialog/reduced-motion media interaction passes, not full accessibility or motion-suppression proof; approved stable browser/OS matrix pending. IE decision unchanged.

**State/rollback:** LOW/MEDIUM-confidence for observed non-distributable, nonpersistent standalone config; no cluster transport, available passivation cache not proof app uses it. Same browser cookie after restart returns initial model. EAP topology/HA/passivation MANUAL REVIEW; four upstream lambda strings unchanged. Application-scoped old sessions/views/stores MUST be invalidated at cross-version cutover/rollback. Operational EAP rollback remains PARTIAL/unrehearsed without prior compatible immutable runtime; no DB impact.

**Records/evidence:** updated final-acceptance.md, transformation-report.md, migration-state.json and this log additively; synchronized README/runbook/theme-browser current-status pointers while preserving historical entries. Full evidence under existing session files: runtime identity, startup/deployment/final logs, modules/config/session records, browser results/AJAX/CSV/DOM/screenshots, supplemental results, final WAR, hash manifest and new `mig09-provisional-acceptance.patch`. Owned container stopped after evidence capture; shared resources untouched. Local files must be promoted to controlled release storage. No commit created; no finding silently closed or production risk accepted.

**Stop: EAP8.1 acceptance remains externally blocked. TECHNICALLY MIGRATED — EAP RUNTIME ACCEPTANCE INCOMPLETE.**

### MIG-09 — Actual pinned EAP8.1 target acceptance, operational gates incomplete

**Date:** 2026-10-27. **Checkpoint:** HEAD `de1def5`, clean worktree before this run; `pre-mig09-eap-pinned-state.json` preserves prior state. Related findings ATX-FIND-001 through014 remain traceable, none silently closed.

**Authority:** user supplied exact entitled immutable Red Hat builder/runtime images. Both manifest resolutions/pulls PASS. Actual Dockerfile was the earlier guarded single-stage form; after discrepancy was reported, user explicitly authorized adding missing multistage provisioning. No broad modernization, app behavior or source changes.

**Files:** Dockerfile pinned builder/runtime, existing EAP8.1 channel/cloud-default-config assembly, `/opt/server` copy/ROOT.war/platform/UID185; Compose removes obsolete EAP_IMAGE input. Four final acceptance records updated additively; README/runbook/theme-browser current pointers synchronized. Historical blocked/WildFly entries, patches and checkpoints retained.

**Exact bases:**

- `registry.redhat.io/jboss-eap-8/eap81-openjdk21-builder-openshift-rhel9@sha256:40f2d11ef2b181330eadb04fc1b89925b91921612f39f72fee475c55a53e06d6`
- `registry.redhat.io/jboss-eap-8/eap81-openjdk21-runtime-openshift-rhel9@sha256:6a3590ad17625af2bffd64d4cd6828da15c56102fcc57fa5c7be9bd4dc662845`

**Build:** `docker build --platform linux/amd64 --progress plain -t primefaces-homeoffice:mig09-eap81-acceptance .` PASS; image/index `sha256:5c651567391eac85c3bbf185257597768c7ff505e40d120df742e781bd9a43c2`. Galleon EAP8.1 channel resolved manifest1.8.0.GA-redhat-00006, EE pack8.1.1.GA-redhat-00048/cloud pack2.0.0.Final-redhat-00040. Base pins do not freeze channel resolution; exact installation streams/manifests and candidate image archive retained. Provisioning cookie warnings did not prevent successful resolution/assembly.

**Artifact:** no WAR rebuild;4,143,924bytes/SHA256 `e03949114666f2abce73dd9c3f6c3aca933f1db1c1190b1c779c6196304fb5a0`, identical to previously WildFly-validated WAR and actual ROOT.war.

**Runtime/deployment:** repeated fresh-instance PASS, actual **JBoss EAP8.1 Update8.0/Core27.1.15.Final-redhat-00001**, Red Hat **OpenJDK21.0.12.1+1-LTS** (Red_Hat-21.0.12.1.1-1). EE10/Mojarra4.0.11.SP1-redhat-00001/Weld5.1.6.Final-redhat-00001/CDI4.0.1.redhat-00001/Servlet6.0.0.redhat-00007/Undertow2.3.26.SP3-redhat-00001 verified via installed modules/product/Java/logs. ROOT/context/CDI/Faces/PF15.0.16/descriptors PASS; no observed application namespace/module conflicts or rollback. Existing amd64 emulation retained, not native production/OpenShift/HA certification.

**Identical baseline replay:** original54-check browser script byte-identical; EAP endpoint input only. EAP **54/54** versus WildFly35.0.1.Final **54/54**, no check-status differences; Chromium156.0.8078.4/Firefox157.0/WebKit27.2 each18PASS, page/console/HTTP/Faces-partial-response errors0. Same pages/navigation/form/AJAX/SearchExpressions/this/form/IDs/process/update/row expansion/upload/validation/editor/tables/sort/filter/page/date/autocomplete/CSV/dialogs/messages/poll/progress/repeat/keyboard/resource/viewport assertions. Zero maintained repository behavioral tests; external executed instrumentation only.

**Supplemental:** txt/csv/pdf/boundary upload and server validateFile metadata-bypass rejection PASS; separate employee views in one session PASS. Fresh immutable-container replacement PASS with same image and old cookie/model not restored. Uploaded stream contents unconsumed by listener and not byte-compared.

**Actual operational failure:** same-container restart FAIL — **EAP CONFIGURATION ISSUE**. Cloud CLI attempts to configure existing `kubernetes.KUBE_PING`, aborting boot. Original failure retained, not rewritten as fresh-replacement success. Supported `CONFIG_IS_FINAL=true` diagnostic on a fresh instance also failed because required initial discovery setup was skipped;31services failed/missing. Diagnostic rejected, no flag or launcher bypass committed. Production idempotent/finalized configuration and restart/upgrade rehearsal remain operator/vendor work. Missing local Kube namespace/API/CA caused discovery/insecure-trust warnings; auth/encryption/TLS/keystore and real production cloud settings not accepted.

**Visual/browser:** Saga Blue **MINOR DIFFERENCES**, existing layout/icons/forms/tables/editor/upload/messages/dialog/responsive resources and representative screenshots checked; no confirmed new EAP visual regression. Original Omega baseline, mobile wrapping/modal, full accessibility, stable browser/OS support-policy limits retained. Safari product NOT TESTED; WebKit is not Safari. IE decision unchanged.

**Session/cutover:** actual EAP cloud web distributed cache sessions owners2/no store, legacy passivation file store and connected one-member JGroups ee/tcp/KUBE_PING observed. App is not distributable; no Undertow persistent-sessions configured,30minute timeout. Available services do not establish app replication/passivation/failover. **INVALIDATE ALL EXISTING SESSIONS / VIEWS for this application** at cutover and rollback: drain/stop old nodes, prevent app-scoped state restoration, start fresh, require new GET; no mixed-version state-preserving rolling migration. Four upstream lambda strings unchanged; LOW observed-topology risk/MEDIUM confidence, not serialization proof.

**Rollback:** PARTIAL. Pre-MIG08 PF14/Java11/JavaEE WAR SHA256 `5dc023c5faf09463f9b71055329314b3b88146bbb06e8f64777293670d388863`/checkpoints and current WAR/image/manifests retained. Matching prior EAP7 image/config and rollback rehearsal absent. Restore exact compatible image/WAR/config pair via fresh containers and app-state invalidation, verify server/deployment/critical paths before traffic; no cross-family WAR swap or moving-channel rebuild. No DB/schema impact.

**Evidence/disposal:** isolated `files/mig09-eap-pinned/` holds both base identities, build/runtime/product/module/Galleon/installation/session/health logs/config, deployed WAR, identical browser harness/results/screenshots/DOM/CSV/AJAX, original restart failure, rejected diagnostic, replacement results, `provisioned-image.tar` and evidence manifest. Adjacent `mig09-eap-pinned-build.log`, pre-state and new `mig09-eap-pinned-acceptance.patch`; old artifacts untouched. Owned containers stopped after capture, no shared resources removed. Promote local records/image to controlled release storage. No assistant commit created.

**Outcome:** actual EAP deployment/application acceptance PASS; operational gates INCOMPLETE. **TECHNICALLY MIGRATED — EAP RUNTIME ACCEPTANCE INCOMPLETE**, no production approval or implicit risk waiver. Stop after MIG-09.

## Entry template

For each executed stage, append a new entry:

```text
### MIG-XX — <stage name>

Related findings:
- ATX-FIND-XXX

Checkpoint:
- <pre-stage commit hash or recorded baseline reference>

Files changed:
- <repository-relative paths>

Reason:
- <assessment-backed reason for each change>

Validation:
- Build: <command, result, relevant output/log path>
- Tests: <command, result; state if no automated tests exist>
- Manual/deployment gates: <checks and evidence>

Outcome:
- COMPLETE | BLOCKED | FAILED
- Findings resolved: <IDs and validation evidence>
- Findings remaining: <IDs>
- Follow-up/blockers: <details>
```

Append subsequent stage entries only after the stage is explicitly authorized, its prerequisites pass, and its actual validation results are known.
