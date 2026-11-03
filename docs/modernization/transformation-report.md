# Final Transformation Report

**Final migration status: TECHNICALLY MIGRATED — EAP RUNTIME ACCEPTANCE INCOMPLETE.**

**MIG-09: target EAP startup/deployment and54/54 browser checks PASS; operational lifecycle/rollback acceptance INCOMPLETE.**

**Current EAP update:** user-pinned Red Hat images provisioned **EAP8.1 Update8.0** with Java21. The unchanged WildFly-validated WAR passes the same54browser checks on EAP. Same-container restart fails duplicate KUBE_PING configuration; fresh immutable replacement passes. Production cluster/TLS, rollback and visual limits remain. **Production release is not approved.** See the latest additive EAP record at the end. Earlier blocked/provisional statements below preserve historical attempts, not the current runtime result.

This report distinguishes a successful technical migration from target-product operational acceptance. The application builds as a Java21/JakartaEE10/Faces4/PF15.0.16Jakarta WAR. No approved provisioned EAP8.1 server/image or endpoint is available. Deployment, behavioral, visual and browser validation did not occur in the initial official EAP attempt. **Not accepted for production and not accepted with known risks.** No release-risk waiver is implied.

## Original and reconstructed baseline

Original configuration: Java8, JavaEE8, JSF supplied by EAP7.3.10, PrimeFaces**6.2.30** private maintenance artifact, Gradle8.4 WAR, root context `/`. Five pages, five view beans, sample in-memory data, no database/ORM or application authentication integration.

The private6.2.30 artifact could not be recovered. User explicitly approved **public6.2** as a **RECONSTRUCTED BASELINE** for MIG-00. Compilation/static packaging proved only that substitute builds; it did **not** establish original artifact or behavioral equivalence. Prior runtime and Omega deployment provenance/reference screenshots remain unavailable. This caveat survives the final report.

## Phase ledger

| Phase | Transition / meaningful changes | Outcome |
|---|---|---|
| MIG-00 | Missing private6.2.30 -> approved public6.2 reconstructed baseline; no application migration | COMPLETED_CONDITIONAL; build/WAR pass, tests NONE, original equivalence unproven |
| MIG-01 | PF6.2 ->7.0; dependency/metadata | COMPLETED_CONDITIONAL; build/static/WAR pass, runtime deferred |
| MIG-02 | PF7 ->8.0; UploadedFile -> model.file package, fileUploadListener -> listener | COMPLETED_CONDITIONAL; build/static/WAR pass, runtime deferred |
| MIG-03 | PF8 ->10.0.0; explicit sortMode=single on Employees/Elements | COMPLETED_CONDITIONAL; build/static/WAR pass; missed Omega-removal static gate corrected in MIG-04 |
| MIG-04 | PF10 ->11.0.0; user-approved explicit Saga, rowKey=record.reference, dialog responsive=false, unsupported menu icons -> PrimeIcons | COMPLETED_CONDITIONAL; static theme gate pass, HIGH visual risk deferred |
| MIG-05 | PF11 ->12.0.0; dependency only; supported controls retained | COMPLETED_CONDITIONAL; p:repeat then deprecated but supported |
| MIG-06 | PF12 ->13.0.0; p:repeat ->ui:repeat, editor height150 ->150px; accepted IE drop | COMPLETED_CONDITIONAL; build/static/WAR pass, modern-browser QA deferred |
| MIG-07 | PF13 ->14.0.0; Java8 ->11 source/target/release and same EAP7.3.10 configured OpenJDK11/RHEL8 image | COMPLETED_CONDITIONAL; JSF2.3 likely from stock EAP but actual runtime unverified |
| MIG-08A | EE10 provided dependencies, Java21 compiler/release, temporary PF14Jakarta bridge | Dependencies prepared; first missing local classifier remediated, then30javax-source diagnostics resolved in B; no successful A build falsely claimed |
| MIG-08B | Exactly12CDI/Inject/Faces imports in5beans -> Jakarta | Clean build pass; compile checkpoint with bridge |
| MIG-08C | web6/CDI4, Jakarta Faces XHTML namespaces; vendor root-context descriptor retained | Clean build/static descriptor checks pass; exact EAP parsing deferred |
| MIG-08D | PF14Jakarta bridge ->15.0.16Jakarta; dragDrop rename; same extension/size into validateFile; obsolete uploader selector removed | Clean build/static pass, no unsupported used tags/attrs |
| MIG-08E | Explicit Saga ->saga-blue; bundled core resources; provisioned-image deployment guard | Clean build/static theme pass; no image assembly/deployment |
| MIG-08F | Final build/test/static/WAR/namespace validation | MIG-08 COMPLETED_CONDITIONAL; no unexplained javax residue, known vendor strings risk retained |
| MIG-09 | Runtime prerequisites investigated; build/test/static/WAR/checkpoints revalidated; serialized-state reachability reviewed; acceptance matrix/report recorded | **BLOCKED** for runtime acceptance; no deployment/functional/visual/browser pass |

