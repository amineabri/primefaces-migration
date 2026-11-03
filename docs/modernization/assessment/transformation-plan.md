# AWS Transform-Style Transformation Plan

**Plan status:** Proposed; assessment only. Do not execute migration until readiness prerequisites are met.

**Execution-planning addendum:** MIG-00 through MIG-03 were subsequently executed conditionally; consult migration state/log, not this historical status, for observed outcomes. Theme/browser governance below is a mandatory refinement of ATX-FIND-006/010/013/014. It does not authorize MIG-04 or modify original AWS reports.

**MIG-04 outcome addendum:** PF11 is now conditionally built/packaged. The user explicitly approved Saga replacement with existing custom CSS and deferred visuals; `primefaces.THEME=saga` is configured and the exact PF11 WAR supplies it. Omega's overdue MIG-03 static prerequisite is resolved; historical deployment provenance and visual equivalence remain unknown. The planned concrete theme is Saga through PF14, then `saga-blue` subject to exact PF15 verification. Earlier UNDECIDED/pre-MIG-04 prerequisite text below is retained as planning history, not a current blocker. PF11 required a row key for actual row expansion and changed the dialog responsive default; both are addressed. MIG-05 is NOT started or authorized.

## Theme Migration and Browser Support Workstreams

**MIG-08 current execution/scope addendum (supersedes earlier runtime execution assumptions):** User authorized ordered A-F Jakarta build/static sub-gates and explicitly chose the plan's Java21 build target with deployment guarded pending a provisioned EAP8.1 image. Those gates are conditionally complete: PF15.0.16Jakarta/EE10/Faces4,12imports,web6/CDI4/Faces namespaces, upload validator/dragDrop and explicit saga-blue verified. Gradle8.4 runs JDK11 with installed JDK21 compiler, no wrapper update required. EAP8.1 runtime-only image has no server; image provisioning/assembly is logically separate and deferred, not a bare-image string replacement. All inherited risks and HIGH visuals preserved; four upstream serialized-lambda signature residues classified as runtime risk, not app migration omissions. Next existing phase **MIG-09 final acceptance** includes separately authorized runtime prerequisites; no new numbered EAP phase is invented and MIG-09 has NOT started.

**MIG-07 current execution addendum:** MIG-00 through MIG-07 are conditionally complete; earlier phase-not-started statements are historical. PF14 requires Java11 and Faces2.3+: source/target/release11 and the configured same EAP7.3.10 OpenJDK11/RHEL8 image are now aligned. Actual Java11 deployment and JSF module/slot remain unverified; stock EAP7.3 documents Mojarra2.3. Saga remains explicit/bundled, static gate PASS, HIGH inherited visual risk DEFERRED. No application Java/XHTML changes: growl/calendar and legacy upload validation settings remain supported. Preserve accepted MIG-06 IE decision, all runtime checks and added SearchExpression/localisation/reduced-motion gates. This corrects the old Java8-through-PF14 plan; Java21/EAP8.1/Jakarta remain exclusively MIG-08, which has NOT started or been authorized.

Read `../migration/theme-browser-gates.md` for the evidence inventory, rule-level CSS analysis, per-version matrix, IE decision boundary and mandatory report fields. These workstreams are prerequisites/gates, not generic residual risks.

**Theme path:** OMEGA CURRENT STATE -> exact compatibility across PF versions -> EXPLICIT REPLACEMENT PHASE -> concrete supported modern theme -> custom CSS/icon remediation -> runtime visual validation.

User-declared current theme is Omega. It was bundled in legacy PF6.2/PF8; PF10 no longer bundles it. Source/packaged application has no explicit theme parameter or separate Omega artifact. The required replacement boundary is therefore MIG-03/PF8-to-10, already reached: resolve the missed theme gate **before MIG-04** under explicit authorization. Do not assume that PF10's framework default proves Saga is the application's current visual baseline. Reconcile runtime provenance; implicit fallback is UNCONTROLLED VISUAL CHANGE. PrimeOne is the target design system, not a theme name; concrete replacement is UNDECIDED pending supported-resource evidence and owner visual approval.

**Browser path:** CURRENT BROWSER SUPPORT -> release-specific framework policy -> IE SUPPORT REMOVAL GATE -> IE-specific code review/product decision -> approved modern-browser validation.

No application IE-only logic/workarounds were found, but business IE requirements remain UNKNOWN. Explicitly gate MIG-06/PF12-to-13 on the documented IE-support boundary and product decision. If IE is required or requirements remain unknown, stop for MANUAL PRODUCT DECISION REQUIRED; do not silently drop users or retrofit unsupported compatibility.

