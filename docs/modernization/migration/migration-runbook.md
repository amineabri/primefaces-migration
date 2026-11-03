# PrimeFaces / Jakarta / EAP Migration Runbook

**Repository:** `amineabri/primefaces-migration`  
**Project:** `primefaces-homeoffice` (one Gradle WAR)  
**Current status:** MIG-09 actual pinned **EAP8.1 Update8.0/Java21** fresh startup/deployment and **54/54** unchanged browser checks PASS, matching WildFly35.0.1.Final. **TECHNICALLY MIGRATED — EAP RUNTIME ACCEPTANCE INCOMPLETE**: same-container cloud reconfiguration fails on restart; fresh immutable replacement passes; rollback PARTIAL and production configuration unapproved. Saga Blue MINOR DIFFERENCES, repository behavioral tests0, Safari/visual limits retained. See the latest additive [final acceptance](final-acceptance.md) record. No phase beyond MIG-09 authorized.

**Historical initial MIG-09 status:** MIG-00 through MIG-08 conditionally complete. MIG-09 explicitly authorized and attempted; **BLOCKED — RUNTIME ACCEPTANCE BLOCKED — INFRASTRUCTURE PREREQUISITE**. Build/test command/static/WAR checks rerun; tests NONE, application behavior/visual/browser checks NOT TESTABLE/NOT TESTED. No approved provisioned EAP8.1 image/server/endpoint supplied. **TECHNICALLY MIGRATED — RUNTIME ACCEPTANCE INCOMPLETE**, not approved for production. See [final acceptance](final-acceptance.md) and [transformation report](../transformation-report.md). All prior risks and accepted IE decision preserved.
**Authority:** `docs/modernization/assessment/manifest.json`, `assessment.json`, and `transformation-plan.md`.

## Prerequisites

1. Obtain explicit user authorization to start migration.
2. Read migration state, assessment manifest/JSON, findings, transformation plan, and matching stage recipe/assessment.
3. Inspect `git status`; understand and preserve unrelated changes.
4. Establish and record baseline JDK/Gradle, `./gradlew clean build`, existing errors/warnings, `./gradlew test`, dependency source/local PF JAR status, and manual page baseline.
5. Confirm Maven/local artifact access for each stage.
6. MIG-08 build uses Gradle8.4 on JDK11 with installed Java21 compiler toolchain. Before runtime work/acceptance, approve provisioned EAP8.1 Java21 image identity/digest/access/architecture, `/opt/server` layout, UID185/permissions/entrypoint/port/scanner and QA availability. Bare runtime image has no server.
7. Make a recoverable Git checkpoint before each stage. Do not commit unless requested.
8. Read `theme-browser-gates.md`, including the execution addendum. Omega is the previous user-declared baseline; Saga is now explicitly approved/configured, not assumed from the framework default. Inspect exact version resources and browser policy before every remaining phase.

## Approved migration order

The assessment plan begins from current PF 6.2.30, so MIG-01 PF6.2.30→7 is required before the requested sequence's PF7→8 step. It then requires the eight exact PrimeFaces transitions and bundles Jakarta/Java/EAP changes into the final cutover. It does not define a separately buildable Jakarta preparation stage; use the preflight and atomic subphases within MIG-08 instead of introducing a mixed platform state.