Historical phase evidence is in [transformation-log.md](migration/transformation-log.md) and [migration-state.json](migration/migration-state.json). All conditional phases retain their original unexecuted interaction checks; later builds do not retroactively close them.

## Final technical state

| Area | Result |
|---|---|
| PrimeFaces | Sole `org.primefaces:primefaces:15.0.16:jakarta`; actual Jakarta binary/SHA verified, not unclassified legacy artifact |
| Java | Application8 ->11 in MIG-07 ->21 in MIG-08; compiler Temurin21.0.9, source/target/release21,11classes major65. Gradle8.4 runs JVM11.0.30; no claim it can run on JDK21. Runtime JDK still unobserved. |
| Platform | JavaEE8 javax APIs ->JakartaEE10 provided APIs;12app imports migrated, no duplicate server APIs/implementations packaged |
| Faces/CDI/Servlet | Target Faces4/CDI4/Servlet6, compile API versions verified; actual EAP/Mojarra/Weld/module patch levels unknown |
| Descriptors/routes | Jakarta web6/beans4, annotated CDI preserved, Faces mapping/welcome/multipart caps preserved, vendor root descriptor unchanged |
| Namespace residue | Application0; PF dependency60literal occurrences:24JavaSE,32embedded build metadata,4serialized-lambda old signatures. No legacy EE type links; known deserialization risk remains. |
| Theme | **Omega ->Saga ->Saga Blue**; Omega replacement approved in MIG-04, PF15 explicit saga-blue. PrimeOne design system, CSS bundled in core; no separate themes JAR. HIGH visual risk not accepted. |
| Browser policy | User explicitly accepted **IE SUPPORT DROPPED WITH PRIMEFACES13** before MIG-06. No IE workaround restored; actual named modern-browser matrix still needs approval/testing. |
| Application scope | Same Gradle WAR/root/five pages/sample behaviors; calendar/growl/editor/listener retained where target supports them; no DB/security integration/new architecture introduced |
| Runtime configuration | Requires approved **provisioned** EAP8.1 Java21 EAP_IMAGE, no default; /opt/server guard and ROOT.war deployment. Bare runtime image has no server. |

## MIG-09 validation result

**Resume evidence, 2026-10-27:** User supplied `registry.redhat.io/jboss-eap-8/eap81-openjdk21-runtime-openshift-rhel9`, without explicit tag/digest. This is the runtime-only base, not proof of a provisioned EAP server. Manifest inspection returned **unauthorized**; no login/credential reading/pull/start/deployment occurred. EAP_IMAGE/server homes remain unset and no local EAP image is present. The user will configure secure registry access and provide an approved provisioned image reference. Acceptance remains blocked pending both; all historical evidence and previous results below remain unchanged. Candidate WAR SHA is unchanged. No runtime or production-readiness claim follows from the reference name.

`./gradlew clean build` **PASS**, independent `./gradlew test` command SUCCESS but **NO-SOURCE**. **Zero automated behavioral tests, zero application interactions manually validated** in final acceptance. The repository validator passes static/WAR checks only.