| Phase | Added mandatory work |
|---|---|
| Before MIG-04 | Reconcile Omega source/configuration; approve and explicitly implement concrete replacement at the overdue MIG-03 boundary; classify CSS/icon impact. No upgrade authorization implied. |
| MIG-04 PF11 | Recheck selected theme/resources/defaults, DOM/CSS and browser policy. |
| MIG-05 PF12 | Recheck theme/custom CSS and browser transition; establish IE/product requirement before removal. |
| MIG-06 PF13 | Theme revalidation plus mandatory IE-removal/product decision and per-workaround dispositions. |
| MIG-07 PF14 | Post-IE browser policy/validation and theme/DOM compatibility. |
| MIG-08 PF15 Jakarta | Default becomes `saga-blue`; `saga`/`arya`/`vela` become `-blue` names, other themes move to `primefaces-themes`. Verify exact target artifacts and Jakarta resource serving; Omega must be dispositioned, not unresolved. |
| MIG-09 | Full approved-browser visual acceptance; no unresolved mandatory visual/runtime deferral. |

For each phase keep STATIC THEME COMPATIBILITY separate from RUNTIME VISUAL VALIDATION. No runtime means DEFERRED, never visual equivalence; conditional completion needs explicit stage acceptance. Reassess effort after concrete theme choice and browser requirements: previous aggregate estimates did not price this newly explicit workstream; do not invent an additive estimate without scope/evidence.

## Plan Controls

- Execute the repository's matching migration definition for one stage at a time.
- Before each execution, review its stage assessment and confirm the current worktree/build baseline.
- Build and complete the listed QA gate before the next stage.
- Preserve the Gradle WAR model, existing pages/sample behavior, root context `/`, and no-database/no-authentication scope.
- Record transformation diff, command output, QA evidence, and rollback point per stage.
- The project dependency graph is a single WAR with a versioned PrimeFaces dependency; therefore PrimeFaces upgrades precede the final Java EE/Jakarta runtime cutover.
- Do not use the aggregate `staged-run` command if it bypasses inter-stage QA.

## Stage Plan

| Stage | Objective | Prerequisite | Project | Files/components | Findings |
|---|---|---|---|---|---|
| 0. Baseline | Establish reproducible current build, artifact source and behavior | JDK/current registry/dependency access | `primefaces-homeoffice` | Build, local JAR path, all five pages | F002, F013, F014 |
| 1. PF 6.2.30→7 | Upgrade PF with existing Java EE/EAP baseline | Stage 0 pass | Same | Catalog; table/date/menu/AJAX pages and CSS | F006, F010 |
| 2. PF 7→8 | Upgrade PF and resolve stage API changes | Stage 1 gate | Same | Catalog; Elements upload/date API/markup | F006, F007, F008, F010 |
| 3. PF 8→10 | Upgrade PF and review API/uploader behavior | Stage 2 gate | Same | Catalog, `web.xml` uploader setting, Elements, CSS | F006, F007, F010 |
| 4. PF 10→11 | Upgrade PF and verify rendered behavior | Stage 3 gate | Same | Catalog, date/table pages, CSS | F006, F010 |
| 5. PF 11→12 | Upgrade PF and verify export/upload/editor | Stage 4 gate | Same | Catalog, ElementsBean, Elements XHTML, CSS | F006, F010 |
| 6. PF 12→13 | Upgrade PF and verify upload/table/export | Stage 5 gate | Same | Catalog, ElementsBean, Elements XHTML | F006, F007, F010 |
| 7. PF 13→14 | Remove/replace only confirmed deprecated constructs | Stage 6 gate | Same | Catalog, `elements.xhtml`, employees tables, CSS | F006, F008, F009, F010 |
| 8. PF14→15 Jakarta + EE10/EAP8.1/Java21 | Move app to target platform and runtime | Stage 7 gate; image/artifact/Java21 access confirmed | Same | Catalog/build; all beans; three descriptors; Docker/Compose; Elements | F001-F007, F010-F014 |
| 9. Final acceptance | Verify built/deployed target and record evidence | Stage 8 build and target environment | Same | WAR/container and all application pages | F001-F014 as applicable |

## Stage Detail

### Stage 0 — Baseline and Prerequisite Assessment