| Stage | Change | Gate |
|---|---|---|
| MIG-00 | Baseline only | Build/test/baseline conditions recorded |
| MIG-01 | PF 6.2.30 → 7.0 | Build, test task, manual QA, checkpoint |
| MIG-02 | PF 7.0 → 8.0 | Build, test task, upload/date/table QA, checkpoint |
| MIG-03 | PF 8.0 → 10.0.0 | Build, test task, upload/autocomplete/table/export QA, checkpoint |
| MIG-04 | PF 10.0.0 → 11.0.0 | Build, test task, pages/date/tables/messages/visual QA, checkpoint |
| MIG-05 | PF 11.0.0 → 12.0.0 | Build, test task, exporter/upload/editor QA, checkpoint |
| MIG-06 | PF 12.0.0 → 13.0.0 | Build, test task, upload/export/table QA, checkpoint |
| MIG-07 | PF 13.0.0 → 14.0.0 + minimum Java11 | Build/bytecode; JSF2.3/SearchExpressions, client locale/accessibility, upload/theme QA, checkpoint |
| MIG-08 | A-F Jakarta dependencies/source/descriptors/PF15/theme/build; Java21 | Conditional build/static gates passed; user explicitly defers provisioned EAP8.1 runtime/visual acceptance |
| MIG-09 | Final acceptance | Release evidence and all finding dispositions |

The sequence skips PF9 deliberately as confirmed by assessment. Never run multiple PF migrations without the intervening build and QA gates.

## Mandatory theme and browser workstreams

The original assessment omitted a controlled theme decision. Omega was bundled in PF8 but is absent from PF10. The technically required replacement boundary is **MIG-03**. Its corrective static gate was resolved during MIG-04 after the user explicitly approved Saga: `primefaces.THEME=saga` and bundled PF11 resources are verified. No prior Omega runtime provenance or visual equivalence is asserted. Historical build/API results never proved visual success; reference screenshots/resource requests remain runtime work.

Use the version matrix, CSS register and reporting contract in `theme-browser-gates.md` for **each MIG-04, MIG-05, MIG-06, MIG-07 and MIG-08**. The machine-readable entries are `themeState`, `browserSupportState` and `remainingPhaseGates`.

Release-tag defaults are `saga` through PF14 and `saga-blue` in PF15; these are framework facts, not the current application theme. PF15 moves other listed themes to `org.primefaces:primefaces-themes` and renames `saga`/`arya`/`vela` with a `-blue` suffix (old names temporarily alias). Verify exact 15.0.16 resources/artifact needs, explicit configuration and Jakarta resource serving. The IE-removal boundary is confirmed by the PF13 migration guide: mandatory product decision at MIG-06, not an inferred no-impact pass from absent IE-only code. Source links are in the gate document.

Theme path: previous user-declared Omega -> exact per-version support/resource inventory -> removed-resource boundary MIG-03 -> owner-approved Saga replacement implemented MIG-04 -> explicit configuration/bundled artifact -> targeted CSS/icon remediation if evidenced -> browser visual validation DEFERRED. PrimeOne names the design system, not a literal theme. Saga is explicitly approved; revalidate it at every future target, including the PF15 `saga-blue` name.

Browser path: establish business browser matrix -> verify each target support policy -> IE-removal product gate -> classify application workarounds -> modern-browser validation. At MIG-06 user explicitly confirmed IE NOT required and accepted the drop before PF13 edits: IE SUPPORT DROPPED WITH PRIMEFACES 13. No IE-only application code was found, so no cleanup performed. Preserve this decision unless business requirements change; named modern-browser versions/OS and actual runtime acceptance remain outstanding.

Before any remaining version edit, record framework default separately from explicit application theme and prove theme resource availability. Missing/implicit default fallback is UNCONTROLLED VISUAL CHANGE and must be corrected by approved explicit configuration. Runtime environment absence permits only RUNTIME VISUAL VALIDATION DEFERRED, never successful visual equivalence. Stage-specific user acceptance is required for conditional visual deferral, and cannot decide an unknown product requirement or fix static resource incompatibility.

Every phase report must state theme compatibility, current/target concrete theme, Omega status, custom CSS impact, visual result, browser compatibility, IE-code detection and IE impact using the controlled values in the gate document. Evaluate them before marking completion. Final acceptance requires actual screenshots/interactions/resource requests and approved browser evidence.