Rebuilt candidate: `build/libs/primefaces-homeoffice.war`,4,143,832bytes, SHA-256 **`8668787e9348c04f051d37f195ed2c1ba142427c339b6cb73c4f995b9ae4d400`**. Every uncompressed entry matches MIG-08's preserved candidate; timestamp-only ZIP checksum change is not an application payload change. PF binary SHA-256 `b78ca75ff08d9a9c776b397f3d45caf84fa9736048b510ae350819cb6721425f`.

Runtime prerequisite inspection found no EAP_IMAGE/server-home configuration and no cached EAP image. Docker/Compose are available but do not supply a server/entitlement. Safari executable is present; Chrome/Chromium/Firefox absent from inspected standard paths (other locations/remote tooling unknown). No application endpoint exists for any browser. Missing EAP_IMAGE correctly rejects Compose configuration. No registry authentication/credential fabrication/pull, empty-server startup, app deployment, screenshot or console capture occurred. Deployment errors/warnings are **not captured**, not declared absent.

**Functional: NOT TESTABLE. Visual: NOT TESTED. Browser: NOT TESTABLE.** Detailed A-L prerequisites, per-interaction checks, search/upload boundary scenarios, visual surfaces, browser matrix and findings are in [final-acceptance.md](migration/final-acceptance.md).

## Unresolved risks and owner actions

| Risk / gate | Remaining action |
|---|---|
| EAP runtime/product/access | Owner supplies supported EAP8.1 Java21 server/product or approved immutable provisioned image and secure entitlement/registry access. Official builder/runtime flow must provision server before copying WAR; no use of bare runtime-only default. |
| Generated configuration/architecture | Verify actual layers/modules, EAP/Mojarra/Weld/JDK versions, standalone.xml, UID/permissions/entrypoint/bindings/scanner/logging. Repo amd64 versus local daemon arm64 requires intended-host/image-manifest approval. |
| Deployment and Faces/CDI | Empty-server startup first, then root WAR, classloading/linkage/descriptors/CDI/Faces/bootstrap/resource checks; retain all relevant logs/warnings. |
| Behavior | Execute all inherited13checks and MIG-03–08additional obligations against target; follow D-F acceptance scenarios. Static contracts are not behavior. |
| Theme/browser/accessibility | Full5page Saga Blue comparison, resource requests, fonts/icons/layout/keyboard/focus/ARIA/reduced-motion and approved named browser/version/OS matrix. HIGH inherited custom CSS risk, new PF15 paginator/progress DOM surfaces. No proven original Omega visual baseline. |
| Serialized state | Overall REQUIRES MANUAL REVIEW. Visible app object graph exposure LOW/MEDIUM-confidence: suppliers normally owned by Facelets handler/application map; JPA builder unused; UploadedFile transient. Runtime state-saving/passivation/replication unknown. **Invalidate old sessions/views for cross-platform cutover**; verify current-version paths if enabled. No library patch and no claim strings harmless. |
| No tests | Manual regression required now. Recommended future minimal target-runtime/browser/upload/CSV/table/lifecycle/state suite requires separately authorized scope; no large suite added here. |
| Original baseline uncertainty | Retain public6.2 reconstruction disclaimer; do not claim equivalence to private6.2.30. |
| Release governance | No finding silently closed; infrastructure/QA owners must provide evidence/sign-off. No production risk acceptance was given by authorizing this phase. |

## Rollback strategy and persistent artifacts

Git base **`b254429990b48e414914769217a3fd94daeb46ed`** plus `pre-mig09.patch` SHA-256 **`f5909d4893acc8846d0a273fa7236b1ee0e557b8b1161457d242c4c7958d4051`** reconstructs pre-MIG-09 technical candidate including existing MIG-07/08 changes. `pre-mig09-state.json` preserves exact prior state.