- **Objective:** Prove current source/build/deployment baseline before any transformation.
- **Prerequisite:** Current JDK, Gradle distribution, dependency repositories, and local runtime where available.
- **Affected project:** `primefaces-homeoffice`.
- **Files/components:** `build.gradle`, version catalog, optional local PF JAR, Docker/Compose; all five pages, especially Elements.
- **Findings addressed:** F002, F013, F014.
- **Transformation:** No source change. Run baseline build and record artifacts. Inspect whether local JAR exists and compare artifact version/source. Record current behavior of all five pages.
- **Dependency changes:** None.
- **Expected source changes:** None.
- **Build command:** `./gradlew clean build`.
- **Validation:** Baseline WAR exists; page smoke test includes menus, tables, date, messages, upload, export, editor, AJAX and dialogs.
- **Completion criteria:** Build and smoke-test results recorded; target image access and artifact source plan known.
- **Rollback/checkpoint:** Tag/commit or preserve clean baseline revision and WAR; no changes made in this assessment.
- **Effort:** Included in aggregate estimates; detailed range in `effort-estimate.md`.
- **Risks:** Cannot establish reliable regression comparison if baseline environment is unavailable.

### Stages 1–7 — PrimeFaces-Only Version Transitions

The stage-specific `transformation_definition.md` under `aws-transform/eap-primefaces-modernization/migration/` is the operation specification. Update the version catalog and only the component/API edits required by the actual target taglib; do not apply speculative changes merely because a prior report labels an API deprecated.

#### Stage 1: 6.2.30 → 7.0

- **Objective:** Move to PF 7 on existing Java EE 8/EAP 7.3/Java 8 baseline.
- **Prerequisite:** Baseline pass and PF 7 artifact resolution.
- **Files/components:** `gradle/libs.versions.toml`; table/date/menu/AJAX constructs in `employees.xhtml`, `elements.xhtml`, `dashboard.xhtml`, `reports.xhtml`, shared template; `app.css`.
- **Findings:** F006, F010.
- **Changes:** Version update; check actual sort/filter syntax and CSS changes.
- **Dependency change:** PF 7.0 artifact; Java EE dependency unchanged.
- **Build/test:** `./gradlew clean build`; five-page smoke; table sort/filter, date and AJAX checks.
- **Completion/rollback:** Passing build and gate; preserve PF6 source/artifact checkpoint.
- **Effort:** 3 h expected human stage effort, historical report; confidence medium.
- **Risk:** Theme and client-side behavior changes.

#### Stage 2: 7.0 → 8.0

- **Objective:** Upgrade PF and verify upload/date API usage.
- **Prerequisite:** Stage 1 gate.
- **Files/components:** version catalog; `ElementsBean.java`; `elements.xhtml` upload and date.
- **Findings:** F006-F008, F010.
- **Changes:** Apply exact PF8 API/tag changes identified by stage definition; verify file upload listener and date behavior.
- **Dependency change:** PF 8.0.
- **Build/test:** `./gradlew clean build`; upload, date, tables, exporter and editor.
- **Completion/rollback:** Build and gate pass; retain PF7 checkpoint.
- **Effort:** 3 h expected.
- **Risk:** API behavior assumptions in historical report require exact version confirmation.

#### Stage 3: 8.0 → 10.0.0

- **Objective:** Advance to PF10 and remove/adjust only confirmed obsolete settings/APIs.
- **Prerequisite:** Stage 2 gate.
- **Files/components:** version catalog; `web.xml` uploader parameter if unsupported; `ElementsBean.java`; `elements.xhtml`; CSS.
- **Findings:** F006, F007, F010.
- **Changes:** Apply PF10 migration instructions; validate upload methods, autocomplete, table and client resources.
- **Dependency change:** PF 10.0.0.
- **Build/test:** `./gradlew clean build`; upload, autocomplete, sort/filter, export, browser console and visual check.
- **Completion/rollback:** Gate passes; retain PF8 source and dependency checkpoint.
- **Effort:** 5 h expected.
- **Risk:** API/CSS regressions.

#### Stage 4: 10.0.0 → 11.0.0

- **Objective:** Upgrade PF11 with minimal project-specific edits.
- **Prerequisite:** Stage 3 gate.
- **Files/components:** catalog, tables/date, CSS.
- **Findings:** F006, F010.
- **Changes:** Version update and only verified changes for used attributes/client behavior.
- **Dependency change:** PF 11.0.0.
- **Build/test:** `./gradlew clean build`; all pages and date/tables/messages.
- **Completion/rollback:** Build and visual/behavior gate; retain PF10 checkpoint.
- **Effort:** 3 h expected.
- **Risk:** Low-medium; visual changes remain possible.

#### Stage 5: 11.0.0 → 12.0.0

- **Objective:** Upgrade PF12 and protect exporter/upload/editor behaviors.
- **Prerequisite:** Stage 4 gate.
- **Files/components:** catalog; `ElementsBean.java`; `elements.xhtml`; `app.css`.
- **Findings:** F006, F007, F010.
- **Changes:** Update version and resolve actual target API/tag differences.
- **Dependency change:** PF 12.0.0.
- **Build/test:** `./gradlew clean build`; download CSV, upload, submit editor, table filters, browser console/visual.
- **Completion/rollback:** Gate passes; retain PF11 checkpoint.
- **Effort:** 3 h expected.
- **Risk:** Client library/theme or feature behavior change.