Mandatory visual checklist: all five pages; overall layout/header/navigation/menus; forms/inputs/buttons/focus; dialogs; tables/sort/filter/pagination/expansion; date/autocomplete/editor/upload; growl/messages/progress/poll; icons/fonts/spacing; responsive behavior above/below 900px and narrow mobile widths. Static CSS class presence and a passing WAR build are not a visual gate.

## Standard commands and build loop

From the repository root:

```bash
./gradlew clean build
./gradlew test
```

For final target validation, only after MIG-08 changes and with required tooling/environment:

```bash
bash .aws/atx/skills/eap-primefaces-modernization/scripts/validate-modernized.sh
# EAP_IMAGE must be an approved provisioned EAP8.1 Java21 server image.
docker compose config
docker compose build
docker compose up
```

`docker compose up` runs a service and requires cleanup/termination procedures agreed for the environment. Do not run deployment commands without authorization and target image access. There are no automated Java/browser tests in the assessment; `./gradlew test` does not replace manual QA.

After each stage: RESTORE/RESOLVE → COMPILE (`clean build`) → ANALYZE → REMEDIATE → REBUILD → TEST (`gradlew test`) → MANUAL QA → CHECKPOINT → UPDATE LOG/STATE. Record baseline failures first so they are not attributed to migration. Stop at any unresolved gate.

## Stage-specific gates

Detailed files and finding IDs are specified in `.github/instructions/aws-transform-migration.instructions.md`. At a minimum:

- **MIG-01–07:** catalog change, stage-specific API/XHTML inspection, build/test, manual validation of each relevant feature, and checkpoint.
- **MIG-02/03/06/08:** emphasize file upload type/listener/multipart behavior in `ElementsBean.java` and `elements.xhtml`.
- **MIG-03:** check whether `primefaces.UPLOADER` remains supported before removing it.
- **MIG-05:** PF12 CSV/editor/upload APIs and Saga editor variables statically revalidated; no application edits required. p:repeat newly deprecated but supported; retained pending actual server Faces evidence. Legacy panelGrid grid path remains supplied; no PrimeFlex3 conversion required for current usage. All behavior/visual checks deferred.
- **MIG-06:** PF13 removes p:repeat: sole occurrence migrated to ui:repeat. TextEditor height becomes CSS String: 150 -> 150px. Exact artifact still supports uploader parameter/native decoder and current Java API; do not replay stale assessment removal/minimum-version assertions. Accepted IE drop, retained Saga, all runtime checks deferred; radio DOM/exporter registry added to QA.
- **MIG-07:** validate date picker formatting/AJAX and growl/messages behavior if actual PF14 taglib requires change.
- **MIG-07 observed outcome:** PF14 requires Java11 and JSF2.3+. source/target/release now11; Gradle8.4 runs Temurin11.0.30. Docker/Compose use catalog-listed EAP7.3.10 OpenJDK11/RHEL8 `7.3.10-2`, local image tagged java11; never deploy new WAR on Java8. Stock EAP7.3 has Mojarra JSF2.3, actual modules/default slot unavailable. All current tags including growl/calendar remain supported, no application Java/XHTML changes. Keep legacy allowTypes/sizeLimit (deprecated but supported) until next authorized target review. Check all SearchExpressions on actual Faces, locale/ARIA resources, upload errors and reduced-motion behavior; no timing override.
- **MIG-08:** update Java EE API coordinates, Jakarta imports/descriptors, PF15 Jakarta artifact, Java 21 build/runtime and EAP image as one coordinated cutover. Verify all three descriptors, no duplicate server APIs in WAR, and root `/`.
- **MIG-08 observed outcome:** A prepared JakartaEE10 and PF14 Jakarta classifier bridge, detected/remediated partial Maven-local metadata, then exposed30diagnostics from12old imports. B changed12imports and built successfully; C migrated web6/CDI4/Faces namespaces and built; D upgraded PF15Jakarta and required upload attrs/validator, built; E explicitly configured saga-blue and guarded image input, built; F final build/test/static/WAR checks passed (tests NO-SOURCE). No successful build claimed for A alone. Checkpoints/logs per sub-gate are in state. JBoss context-root-only vendor schema retained; no calendar/growl rewrite. Runtime/image assembly and all visual/behavior acceptance remain deferred.