For pre-Jakarta rollback, retain `pre-mig08.patch` SHA-256 `05237997a5604a75881468ca69a18eccdca434f3be8ea036118e738cfca2b79f` against the same base and `pre-mig08-pf1400.war` SHA-256 `5dc023c5faf09463f9b71055329314b3b88146bbb06e8f64777293670d388863`. Intermediate B-E checkpoints are compile/static milestones, **not supported deployment rollback targets**. Restore only in a separate worktree and validate on matching JavaEE/EAP7/Java11 runtime; never reset unrelated/shared work. EAP7cannot run Jakarta WAR, and EAP8must not be assumed to run the old WAR unchanged.

Preserved session files include MIG-08 patch/WAR/checkpoints, MIG-09 logs/environment/disassembly, `mig09-pf15016-jakarta.war` and `mig09-acceptance.patch`. No commit was created. Promote artifacts/checksums/logs to controlled durable release storage before real deployment; a local session directory is not a release repository. Actual prior image/digest and restoration/startup are still missing, so operational rollback is **PARTIAL**, not rehearsed.

Before cutover/rollback, define application-scoped session/view-store invalidation and user notification/draining. Never reuse persisted/replicated JavaEE/JSF views across runtime versions without proven conversion. Do not clear unrelated applications' stores. Retain prior immutable runtime image until acceptance and verify a fresh-session rollback rehearsal in isolated infrastructure.

## Production-readiness decision

**TECHNICALLY MIGRATED — RUNTIME ACCEPTANCE INCOMPLETE.**

Source/dependency/namespace/theme configuration migration and build/static packaging are demonstrated. **Production release is not approved.** Runtime provisioning/startup/deployment and full functional/visual/browser acceptance remain externally blocked; no criteria for ACCEPTED FOR PRODUCTION or ACCEPTED WITH KNOWN RISKS have been met. Resume the remaining **MIG-09** acceptance gates once infrastructure exists; no later modernization work was started.

## Additive MIG-09 provisional acceptance — 2026-10-27

**PROVISIONAL RUNTIME VALIDATION COMPLETE.**

**Final migration status: TECHNICALLY MIGRATED — EAP RUNTIME ACCEPTANCE INCOMPLETE.**

The user authorized disposable upstream WildFly validation because Red Hat registry access remains unavailable. **Production target remains Red Hat EAP8.1. EAP8.1 validation: STILL REQUIRED.** All earlier EAP attempt/results, historical phase statuses, checkpoint hashes and unresolved findings above remain preserved. None has been relabeled as an EAP pass.

### Verified compatibility environment

Official `quay.io/wildfly/wildfly:35.0.1.Final-jdk21`, pinned digest `sha256:850129d5aa9564a080f9737eb18697171cecd452a33578f7ee4066a0611b71c0`, linux/arm64. Actual server **WildFly35.0.1.Final/Core27.0.1.Final**, Java **Temurin21.0.6+7**, Mojarra **4.0.8**, Weld **5.1.4.Final/CDI API4.0.1**, Servlet API **6.0.0/Undertow2.3.18.Final**, PF **15.0.16Jakarta**. The WildFly35 release documents EE10/Java21 compatibility; actual banner/module/initialization records independently establish this environment, not compatibility inferred from an image name.

Complete stock upstream server/standalone.xml/base modules; no custom Galleon provisioning/server-module change or DB/security workaround. Owned disposable container `mig09-provisional-wf35`, ID `9b3db443081d537af094a9530dfc2a39b1097fad821e612109eacaac3a7144b5`. HTTP loopback-only, management not published. Empty server passed startup before initial WAR copy; deployed ROOT.war through scanner. Default transaction-node ID and missing/self-signed keystore warnings retained; not production hardening. The stock sample datasource is unused by this application.

### Corrections confined to observed acceptance defects