#### Stage 6: 12.0.0 → 13.0.0

- **Objective:** Upgrade PF13 and validate file upload API.
- **Prerequisite:** Stage 5 gate.
- **Files/components:** catalog, Elements Java/XHTML, tables/export.
- **Findings:** F006, F007, F010.
- **Changes:** Version update and precise API/tag remediation based on PF13 artifact.
- **Dependency change:** PF 13.0.0.
- **Build/test:** `./gradlew clean build`; upload, export, table behavior and all-page smoke.
- **Completion/rollback:** Gate passes; retain PF12 checkpoint.
- **Effort:** 3 h expected.
- **Risk:** Upload/table/export regressions.

#### Stage 7: 13.0.0 → 14.0.0

- **Objective:** Upgrade PF14 and resolve confirmed deprecated widgets.
- **Prerequisite:** Stage 6 gate.
- **Files/components:** catalog; `elements.xhtml:18-22,55-57`; `employees.xhtml`; CSS.
- **Findings:** F006, F008-F010.
- **Changes:** Migrate calendar to date picker and growl pattern only if required; verify column attributes and CSS.
- **Dependency change:** PF 14.0.0.
- **Build/test:** `./gradlew clean build`; date format/AJAX, messages, table interactions and visual comparison.
- **Completion/rollback:** Gate passes; retain PF13 checkpoint.
- **Effort:** 6.5 h expected.
- **Risk:** Widget removal or visual regression.

### Stage 8 — PF15 Jakarta and EAP/Java Cutover

- **Objective:** Run Jakarta EE 10 application on EAP 8.1/Java 21 with PrimeFaces 15 Jakarta.
- **Prerequisite:** Stage 7 gate; approved image access/architecture; verified target PF and Jakarta coordinates; Java 21 build path available.
- **Files/components:** `build.gradle`; version catalog; all five beans; `web.xml`, `beans.xml`, `jboss-web.xml`; `Dockerfile`, Compose; `ElementsBean`/Elements UI; root context.
- **Findings:** F001-F007, F010-F014.
- **Exact transformation:** Set Java target/runtime 21; replace Java EE 8 provided API with EE 10 provided API; set PF 15.0.16 Jakarta artifact; convert known Java imports; convert Faces params/servlet and XML descriptors; update UploadedFile type; switch EAP image and Compose metadata while preserving WAR path, port and `/`.
- **Dependency changes:** `javax:javaee-api:8.0` → Jakarta EE 10 API; PF module to Jakarta classifier; target EAP image.
- **Expected source changes:** Five bean import sets, possible uploaded-file methods; targeted XHTML changes only as confirmed.
- **Build command:** `./gradlew clean build`.
- **Validation commands:** `bash .aws/atx/skills/eap-primefaces-modernization/scripts/validate-modernized.sh`; `docker compose config`; `docker compose build`; deploy/start target image and inspect logs. Container commands require target image access and are not run during assessment.
- **Completion criteria:** Java 21 build succeeds; no application EE `javax` leakage; target image deploys cleanly; CDI/Faces routes and full UI pass; root context and upload behavior preserved.
- **Rollback/checkpoint:** Preserve the passing PF14/EAP7.3 revision and artifact; rollback as a unit if target platform gate fails.
- **Effort:** 12 h expected (existing final-stage estimate); confidence low-medium.
- **Risks:** Registry entitlement, mutable image tag, API/descriptor mismatch, classloading, architecture, QA gaps.

### Stage 9 — Final Acceptance

- **Objective:** Confirm reproducible final target artifact and evidence.
- **Prerequisite:** Stage 8 passes.
- **Files/components:** Final WAR/container; five pages; descriptors; configuration.
- **Findings:** Verify all applicable IDs F001-F014 are closed or accepted with rationale.
- **Build/test:** Re-run target build and container validation; full manual regression.
- **Completion criteria:** QA sign-off, no startup errors, correct root route, immutable image reference recorded.
- **Rollback:** Retain prior stage artifact and deployment image until release acceptance.
- **Effort:** Included in project totals, not added separately.

## Plan-Wide Completion Criteria

All eight stage gates pass; WAR remains a single Gradle deliverable; EE APIs remain container-provided; Jakarta conversion is complete; target image architecture/access is confirmed; manual regression evidence exists. Findings addressed by stages must map to `findings.md` and `assessment.json`.