The current Docker/Compose configuration has no image default. Missing `EAP_IMAGE` deliberately fails Compose interpolation; Dockerfile also requires an installed server under `/opt/server`. The approved plan's `eap81-openjdk21-runtime-openshift-rhel9` image contains dependencies **without a server** and needs separate provisioning/chained build. Do not remove guards, copy WAR to old `/opt/eap`, substitute community runtime, or treat synthetic Compose syntax checks as deployment. Follow the user-selected separation: complete Jakarta source/build here, undertake provisioning only with separate authorization/environment.

Residual namespace checks must distinguish zero application `javax` references from vendor contents: PF15Jakarta has Java SE references, embedded Maven transformer/source metadata and four known old signature strings in serialized-lambda deserialization checks. Disassembly/jdeps establish no legacy EE type links, but serialization paths remain a documented risk. Do not label these harmless debug text or silently patch the vendor JAR. Namespace evidence is in the phase session artifacts.
- **MIG-09:** repeat all-page and full component validation, deployment acceptance and finding disposition.
- **MIG-09 observed outcome:** no EAP_IMAGE/server homes configured, no cached EAP image. Official server provisioning/product/access prerequisites documented in final-acceptance.md; registry access/entitlement remains UNKNOWN, not reattempted or fabricated. Clean build/static/WAR pass, zero behavioral tests and zero application interactions manually validated. All rebuilt WAR payload entries match MIG-08; no production files changed. Exact supplier/listener/application-map ownership reviewed; overall serialized-state risk REQUIRES MANUAL REVIEW with cross-platform session invalidation required. No runtime, final visual or browser gate passed.

Resume the remaining MIG-09 gates only once an approved provisioned EAP8.1Java21 runtime/product and secure access are supplied. Verify empty-server startup, product/JDK/Mojarra/Weld/layers/configuration before deploying the identified candidate at root. Capture all startup/deployment warnings/errors and per-feature/browser evidence. Do not mix scanner/management deployment methods or expose management credentials/ports. Actual state-saving/passivation/replication topology must be reviewed; drain and invalidate application-scoped old sessions/views for cross-version cutover without clearing unrelated stores. An acceptance report being written does not complete acceptance.

## Manual validation points

Run against each stage as appropriate, comparing with the recorded baseline:

1. Home, Dashboard, Employees, Reports and Elements load; shared navigation works.
2. CDI-backed values and named beans resolve.
3. Elements form validation, messages, AJAX updates and buttons work.
4. Date control opens, selects, submits and displays `dd/MM/yyyy`; AJAX summary updates.
5. Tables sort/filter/paginate and expand where configured.
6. CSV export downloads the expected rows.
7. Text editor renders and submits its value.
8. Upload invokes listener with expected metadata/content and respects 1 MiB/file and 2 MiB/request limits.
9. Autocomplete, menu, dialog, progress/poll and browser console work.
10. Compare `app.css` styling and client resources visually.
11. Final runtime: EAP logs are clean, `ROOT.war` serves `/`, port 8080 and architecture are as approved.

## Failure handling

- **Existing failure:** record from MIG-00 and compare exact output after stages.
- **Deterministic migration compile error:** inspect exact target API; make minimal in-scope edit; rerun clean build.
- **Artifact resolution failure:** verify coordinate, repository access and local JAR override; do not substitute an unverified artifact.
- **Ambiguous API/descriptor behavior:** stop and request manual review rather than guessing.
- **Functional regression:** do not advance; fix within the owning stage and repeat its entire relevant gate.
- **Target image/registry unavailable:** record `BLOCKED — ENVIRONMENT REQUIRED`; no EAP success claim.
- **Unexpected unrelated changes:** preserve them; stop if the migration edit would conflict.