| Classification | Correction and outcome |
|---|---|
| APPLICATION MIGRATION ISSUE | Immutable table lists failed PF in-place sorting, with real Faces partial-response errors hidden behind HTTP200. Elements now uses a stable mutable session-owned list. EmployeeBean uses mutable **view-owned** data after explicit user approval; two views in the same session remain independent. |
| PORTABLE JAKARTA EE ISSUE | Employees table lacked a Faces form for filter inputs; added employeesForm. Actual sort/filter and5+3row pagination now pass. Original defect provenance unproven, not blamed on WildFly. |
| APPLICATION MIGRATION ISSUE | CSV exporter returned literal EL from text instructions; hidden export table now uses four h:outputText value components. Exact headers and all record values pass. |
| APPLICATION MIGRATION ISSUE | PF15 validateFile needed client-validation metadata enabled to retain type/size feedback before native multipart limits. Enabled primefaces.CLIENT_SIDE_VALIDATION, keeping server validator/regex/limits and Save/Reset lifecycle intact. |
| APPLICATION MIGRATION ISSUE | Remaining application legacy menu/confirm icons mapped to PrimeIcons; removed inherited white inversion and fixed contrast on light Saga navigation; custom stylesheet emitted last. No redesign. |
| WILDFLY-SPECIFIC ISSUE | No app-specific workaround required; only disposable loopback/scanner configuration. Docker reassigning an ephemeral HTTP port on restart was handled by the test harness, not by application changes. |
| EAP VALIDATION STILL REQUIRED | Product provisioning/configuration/support, deployment, functionality, visuals and state/rollback must be repeated on actual approved EAP8.1. |

No dependency/version, EAP image target/Dockerfile/Compose, database schema or upstream internals changed. Original PF/theme/Java transition lineage and approved IE drop remain unchanged. Baseline labels still visible in sample page copy are historical content, not runtime-version evidence.

### Current candidate and acceptance results

Final WAR `build/libs/primefaces-homeoffice.war`: **4,143,924bytes**, SHA256 **`e03949114666f2abce73dd9c3f6c3aca933f1db1c1190b1c779c6196304fb5a0`**, preserved `mig09-provisional-validated.war`. Initial unchanged candidate remains preserved under its earlier SHA above; the new checksum represents the explicitly recorded compatibility corrections, not timestamp-only equivalence.

| Gate | Provisional outcome |
|---|---|
| Build/static/WAR | PASS after corrections; Java21 bytecode, same PFJakarta target; Gradle test NO-SOURCE |
| Deployment | PASS WildFly only: descriptors, root context, Faces/CDI/PF initialization/resources, no observed linkage/classloading/module/bootstrap error or deployment rollback; healthy restart |
| Functional | **54/54 grouped checks PASS**,18per engine: five pages/nav, Save/validation/Reset, explicit external @form probe, @this/IDs/process/update, dialog/confirmation, table sort/filter/clear/expansion, real paging, calendar/autocomplete/editor persistence, upload/messages/CSV/poll/repeat |
| Upload supplemental | txt/csv/pdf accepted;1,048,575/1,048,576bytes accepted,1,048,577client-rejected; bypassed client metadata and proved server validateFile rejects extension without listener success |
| Final errors | Page/console/HTTP/Faces partial-response error counts **0** across final three-engine run. Earlier server exceptions and harness failures retained separately, not erased. |
| Visual | **MINOR MIGRATION DIFFERENCES**, provisional. Actual Saga Blue/PrimeIcons and five-page desktop/Elements1440/900/390captures; representative views inspected. Original Omega baseline unavailable; narrow tables/calendar wrapping, fixed modal mobile acceptance and inherited CSS differences remain. No comprehensive visual/branding or accessibility certification. |
| Browser | Chromium156.0.8078.4, Firefox157.0, WebKit27.2:18/18each. Keyboard focus/Enter close and reduced-motion media interaction checked. **Safari product NOT TESTED**; tooling engines do not establish an approved stable-release/OS support matrix. |
| Serialized state | LOW for observed standalone topology, MEDIUM-confidence; no distributable/persistent app configuration or cluster transport. Same browser cookie/model across restart loses old model as expected. Actual EAP passivation/HA/rolling policy remains MANUAL REVIEW. **Invalidate old application sessions/views/stores at cutover and rollback.** Four upstream lambda strings unchanged. |
| Automated regression coverage | **Zero repository behavioral tests**. Isolated executed acceptance harness is not a committed/maintained regression suite. |
| Rollback | PARTIAL: checkpoints/old WAR/final WAR retained; no matching prior immutable EAP runtime or operational rollback rehearsal. No database changes. Use compatible runtime/WAR/config pair and fresh application state, never cross-family WAR/session reuse. |

Limits remain explicit: UploadedFile stream contents are not consumed/compared by current listener; hostile multipart/request-cap feedback, full progress reset cycle, broad editor/security/browser/accessibility edge cases and EAP topology were not exhaustively tested. No new blocking application defect remains in executed provisional paths; these limitations are not risk waivers.

Detailed functional/visual/browser matrices, root causes, source corrections, evidence filenames and future minimum regression suite are in the additive section of [final-acceptance.md](migration/final-acceptance.md). Evidence includes build/static/server/module/configuration records, original failed attempts,54checks, supplemental probes, CSVs/DOM/screenshots, final WAR, manifest and `mig09-provisional-acceptance.patch`, alongside all previous checkpoints. Local session artifacts require promotion to controlled release storage. Owned container stopped after capture; no shared images/caches or unrelated services removed.

**Remaining release actions:** obtain entitled approved provisioned EAP8.1/Java21, verify real modules/topology/platform/TLS/configuration, replay critical acceptance against the final candidate, approve visual/browser/accessibility results and rehearse compatible-pair rollback with application-state invalidation. **Not accepted for production. Stop after MIG-09.**

## Additive MIG-09 pinned EAP8.1 results — 2026-10-27

**Current decision: TECHNICALLY MIGRATED — EAP RUNTIME ACCEPTANCE INCOMPLETE.** Registry access, provisioning, actual target deployment and application/browser checks are now evidenced, not deferred. Production approval is withheld for the actual lifecycle/configuration and rollback gaps below. All preceding blocked/provisional statements describe their earlier runs.