## Rollback and checkpoints

Before each stage, record its checkpoint hash/base and ensure a cleanly understood diff. Keep the prior passing WAR and, for MIG-08, the passing PF14/EAP7.3 source/artifact. Roll back only stage-introduced changes using a non-destructive, Git-aware procedure; never discard unrelated worktree changes. Re-run the prior stage's build and relevant checks after rollback. Do not create/amend commits without user instruction.

## State and traceability

After every gate, append a `MIG-XX` entry to `transformation-log.md` with finding IDs, checkpoint, files changed, reason, commands/results, outcome and remaining issues. Update `migration-state.json` from observed facts: current/completed/pending/blocked stages, finding dispositions, build/test status and target versions. Do not mark anything complete based on intent or file edits alone.

## Final acceptance criteria

- All MIG-00 through MIG-08 gates are complete; MIG-09 acceptance documented.
- Target Java 21 build succeeds and resolves the approved Jakarta EE/PF dependencies in provided/implementation scopes as appropriate.
- No application-owned EE `javax` references or stale descriptors remain; Java SE `javax` packages are not false positives.
- WAR does not bundle duplicate server APIs/implementations.
- EAP 8.1 deployment starts cleanly and serves the root application at `/`; if environment unavailable, acceptance remains blocked.
- All manual page/component behaviors pass; no browser-console errors; visual changes are reviewed.
- ATX-FIND-001 through ATX-FIND-014 are validated resolved or explicitly accepted with rationale.
- Transformation log and state JSON accurately describe the final outcome.

## MIG-09 actual EAP operational addendum — current

The user authorized adding missing multistage provisioning to the actual starting Dockerfile. It now pins the supplied Red Hat builder/runtime digests, assembles the EAP8.1 channel/cloud-default-config, copies `/opt/server`, and deploys the unchanged ROOT.war. Compose no longer needs `EAP_IMAGE`. Exact base identities, resolved channel1.8.0.GA-redhat-00006 and observed versions are in final acceptance. Retain the immutable **built application image and resolved installation manifests**: base pins alone do not freeze future provisioning.

Local tests used disposable linux/amd64 emulated containers with loopback HTTP and unpublished management port. Fresh initial startup and identical54checks pass. **Do not use same-container restart as an accepted lifecycle:** repeated cloud CLI aborts on existing KUBE_PING. Fresh immutable replacement passes; this does not repair restart. Setting `CONFIG_IS_FINAL=true` on a fresh image was tried and rejected because initial JGroups discovery setup was missing. Do not copy that failed workaround into production or bypass the launcher. Obtain vendor/operator-approved lifecycle/configuration and rehearse restart/upgrades before release.

Actual server has distributed web caches and connected one-member JGroups; app is non-distributable, Undertow persistent-sessions absent. No app replication/passivation/failover established. Missing namespace/API/CA/auth/encryption/TLS local warnings are not production-approved configuration.

**Cutover and rollback: INVALIDATE ALL EXISTING SESSIONS / VIEWS for this application.** Drain/stop every old instance, prevent old app-scoped persisted/replicated state restoration, start fresh and require a new GET. Never reuse JavaEE/PF14 state with Jakarta/PF15 or perform an unproven mixed-version state-preserving rolling upgrade.

Rollback is **PARTIAL**: previous WAR/checkpoints retained but matching old immutable EAP7 runtime/config and reverse-deployment rehearsal absent. Before release, retain and validate the compatible previous image/WAR/config pair. Drain/stop current instances, invalidate this app's state, deploy fresh rollback containers, confirm clean startup/deployment and home/navigation/form/AJAX/upload/tables/CSV before traffic. Do not rebuild a moving channel for rollback or run javax WAR on EAP8/Jakarta WAR on EAP7. No database rollback required. Current image replacement was validated, prior-pair rollback was not. Production release remains unapproved.