| Surface | Actual target result |
|---|---|
| Approved builder | `registry.redhat.io/jboss-eap-8/eap81-openjdk21-builder-openshift-rhel9@sha256:40f2d11ef2b181330eadb04fc1b89925b91921612f39f72fee475c55a53e06d6` — access PASS |
| Approved runtime | `registry.redhat.io/jboss-eap-8/eap81-openjdk21-runtime-openshift-rhel9@sha256:6a3590ad17625af2bffd64d4cd6828da15c56102fcc57fa5c7be9bd4dc662845` — access PASS |
| Authorized build correction | Actual starting Dockerfile lacked described multistage provisioning. User explicitly authorized adding it; pinned builder assembly/EAP8.1 channel/cloud-default-config, `/opt/server` copy, existing amd64/ROOT/UID185 preserved; obsolete Compose EAP_IMAGE input removed. No application changes/rebuild |
| Build/provisioning | PASS; resolved channel manifest1.8.0.GA-redhat-00006, EAP EE pack8.1.1.GA-redhat-00048/cloud pack2.0.0.Final-redhat-00040 |
| Exact EAP/Java | **JBoss EAP8.1 Update8.0**, Core27.1.15.Final-redhat-00001; **Red Hat OpenJDK21.0.12.1+1-LTS** (Red_Hat-21.0.12.1.1-1) |
| Jakarta implementation | EE10; Mojarra4.0.11.SP1-redhat-00001; Weld5.1.6.Final-redhat-00001/CDI4.0.1.redhat-00001; Servlet6.0.0.redhat-00007/Undertow2.3.26.SP3-redhat-00001. Verified modules/product/logs, not image labels |
| Fresh startup/deployment | PASS, ROOT.war/context `/`, CDI/Faces/PF15.0.16 initialization/descriptors; no application namespace/module linkage conflict or rollback observed |
| WAR | Unchanged4,143,924bytes, SHA256 `e03949114666f2abce73dd9c3f6c3aca933f1db1c1190b1c779c6196304fb5a0`; actual ROOT.war hash matches WildFly candidate |
| Built image | Local image/index `sha256:5c651567391eac85c3bbf185257597768c7ff505e40d120df742e781bd9a43c2`, archived; not a published registry reference |
| Identical harness | **54/54 PASS**, same byte-identical harness and check criteria as WildFly35.0.1.Final54/54; Chromium156.0.8078.4, Firefox157.0, WebKit27.2 each18/18; zero page/console/HTTP/Faces-partial-response errors, no status differences |
| Supplemental | PASS upload boundaries/txt-csv-pdf, actual server validateFile bypass rejection, per-view isolation and fresh immutable replacement. Uploaded stream contents not consumed by listener; no byte-comparison claim |
| Visual/browser | **MINOR DIFFERENCES**, Saga Blue; no confirmed new EAP visual regression. Prior CSS/mobile/original-baseline/accessibility limits retained. Safari product NOT TESTED; WebKit is not Safari. IE decision unchanged |
| Same-container restart | **FAIL — EAP CONFIGURATION ISSUE**, repeated cloud CLI aborts on existing kubernetes.KUBE_PING. Fresh immutable replacement passes, not a restart PASS |
| Rejected diagnostic | `CONFIG_IS_FINAL=true` on fresh image removes necessary initial discovery setup: JGroups failed/31 services failed or missing. No flag/entrypoint bypass committed; failed logs retained |
| Real EAP sessions | App non-distributable, no Undertow persistent-sessions; cloud web distributed cache owners2/no store and JGroups TCP/KUBE_PING active, one node only. Presence of legacy passivation cache does not prove app replication/passivation |
| Cutover | **INVALIDATE ALL EXISTING SESSIONS / VIEWS for this application**, also on rollback. Drain/stop old nodes, isolate/clear only old app stores, start fresh, require new GET; no cross-version state-preserving rolling upgrade. Current replacement loses old model/cookie as expected; no HA/failover proof |
| Serialized-lambda risk | LOW observed topology/MEDIUM confidence; four upstream strings unchanged, no binary compatibility guarantee; re-review if enabling HA/persistence |
| Rollback | **PARTIAL**. Previous PF14/Java11/JavaEE WAR/checkpoints retained, but matching prior EAP7 image/config and rollback rehearsal missing. Preserve exact compatible image/WAR/config; fresh deployment/state invalidation/critical-path checks. No DB/schema impact |

Observed differences from WildFly are product/implementation patches, amd64 emulation, cloud launcher/restart behavior, distributed server caches and actual JGroups warnings—not functional54-check regressions. Local missing namespace/API/CA caused KUBE_PING `https://null:0` discovery failures/insecure trust-manager warning; cluster auth/encryption and TLS/keystore are not production-approved. These real warnings are retained rather than hidden behind the browser pass.

Image base digests alone do **not** freeze a moving EAP8.1 provisioning channel. The built candidate image/archive, resolved installation manifest and artifact streams are retained. Rollback must use an existing compatible immutable image, not rebuild the channel or swap WARs across JavaEE/Jakarta runtime families.

Evidence: `.../session-state/b576bbf4-7254-42d8-992a-9e42c392510e/files/mig09-eap-pinned/` contains manifests/pulls, module/product/Galleon/config/session/health logs, actual deployed WAR, identical harness and54results, DOM/CSV/AJAX/screenshots, restart failure, rejected diagnostic, separate replacement results, image archive and hash manifest. Build log and acceptance patch are adjacent. Owned containers stopped; old evidence untouched. Promote local evidence to controlled release storage. Detailed gates/rollback procedure are in the [latest final-acceptance addendum](migration/final-acceptance.md).

**Remaining release gates:** supported lifecycle/configuration remediation and restart rehearsal; production platform/discovery/TLS/cluster approval; compatible prior-runtime rollback rehearsal; visual/browser-policy and retained limits. No new application migration defect observed. No risk waiver or production acceptance inferred. **Stop after MIG-09.**
