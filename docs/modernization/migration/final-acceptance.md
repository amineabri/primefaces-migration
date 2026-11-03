# MIG-09 Final Acceptance

**Current decision: TECHNICALLY MIGRATED — EAP RUNTIME ACCEPTANCE INCOMPLETE.**

**Latest EAP update, 2026-10-27:** authenticated pinned-image build, actual **EAP8.1 Update8.0** deployment and **54/54** unchanged browser checks PASS. Same-container restart FAILS cloud reconfiguration; fresh immutable replacement passes. Rollback remains PARTIAL. See the latest additive EAP record at the end; production release is not approved. Earlier blocked-EAP and provisional WildFly results below are preserved as historical evidence.

## Historical official EAP acceptance attempt

**Runtime gate: RUNTIME ACCEPTANCE BLOCKED — INFRASTRUCTURE PREREQUISITE.**

MIG-09 was explicitly authorized after confirming **MIG-08 = COMPLETED_CONDITIONAL**. This initial acceptance attempt did not authorize broad modernization or waive previous risks. No production source, dependency, descriptor, CSS or container configuration was changed in that attempt. Build/static checks passed again; deployment, functional, visual and browser acceptance did not run. Official EAP acceptance remains **BLOCKED**, not completed or production-accepted.

## Evidence and checkpoint

### Resume attempt — 2026-10-27

Runtime acceptance remains blocked. After the five requested records were read, local availability was rechecked: EAP_IMAGE/EAP_HOME/JBOSS_HOME still unset, no cached EAP image or running Docker container; candidate SHA unchanged (`8668787e9348c04f051d37f195ed2c1ba142427c339b6cb73c4f995b9ae4d400`). The user supplied `registry.redhat.io/jboss-eap-8/eap81-openjdk21-runtime-openshift-rhel9` as the image reference. This names the **runtime-only base**, not an established provisioned server, and has no explicit tag/digest.

At `2026-10-27T19:43:57.097463+00:00`, `docker manifest inspect` requested implicit latest and returned **unauthorized — Please login to the Red Hat Registry using your Customer Portal credentials**. This supersedes UNKNOWN for this specific manifest-access attempt only; it does not establish missing organizational entitlement. No credentials were read, login attempted, image pulled or server started. Actual EAP/Java/Faces/CDI/Servlet versions, layers/configuration and environment identifier remain unobserved.

The user selected **“I will configure secure registry access and provide an approved provisioned image reference.”** Awaiting those prerequisites; no deployment/functional/visual/browser/state/rollback result was promoted. Prior evidence/checkpoints unchanged; `pre-mig09-resume-state.json` and `mig09-resume-runtime-reference-evidence.json` retained alongside earlier artifacts. Historical initial-attempt results below are preserved. No rebuild or source/configuration changes were needed for this prerequisite check.

Evidence directory: `/Users/amineabri/.copilot/session-state/b576bbf4-7254-42d8-992a-9e42c392510e/files/` (local session artifacts, not committed release storage).

| Evidence | Result / reference |
|---|---|
| Preflight | Read state, transformation log, runbook, theme/browser gates, EAP analysis, approved plan, findings and MIG-08 evidence. Reviewed A failure diagnostics and B-F success logs, namespace inventory and checkpoint contents/hashes. |
| Pre-MIG-09 checkpoint | Base `b254429990b48e414914769217a3fd94daeb46ed` plus `pre-mig09.patch`, SHA-256 `f5909d4893acc8846d0a273fa7236b1ee0e557b8b1161457d242c4c7958d4051`; exact state `pre-mig09-state.json`. Preserves pre-existing MIG-07/08 work. No commit created. |
| Prior candidate | `mig08-pf15016-jakarta.war`, SHA-256 `ab5d534c6f94edc2d5402f96863c4274f9a1ae710afd4ba48d69b1beaec1d198`; B-E patch hashes verified against state. |
| Clean build | `./gradlew clean build --console=plain`: **PASS**, `mig09-build.log`. |
| Independent test task | `./gradlew test --console=plain`: command SUCCESS, **NO-SOURCE**, zero behavioral tests; `mig09-test.log`. |
| Existing validator | `bash .aws/atx/skills/eap-primefaces-modernization/scripts/validate-modernized.sh`: **PASS static/WAR only**, `mig09-static.log`. |
| Environment inspection | `mig09-environment-evidence.json`: EAP_IMAGE/EAP_HOME/JBOSS_HOME not supplied, no cached EAP image; Docker29.9.2 available, linux/arm64 daemon; Compose5.6.1. No credential-store inspection/login/pull or unrelated-container access. |
| Missing-image guard | `docker compose config --quiet` with EAP_IMAGE unset deliberately fails with required provisioned-image diagnostic: **PASS guard**, not a failed deployment. |
| Rebuilt candidate | `build/libs/primefaces-homeoffice.war`: **4,143,832 bytes**, SHA-256 `8668787e9348c04f051d37f195ed2c1ba142427c339b6cb73c4f995b9ae4d400`. All uncompressed entries byte-identical to MIG-08 candidate; checksum changes from ZIP timestamps, not payload. Preserved as `mig09-pf15016-jakarta.war`. |
| Target binary | Sole `primefaces-15.0.16-jakarta.jar`, SHA-256 `b78ca75ff08d9a9c776b397f3d45caf84fa9736048b510ae350819cb6721425f`; no bundled EE APIs/implementations. |
| Namespace and bytecode | 11 expected application classes, major65/Java21. Application javax0. Dependency60 literals classified:24JavaSE,32embedded Maven metadata,4serialized-lambda signatures. See MIG-08 namespace JSON plus MIG-09 disassembly. |
| Static component inventory | 125 PF occurrences,44 tags,293 attributes,129 tag/attribute pairs; unsupported0. This is not a Faces render/lifecycle test. |

## MIG-09A — runtime prerequisites

No approved provisioned image reference or reachable approved server endpoint was provided. EAP_HOME/JBOSS_HOME are unset and no local EAP image is cached. These observations establish missing infrastructure here, **not** absence of the organization's subscription or denial of currently valid credentials. Existing registry access was not reattempted; no secrets were read, fabricated, printed or stored.

| Prerequisite | Classification | Evidence / required action |
|---|---|---|
| Approved EAP8.1 product/server source | **MISSING** | Choose an entitled EAP8.1 distribution on a supported host, or an approved provisioned image. No server artifact/endpoint supplied. |
| Product entitlement/support | **MANUAL ACTION REQUIRED** | Owner must verify EAP8.1 subscription, supported OS/JDK/platform and intended container platform. Local Docker on macOS is not proof of supported production deployment. |
| Registry access | **BLOCKED EXTERNALLY** | Authenticated access to registry.redhat.io and approved immutable builder/runtime references must be supplied by infrastructure owner. Access status UNKNOWN, not falsely reported as denied or available. Use a registry service account/pull secret for shared environments; never commit secrets. |
| Provisioned server image | **MISSING** | Bare runtime-only image has no server. Builder also provisions during assembly; it is not itself a ready server. Required EAP_IMAGE remains unset. |
| Provisioning tooling/channel/layers | **MANUAL ACTION REQUIRED** | Official route below; chosen product revision, channel resolution and generated configuration must be recorded before startup. No Maven/Galleon build project introduced. |
| Local build toolchain | **AVAILABLE** | Gradle8.4 JVM Temurin11.0.30; MIG-08 confirmed compiler Temurin21.0.9. MIG-09 rebuild major65. This is not runtime Java21 evidence. |
| EAP8.1 Java21/JakartaEE10 support | **AVAILABLE — documented compatibility** | Red Hat support tables and EAP8.1 OpenJDK21 images; actual server/JDK/module versions **MISSING** until provisioned. |
| Docker/Compose | **AVAILABLE** | Local engine/Compose responsive. Not an approved EAP environment and not evidence for image entitlement. |
| Architecture | **MANUAL ACTION REQUIRED** | Repo forces linux/amd64; daemon linux/arm64. Verify image manifest, intended host and support before deployment; no speculative platform change/emulation acceptance. |
| Datasource/JDBC/JPA | **AVAILABLE — no application requirement** | No persistence.xml, datasource/JNDI reference, DB driver, JPA model or external database. Do not provision sample DB credentials to compensate for default server subsystems. |
| Application security | **AVAILABLE — no configured auth integration** | No login/security-domain/application credential dependency. This does not certify security or authorize public exposure; editor secure=false is unchanged. |
| Management/registry/TLS credentials | **MANUAL ACTION REQUIRED** | Registry/service account secret and management access/TLS, if selected, are operator-owned. No application secret required by current source. No default/generated credential invented. |
| Modules/services | **MISSING** | Need Undertow/Servlet6, Jakarta Faces4 (default Mojarra), CDI4/Weld, EL and normal logging/deployment services. No custom app module/JBoss deployment-structure dependency. Exact product patch/Mojarra/Weld versions unobserved. |
| Scanner and server configuration | **MANUAL ACTION REQUIRED** | Choose scanner-based ROOT.war deployment or management deployment consistently. Verify standalone.xml, scanner enabled, deployment directory/permissions and container entrypoint. Repository currently uses scanner/.dodeploy. |
| Bindings/ports | **MANUAL ACTION REQUIRED** | App8080; standard standalone defaults include HTTPS8443 and management9990. A socket does not prove TLS configured. Container public interface must be reachable; management stays restricted. Verify binding/port conflict before publishing. |
| Environment variables | **MANUAL ACTION REQUIRED** | Required provisioned EAP_IMAGE; fixed EAP_PLATFORM=linux/amd64 pending approval. Provisioning variables below are build inputs, not invented runtime app settings. Verify actual image's supported bind/JAVA_OPTS variables rather than assuming old image behavior. |
| Logs/health/readiness | **MANUAL ACTION REQUIRED** | Retain startup/server log and stdout/stderr, deployment result/markers and module versions. Standard server.log under standalone/log; check actual image console handlers. No logging change needed in application. |
| Browser tooling/support policy | **MANUAL ACTION REQUIRED** | Safari executable present; Chrome/Chromium/Firefox not found at inspected standard app paths. No proof that no remote/other-location browser exists. Approve named browser/version/OS matrix and supply target endpoint first. |

### Supported provisioning path to unblock B

The official OpenShift route documents these image families (tag/digest still requires approval):

```text
registry.redhat.io/jboss-eap-8/eap81-openjdk21-builder-openshift-rhel9
registry.redhat.io/jboss-eap-8/eap81-openjdk21-runtime-openshift-rhel9
```

Default provisioning inputs in the EAP8.1 guide:

```text
GALLEON_PROVISION_FEATURE_PACKS=org.jboss.eap:wildfly-ee-galleon-pack,org.jboss.eap.cloud:eap-cloud-galleon-pack
GALLEON_PROVISION_LAYERS=cloud-default-config
GALLEON_PROVISION_CHANNELS=org.jboss.eap.channels:eap-8.1
```

These are **channel-managed** coordinates, not fixed pack versions; resolve/pin approved revisions rather than inventing versions or deploying mutable latest. `cloud-default-config` is a broad HA-derived default with extra subsystems, not a minimal Faces-only layer. Supported `jsf` decorator provides Faces. Do not assume `datasources-web-server + jsf` proves CDI: the documented base brings servlet/scanner/datasource services, whereas `jaxrs-server` explicitly adds CDI (and other unused capabilities). No minimal custom layer combination has been validated for this WAR. A default server is a conservative starting configuration to verify, not a claim an exact custom layer set has passed.

1. Infrastructure owner selects supported product/platform and obtains registry entitlement/service-account pull access outside this repository. For ZIP/installer route, obtain the actual entitled **8.1** product distribution on a supported OS/JDK; do not copy documentation examples that still name8.0 as verified8.1.
2. With official builder/runtime flow, invoke documented `/usr/local/s2i/assemble` with the approved channel/feature-pack/layer inputs, then copy the resulting server into the runtime stage at **/opt/server** with correct ownership. For an already-built Gradle WAR, follow the documented default-server assembly and WAR-copy path, not an assumption S2I will build Gradle.
3. Alternative supported provisioning uses `org.jboss.eap.plugins:eap-maven-plugin` (`provision` versus `package`) under an operator-owned provisioning workflow. Do not change the application's Gradle build merely to provision a server.
4. Capture resulting immutable image/product revision, Java21 version, EAP8.1 patch/banner, actual Mojarra/Faces4, Weld/CDI, enabled layers/modules, standalone.xml and entrypoint. Verify UID185 assumptions/permissions, deployment scanner and startup **before** app deployment.
5. On a standalone installation, `-b`/`jboss.bind.address` controls public binding; management binding is separate. Do not infer an image variable named JBOSS_BIND_ADDRESS. Verify container entrypoint/image variable contract and keep management private.
6. Standard scanner defaults poll5seconds with zipped WAR auto-deployment, but trimmed/generated config must be inspected. Choose one deployment mechanism; Red Hat recommends management deployment for production rather than mixing it with scanner copying.
7. Once the approved image exists and empty-server startup passes, provide its immutable reference as EAP_IMAGE. Only then build/start the repository image or deploy through the approved server's management interface. Deploy the identified candidate at root, capture errors/warnings and continue C-I.

Documentation sources: [EAP8.1 OpenShift guide, §§1.3,2.3,2.4.1,9.2](https://docs.redhat.com/en/documentation/red_hat_jboss_enterprise_application_platform/8.1/html-single/using_jboss_eap_on_openshift_container_platform/index); [Provisioning guide, §§2–3 and supported-layer Appendix A](https://docs.redhat.com/en/documentation/red_hat_jboss_enterprise_application_platform/8.1/html-single/provisioning_jboss_eap/index); [Supported configurations](https://access.redhat.com/articles/6961381); [Registry authentication](https://access.redhat.com/articles/RegistryAuthentication); [Configuration guide, network/deployment/logging](https://docs.redhat.com/en/documentation/red_hat_jboss_enterprise_application_platform/8.1/html-single/configuration_guide/index). Public documentation establishes options, not observed runtime availability.

## MIG-09B/C — server and deployment

**RUNTIME ACCEPTANCE BLOCKED — INFRASTRUCTURE PREREQUISITE.** B not executed; C not attempted. No app logic was modified to work around missing infrastructure. No unrelated running container was stopped/inspected internally; no substitute WildFly/Tomcat/static-XHTML server was started.

| Runtime/deployment evidence required | Result |
|---|---|
| EAP version/patch and startup | **NOT TESTABLE**; documented target8.1, no running approved server |
| Runtime Java version | **NOT TESTABLE**; target21, local compiler not runtime proof |
| EE/Faces implementation/version/layers | **NOT TESTABLE**; targetEE10/Faces4/Mojarra, exact product/modules unknown |
| WAR deployment/CDI/Faces bootstrap/descriptors/root context | **NOT TESTABLE** |
| Classloading/namespace linkage/resource HTTP requests | **NOT TESTABLE** |
| Deployment errors/warnings | **NOT CAPTURED — no deployment occurred**, not “zero errors/warnings” |

Root-cause classification: **ENVIRONMENT ISSUE / EXTERNAL DEPENDENCY ISSUE** (missing approved server source/image/access path). No observed application migration or server-configuration failure can be asserted without execution.

## MIG-09D — functional acceptance

All rows below are **NOT TESTABLE** because B/C could not run. Source/static declarations are test inputs, not behavior evidence. No manually validated application interaction exists from this attempt.

| Check | Status | Required evidence when unblocked |
|---|---|---|
| Application startup | NOT TESTABLE | EAP running-state/deployment success, clean relevant logs, root HTTP response |
| Home | NOT TESTABLE | Expected CDI content and interactive navigation |
| Dashboard | NOT TESTABLE | Cards/table content/actions, no Faces errors |
| Employees | NOT TESTABLE | Expected records, sort/filter/page behavior |
| Reports | NOT TESTABLE | Expected report values and navigation |
| Elements | NOT TESTABLE | Named-bean values, validation/action paths, not just HTTP200 |
| Dialogs/confirmation | NOT TESTABLE | Open/close/confirm/cancel, overlays/focus, feedback |
| AJAX update/process | NOT TESTABLE | Submitted values/actions and correct target partial responses/DOM changes |
| File selection/upload | NOT TESTABLE | Advanced auto upload, filename/size/listener, status and messages |
| Upload validation | NOT TESTABLE | Extension and size boundaries/client bypass/error feedback; see F |
| Text editor | NOT TESTABLE | Toolbar,150px height, HTML submit/round trip, unchanged secure=false behavior |
| Data tables | NOT TESTABLE | Correct row values/identity across postbacks |
| Sorting | NOT TESTABLE | Explicit single sort on Employees/Elements, expected order |
| Filtering | NOT TESTABLE | Match/filter/clear returns expected rows |
| Pagination | NOT TESTABLE | Enabled page transitions/data continuity; use sufficient controlled QA rows if fixture fits one page; do not change production sample data |
| Row expansion | NOT TESTABLE | Correct reference/detail before and after sort/filter/postback |
| Date/calendar | NOT TESTABLE | Select/submit/dd/MM/yyyy round trip, locale/timezone/dateSelect summary update |
| Autocomplete | NOT TESTABLE | Suggestions, selection, forceSelection, no stale summary |
| CSV export | NOT TESTABLE | Download headers/content/quoting/encoding/rows/filename; not button presence |
| Growl/messages | NOT TESTABLE | Action and invalid-input feedback visible without unintended duplicates |
| Polling/progress | NOT TESTABLE | Interval8, count/state updates, progress reset, no console errors |
| ui:repeat | NOT TESTABLE | Five departments, order/content and state across AJAX |
| Navigation/menu | NOT TESTABLE | Five routes and menu/dialog/command actions, no broken outcomes |

## MIG-09E — SearchExpressions / Faces4

**NOT TESTABLE at runtime.** Static review retains13update attributes and the explicit `process="@this"` on Reset; named targets are present. No explicit `@form` expression is used. Do not add/change expressions merely to exercise that keyword.

| Surface | Status | Acceptance action |
|---|---|---|
| @this / Reset | NOT TESTABLE | With invalid required input, verify Reset processes only itself, resets model/input state and rerenders formPanel/messages/growl |
| @form | NOT TESTABLE — not explicitly used | Confirm actual default form-processing behavior on Save; if standalone resolver verification is required, use external target test instrumentation, not a production source change |
| Component IDs / process / update / AJAX targets | NOT TESTABLE | Capture Faces4 partial-response targets and model updates for summary, status, messages, growl, progressPanel/autoPanel |
| Lifecycle interactions | NOT TESTABLE | Distinguish conversion/validation failure, invoke-application listener calls, render-response and poll/autoUpdate effects; no ComponentNotFoundException |

## MIG-09F — file validation

**NOT TESTABLE end to end.** Same extension regex and1MiB validator limit declared; native multipart caps remain1MiB/file and2MiB/request. This preserves static intent, not demonstrated behavior.

| Scenario | Status | Expected evidence |
|---|---|---|
| Select txt/csv/pdf under limit | NOT TESTABLE | Auto request/listener getFileName/getSize, status and existing FacesMessage |
| Extension invalid / alternate case / deceptive suffix | NOT TESTABLE | Compare exact regex policy `/(\.|\/)(txt|csv|pdf)$/` and feedback; do not silently add case-insensitivity, MIME or virus validation |
| Sizes1,048,575 /1,048,576 /1,048,577bytes | NOT TESTABLE | Verify intended accepted boundary and rejected oversize through validator/Servlet; no listener on rejected upload |
| p:validateFile / client and server rejection | NOT TESTABLE | Capture invalid-file display and server response, including client validation bypass and request cap |
| Empty/cancel/reselect and total request over2MiB | NOT TESTABLE | Correct UI/error handling, no false success/listener |
| UploadedFile and success/error messages | NOT TESTABLE | Listener metadata/transient field valid within request; growl/messages/status updated |

## MIG-09G — visual acceptance

**NOT TESTED.** Lineage **Omega -> Saga -> Saga Blue**; current explicit saga-blue/core PrimeOne resources have static evidence only. No baseline reference screenshots/runtime, target screenshots, network captures or rendered comparison exists. No restyling was performed.

| Surface | Visual result | Risk / acceptance action |
|---|---|---|
| Overall layout/navigation/menu | NOT TESTED | All5pages, header/links/active route and menu actions |
| Forms/input fields/buttons | NOT TESTED | Labels/errors/focus/contrast, required and selected states |
| Dialogs | NOT TESTED | Fixed responsive=false modal,420px width, overlays/keyboard on narrow screens |
| Tables/paginator/row expansion | NOT TESTED | HIGH inherited risk; PF15 paginator buttons now match app button/focus rules |
| Calendar/autocomplete | NOT TESTED | Overlays, selection, ARIA and locale presentation |
| Editor/upload | NOT TESTED | Theme variables/toolbar/file labels/invalid states |
| Growl/messages/progress/poll | NOT TESTED | Visibility/overlap; PF15 progress label moved inside value div |
| PrimeIcons/fonts | NOT TESTED | Packaged definitions exist; actual network/rendering not proven |
| Responsive layout/spacing/colors/CSS overrides | NOT TESTED | Desktop, around900px and narrow mobile; Arial/palette/focus/cascade preserved in source, not visually accepted |

**Custom CSS impact HIGH; visual validation DEFERRED; Omega REPLACED; PrimeIcons STATIC PASS, runtime NOT TESTED.** Resolve only evidenced migration-related defects when runtime exists; do not redesign.

## MIG-09H — browser acceptance

| Browser | Availability observed | Result |
|---|---|---|
| Chromium-based | Chrome/Chromium not at inspected standard macOS application paths; remote/alternate install unknown | **NOT TESTABLE** |
| Firefox | Not at inspected standard path; remote/alternate install unknown | **NOT TESTABLE** |
| Safari | Executable exists locally; exact version not exercised, business requirement unspecified | **NOT TESTABLE**, no target endpoint |

For each approved browser/version/OS, collect JS/console/network errors, CSS/layout, dialogs/AJAX/upload/editor, keyboard/focus and `prefers-reduced-motion` normal/reduce results. None was run, including Safari. Do not infer browser compatibility from source/resource declarations. **IE SUPPORT DROPPED WITH PRIMEFACES13** remains accepted; no workaround reintroduced. Named modern-browser business matrix still requires approval.

## MIG-09I — serialized-lambda risk

**Overall classification: REQUIRES MANUAL REVIEW.** For the repository's visible non-clustered object graph, exposure is **LOW with MEDIUM confidence**; this is bounded static reasoning, not a deserialization pass. Across the JavaEE/JSF/PF runtime boundary, **REQUIRES SESSION INVALIDATION** before release unless a separately proven state migration exists.

Exact packaged binary was disassembled without modification; logs `mig09-{AutoUpdateTagHandler,AutoUpdateListener,PrimeApplicationContext,JPALazyDataModel-Builder,Lazy}-javap.log` retained.

| Question | Evidence / conclusion | Classification |
|---|---|---|
| Does app explicitly serialize PF objects? | No ObjectOutputStream/readObject/custom serializer, PF supplier/model construction or PF object in nontransient session bean state. ElementsBean Serializable/SessionScoped stores sample Java/model values and **transient UploadedFile**. Four other beans ApplicationScoped. | LOW for visible app-owned graph |
| AutoUpdateTagHandler ProjectStage supplier | App uses2autoUpdate tags. Supplier lives in Facelets TagHandler's Lazy field; apply subscribes a separate serializable AutoUpdateListener, not the handler. Listener fields disabled/on are ValueExpression/String, no handler/Lazy supplier. Handler supplier is not visibly copied into view/session state by that path. | LOW for inspected path; actual Faces behavior untested |
| PrimeApplicationContext Validator/ValidatorFactory suppliers | Context owns Lazy fields and is stored in application/ServletContext map, not the session; class itself not Serializable. No app caching/serialization of its internals. | LOW for standard ownership; extensions/environment unknown |
| JPALazyDataModel.Builder supplier | No JPA/lazy model in source; tables bind lists. | NOT APPLICABLE to present app usage |
| JSF view/session persistence | Source neither selects state-saving method nor configures serialization/passivation strategy. Do **not** infer server-side state is never serialized. Actual Mojarra/container flags/provider unknown. | REQUIRES MANUAL REVIEW |
| Cluster/distributed replication | No distributable descriptor/HA/session replication/cluster setup in repo; official cloud-default-config is HA-derived, so generated/runtime topology must be checked rather than inferred absent. | REQUIRES MANUAL REVIEW |
| Cross-version persistence / rolling upgrade | No rollout/session-store policy exists. Changed runtime/API family cannot be assumed compatible with old serialized views/sessions despite serialVersionUID=1. | REQUIRES SESSION INVALIDATION |

`Lazy.init` is nontransient; the binary `$deserializeLambda$` string comparisons retain javax while implementation return types are Jakarta. If those suppliers are serialized/deserialized, a real mismatch/failure is possible. No library internals were patched and no claim of harmless metadata is made. Cold cutover prevents **old** state reuse but does not prove same-version lambda serialization safe.

Before release, owner must record state-saving method, serialize-server-state/passivation settings, session persistence/store namespace, HA/replication/sticky-session topology and rolling-update policy. Drain traffic; expire/invalidate old application sessions/views, including persisted/replicated stores scoped to this application only; do not share JSF saved state between EAP7/8 deployments. Inform users of session/draft/upload loss. Verify fresh sessions and current-version passivation/failover if used. If a relevant failing path is found, escalate to vendor-supported remediation in separately approved scope, not an upstream JAR edit.

## MIG-09J — coverage gap

**Zero automated behavioral tests.** Gradle command success is not a passed behavioral test. Manually performed checks here were artifact/checkpoint inspection, static source/disassembly review, build tooling/availability and missing-image guard only. No application behavior, rendered page, visual or browser interaction was manually validated.

Recommended minimum **future, separately authorized** regression suite: target EAP startup/deploy/CDI/root/resources smoke; all5page/navigation tests; Faces AJAX/reset/validation/message assertions; upload valid/type/size/client-bypass boundaries; table sort/filter/page/row-key expansion; CSV byte/content assertions; calendar/timezone/autocomplete/editor round trip; poll/repeat state; supported-browser keyboard/reduced-motion plus focused Saga Blue screenshots. Include state passivation/failover only if enabled in the approved environment. Add neither a large suite nor tooling dependencies during this blocked acceptance attempt.

## MIG-09K — final acceptance matrix

| Area | Status | Evidence | Residual Risk | Action |
|---|---|---|---|---|
| Build | PASS | MIG-09 clean build/log | No deployment proof | Preserve candidate and supported toolchain |
| Java21 | PARTIAL | Major65, Java21 compiler; Gradle JVM11 | Runtime JVM unobserved | Capture actual server java version |
| JakartaEE10 | PARTIAL | Provided API10, no platform APIs bundled | Product services unobserved | Start entitled EAP8.1 |
| Faces4 | PARTIAL | API4.0.1/namespaces/static tag checks | Mojarra patch/lifecycle unknown | Capture implementation and exercise lifecycle |
| PrimeFaces15Jakarta | PASS — artifact/static | Sole15.0.16 classifier/SHA | Vendor lambda strings/client behavior | Perform runtime UI/state checks |
| EAP8.1 | BLOCKED | No approved runtime/image/endpoint | No startup evidence | Provision through A |
| Deployment | NOT TESTABLE | B/C not run | Classloading/bootstrap/errors unknown | Deploy root candidate; retain logs |
| Descriptors | PARTIAL | Jakarta web6/CDI4 parse, vendor root preserved | Exact server parsing/discovery unknown | Verify EAP deployment/root |
| CDI | NOT TESTABLE |12imports compile, annotated beans | Injection/scopes/passivation unknown | Exercise all named beans |
| AJAX/SearchExpressions | NOT TESTABLE | Static IDs13updates; E checklist | Faces4 targets/lifecycle unknown | Execute E |
| File upload | NOT TESTABLE | Native/validateFile/multipart static | Limits/metadata/error UX untested | Execute F |
| Editor | NOT TESTABLE | Supported150px/secure=false retained | HTML/state/feedback; no sanitization claim | Round-trip/visual validation |
| Tables | NOT TESTABLE | rowKey/single sort declared | Sorting/filter/page/expansion regressions | Execute D with suitable QA fixture |
| Calendar | NOT TESTABLE | Deprecated but supported | Date/locale/timezone/AJAX | Round-trip with dates/locales |
| CSV export | NOT TESTABLE | Registry-supported exporter retained | Bytes/headers/encoding unknown | Download/content comparison |
| Theme | NOT TESTED | Explicit saga-blue bundled | HIGH inherited visual/CSS risk | Browser screenshots and sign-off |
| PrimeIcons | PARTIAL | Used classes/font resources supplied | HTTP/rendered icon unresolved | Inspect network and visual result |
| Browser compatibility | NOT TESTABLE | Availability inventory, no target | Named matrix/behavior unknown | Approve matrix, execute H |
| Accessibility/client behavior | NOT TESTABLE | Reduced motion not overridden | Keyboard/focus/ARIA/localisation | Exercise both motion preferences |
| Serialized state | REQUIRES MANUAL REVIEW | I: exact ownership/disassembly | Current serialization/HA unknown | Cold-cutover session invalidation; verify configured paths |
| Automated tests | NONE | test NO-SOURCE | No repeatable behavioral safety net | Manual acceptance now; future minimum suite |
| Rollback readiness | PARTIAL | Base+patch/state+WAR verified | No tested prior runtime/image/state rollback | Rehearse on isolated environment, retain immutable prior image and session policy |

### Finding disposition

No previously unresolved finding is silently closed or accepted as a production risk by this attempt.

| Finding | Disposition |
|---|---|
| ATX-FIND-001/002 | Java21 compilation/toolchain verified; runtime evidence still missing. Gradle8.4 must continue running on supported JDK11 with compiler21. |
| ATX-FIND-003/014 | API scope/classifier/provenance validation requirements met for current build; historical open finding list retained pending final sign-off, no source-override drift observed. |
| ATX-FIND-004/005 | Imports/descriptors migrated; CDI/Faces/server parsing acceptance outstanding. |
| ATX-FIND-006 | All version transitions built conditionally; inter-stage behavioral acceptance still absent. |
| ATX-FIND-007 | Upload API/required PF15 validation markup corrected; end-to-end validation missing. |
| ATX-FIND-008/009 | Exact target supports calendar/growl, so speculative replacements unnecessary; date/message behavioral obligations remain. |
| ATX-FIND-010 | HIGH visual/client/component surface unaccepted. |
| ATX-FIND-011/012 | Actual EAP8.1 image, startup, support/architecture validation blocked. |
| ATX-FIND-013 | Zero behavioral tests, no substitute manual regression performed. |

## MIG-09L — report, rollback and release decision

Full lineage/phase outcomes/manual actions are in [transformation-report.md](../transformation-report.md). Preserve prior source/patch/state/WAR and immutable image outside transient local storage before release. Restore only in a separate worktree from the recorded base plus appropriate checkpoint patch, never reset shared work. PF14Java11/JavaEE8 WAR must only run on compatible prior runtime; JakartaJava21 WAR only on approved EAP8.1. Do not roll either WAR onto the wrong server or restore old serialized sessions after cutover.

**Production release: NOT APPROVED.** Technically migrated source/build is demonstrated; runtime acceptance is incomplete, not “accepted with known risks.” All inherited13interaction items and every phase-specific deferred list remain open. Resume **MIG-09 only** after approved infrastructure/access and QA prerequisites exist; then capture server-startup-before-deploy, deployment logs, D-I results, actual browser evidence and owner sign-off. No further modernization phase was started.

## Additive MIG-09 provisional runtime validation — 2026-10-27

**PROVISIONAL RUNTIME VALIDATION COMPLETE. EAP8.1 validation: STILL REQUIRED.**

**Current classification: TECHNICALLY MIGRATED — EAP RUNTIME ACCEPTANCE INCOMPLETE.**

The user explicitly authorized upstream WildFly while authenticated/entitled Red Hat registry access remains unavailable. WildFly is a disposable compatibility environment, **not the production target or an EAP substitute for acceptance**. The official EAP results above, MIG-00–08 checkpoints, all unresolved findings and deferred lists remain historical evidence. No phase beyond MIG-09 started.

### Observed runtime, source and deployment

| Item | Observed evidence |
|---|---|
| Server | **WildFly35.0.1.Final**, Core27.0.1.Final; actual startup banner and management responses, not image-name inference |
| Source | Official `quay.io/wildfly/wildfly:35.0.1.Final-jdk21`, pinned `quay.io/wildfly/wildfly@sha256:850129d5aa9564a080f9737eb18697171cecd452a33578f7ee4066a0611b71c0`, linux/arm64 |
| Environment | Owned local container `mig09-provisional-wf35`, ID `9b3db443081d537af094a9530dfc2a39b1097fad821e612109eacaac3a7144b5`; macOS Docker host, disposable Linux runtime |
| Provisioning | Pulled complete upstream server image; stock standalone.xml and `modules/system/layers/base`; no custom Galleon packs/layers, modules, datasource, security realm or application logic workaround for server configuration |
| Java | **Eclipse Temurin21.0.6+7 LTS**, actual `java -version`; upstream WildFly35 recommends Java21 |
| Platform | **Jakarta EE10** WildFly35 release certification family; observed Faces/CDI/Servlet modules independently confirm required API levels. No claim this run executes the Jakarta TCK. |
| Faces | **Mojarra4.0.8**, implementation module descriptor and application initialization log |
| CDI | **Weld5.1.4.Final**, CDI API4.0.1; deployment processing, bean values and listeners exercised |
| Servlet | API6.0.0, **Undertow2.3.18.Final**; native multipart upload exercised |
| Other runtime detail | Hibernate Validator8.0.2.Final; stock ExampleDS/H2 starts but application requires no datasource/DB/JPA/authentication/custom module/secret |
| Startup gate | **PASS before first WAR copy**: empty server running, HTTP responsive, no module/provisioning/configuration failures |
| Local bindings | `standalone.sh -b 0.0.0.0` inside container; only HTTP8080 published to host **127.0.0.1** on disposable ports. Management9990 never published. Initial63669, restart64369, subsequent64416; port reallocation is Docker ephemeral binding, not app failure. |
| Deployment | Scanner zipped auto-deploy/default5second scan; copied exact initial `build/libs/primefaces-homeoffice.war` as ROOT.war only after startup gate; successful WFLYSRV0010/root registration. Redeployed identified corrected candidates through the same scanner. |
| Initial candidate | Preserved `mig09-pf15016-jakarta.war`, SHA256 `8668787e9348c04f051d37f195ed2c1ba142427c339b6cb73c4f995b9ae4d400` |
| Final candidate | **4,143,924bytes**, SHA256 **`e03949114666f2abce73dd9c3f6c3aca933f1db1c1190b1c779c6196304fb5a0`**, preserved `mig09-provisional-validated.war`; same Java21/EE10/PF15.0.16Jakarta dependency target |
| Final deployment | **PASS provisionally**: Faces/CDI/PF initialization, descriptors/root context/resources, no observed linkage/classloading/missing-module error or deployment rollback; running/OK management status and successful restart |
| Warnings | Default transaction node identifier; missing application.keystore and self-signed certificate-on-first-use warning. Retained, not production TLS/cluster acceptance. Expected server validator warning for deliberately rejected extension also retained. |

Source: [WildFly35 release and Java21/EE10 compatibility evidence](https://www.wildfly.org/news/2025/01/09/WildFly-35-is-released/). Actual pinned image/banner/modules are the evidence for the installed patch levels.

### Runtime-discovered findings and narrowly scoped corrections

| Classification | Observed failure / correction | Verification / limits |
|---|---|---|
| APPLICATION MIGRATION ISSUE | PF15 `SortFeature` sorts in place; immutable table lists caused `UnsupportedOperationException` and Faces partial-response errors, despite HTTP200. Elements now keeps a stable mutable session-owned list. | Both sort directions, filter/clear and postback expansion pass. A discarded getter-copy attempt lost sort order and was not accepted. |
| APPLICATION MIGRATION ISSUE | Employees shared immutable application data cannot safely become mutable globally. **User explicitly approved view-scoped EmployeeBean** with its own mutable list. | Sort/filter and real5+3row pagination pass; supplementary two-view/same-session check proves independent sort/filter state. Scope change is intentional and approved, not a broad bean refactor. |
| PORTABLE JAKARTA EE ISSUE | Employees table was outside a Faces form: filter inputs were not processed reliably. Added an `employeesForm` around that table. | Actual typed name filter submits and reduces rows; Next/Previous restore correct records. Earlier sorting alone had not proved form processing. Original runtime provenance is unavailable, so no claim this defect originated in a specific migration phase. |
| APPLICATION MIGRATION ISSUE | CSV exporter returned literal `#{record.*}` from Facelets text instructions. Only the hidden export table's four fields now use `h:outputText` value components. | Downloads have exact four headers/four complete record tuples; sort order may follow the session's sorted model. No literal EL. |
| APPLICATION MIGRATION ISSUE | Moving PF15 rules to `p:validateFile` did not alone emit client validation metadata. Oversize file feedback was absent before the Servlet cap. Enabled `primefaces.CLIENT_SIDE_VALIDATION`. | Restores client extension/size checks; existing Save required-validation/Reset lifecycle still passes. Server validator remains attached. No extension/size policy or native multipart cap changed. |
| APPLICATION MIGRATION ISSUE | Removed legacy icon aliases from application menu/confirm declarations, retained PrimeIcons equivalents; old white-inversion filter made top icons invisible on Saga's light navigation. | Font/resources and visible icons checked; bounded CSS correction disables inversion and sets dark navigation-icon color. App stylesheet rendered in the head's last facet so framework resources do not follow it. No redesign. |
| WILDFLY-SPECIFIC ISSUE | **No application-specific WildFly defect/workaround identified.** Stock configuration sufficed. | Local bindings/scanner and default operational warnings documented above; not copied into EAP configuration. |
| EAP VALIDATION STILL REQUIRED | Red Hat entitlement, provisioned product, exact modules/configuration, supported production architecture/topology/TLS and rollback environment remain unverified. | No WildFly result is promoted into an EAP pass. |

Seven production files changed only for these acceptance defects: ElementsBean.java, EmployeeBean.java, elements.xhtml, employees.xhtml, WEB-INF/web.xml, WEB-INF/templates/main.xhtml and app.css. No dependency/version, EAP Dockerfile/Compose, DB schema or upstream-library internals changed.

### Provisional functional acceptance

The retained Playwright harness ran **18 grouped checks per engine, 54/54 PASS** on the final candidate. Assertions covered real DOM/model changes and downloaded data; **zero final page/console/HTTP errors and zero Faces `<error>` responses** were observed. Initial failed attempts remain retained and are not rewritten as passes.

| Check | Provisional status | Behavioral evidence / limitation |
|---|---|---|
| Server/application startup | PASS | Healthy empty startup first, then root deployment, CDI/Mojarra/PF initialization; restart healthy |
| Home/dashboard/employees/reports/elements | PASS | Expected page titles/headings and bean-backed values, no raw EL; navigation through actual menu outcomes |
| Menus/navigation | PASS | Employees/Elements menu transitions, expected data; dialog menu action. External GOV.UK destination not certified. |
| Dialogs | PASS | Open/hide sample modal; confirmation Yes invokes action and displays Confirmed |
| AJAX process/update | PASS | Save submits edited value and invokes listener; named messages/growl/summary targets change; poll autoUpdate changes count |
| @this / validation lifecycle | PASS | Empty required service input fails Save; Reset processes itself, bypasses invalid input, restores model/input and messages |
| @form | PASS — external resolver probe | Browser-side `PrimeFaces.ab` submits explicit `p:'@form'` against existing Save action and named update IDs; value survives reload. No production expression added. |
| Component IDs/SearchExpressions | PASS | Department AJAX summary update, Reset formPanel/messages/growl, uploadStatus, progressPanel/autoPanel and row-expansion targets resolve under Mojarra4 |
| File selection/accepted file | PASS | Actual disk-backed file selection auto-uploads; listener reads UploadedFile name/size, status and success message/growl update |
| Extension validation | PASS | `.exe` rejected, prior successful status unchanged; txt/csv/pdf accepted. Supplemental client-metadata bypass reaches server `p:validateFile`, receives validationFailed/error message, not listener success. |
| Size validation | PASS |1,048,575 and1,048,576bytes accepted;1,048,577bytes client-rejected with Invalid file size and unchanged success status. Native1MiB/file and2MiB/request caps unchanged. |
| UploadedFile bytes/content consumer | PARTIAL | File transport/listener metadata proven; app never reads/compares stream contents. No claim of byte-for-byte consumer validation. Malicious oversized multipart/server-cap feedback and total request-cap bypass not exhaustively tested. |
| Text editor | PASS | Editable content saved, submitted HTML-backed value survives reload, rendered editor height150px. No full rich-text sanitization/security audit; existing secure=false unchanged. |
| Data tables/sorting/filtering | PASS | Elements4rows, ascending/descending reference, typed filter to one/clear to four; Employees name filter and both sort directions |
| Pagination | PASS | Actual Employees5+3rows, Next/Previous preserve correct first row and counts; Elements single-page Next disabled correctly |
| Row expansion | PASS | Reference-keyed detail shown/collapsed after sort/filter AJAX; expected EL-001 detail, not merely toggler visibility |
| Calendar/date | PASS | Popup selects15October2026; dateSelect stores value; dd/MM/yyyy survives reload |
| Autocomplete | PASS | Server Finance suggestion, selection and itemSelect update, selected value survives reload |
| CSV export | PASS | Filename primefaces-elements.csv, headers Reference/Service/Owner/Status, all four exact record tuples |
| Growl/messages | PASS | Saved/Reset/Confirmed/upload success/extension and size error paths have visible feedback |
| Poll/progress | PASS |8second poll changes count and displayed progress;5point update observed. Full100->0cycle not waited through. |
| ui:repeat | PASS | Five ordered department tags remain correct after AJAX activity |
| Keyboard/reduced motion | PARTIAL | Focus/Enter close modal works with reduced-motion media emulation in all engines; not a full tab/focus-trap/ARIA/screen-reader/animation-suppression audit |

Earlier nonproduction instrumentation attempted to set Elements rows-per-page to2 when only4 was allowed. PF correctly rejected the invalid value with `IllegalArgumentException`; this was a **harness input error**, not a paging defect. Final paging checks use the real Employees paginator. Early menu interaction preceded its fade completion, filter `fill()` omitted keyup, and WebKit in-memory file-buffer automation sent no upload; final checks wait for the real transition, type keys, and select disk files. No direct widget/model mutation is used to claim those UI paths passed.

### Theme, visual and browser findings

**Visual classification: MINOR MIGRATION DIFFERENCES; provisional only, owner/EAP sign-off outstanding.** Actual Saga Blue resources load and PrimeIcons font is used. Five-page desktop captures and Elements1440/900/390width captures exist for all three engines; representative desktop/mobile/dialog/table views were visually inspected. Header, panel/grid layout, forms, buttons, editor, upload, messages and progress are usable. Dark navigation icons are now visible. No broad CSS rework performed.

Remaining differences/limits: Saga's light navigation/rounded paginator and dialog styling override parts of inherited Omega-era CSS; form spacing is generous; narrow tables wrap/truncate headings/statuses and Firefox's calendar trigger wraps at390px. Fixed-width modal has not been accepted on narrow screens. Document scrollWidth equals viewport at tested widths, but that is **not proof all controls/content are unclipped**. The small fixed yellow AJAX-status area is inherited styling. No verified original Omega runtime/screenshots exist, so equivalence cannot be certified. Comprehensive accessibility, all visual states and owner-approved branding comparison remain open.

| Browser | Actual engine/version | Result |
|---|---|---|
| Chromium |156.0.8078.4, Playwright1248 |18/18 grouped checks PASS, console/HTTP/Faces errors0; desktop/responsive captures |
| Firefox |157.0, Playwright1555 |18/18 PASS, errors0; calendar-trigger mobile wrapping retained as visual difference |
| WebKit |27.2, Playwright2370 |18/18 PASS, errors0 with disk-backed file chooser inputs |
| Safari product | Installed browser not driven | **NOT TESTED**; Playwright WebKit is not Safari certification |
| IE | Unsupported by approved MIG-06 decision | NOT APPLICABLE; no IE workarounds reintroduced |

These are tooling-supplied test engines on this host, not a substitute for an approved stable-release/OS support matrix. Reduced-motion interaction success does not prove all transitions honor reduced motion.

### Serialized state, coverage and rollback

**Provisional state risk LOW, confidence MEDIUM; EAP REQUIRES MANUAL REVIEW and cutover REQUIRES SESSION INVALIDATION.** Actual standalone configuration has no application `<distributable>`, no persistent-sessions Undertow setting and transport `none`, no distributed/replicated web cache. The available local passivation cache/file-store in distributable-web configuration does **not** make this application distributable or demonstrate active passivation. Same browser cookie/model was tested across a disposable server restart: model returned to initial values, old session data was not restored. This bounds evidence to the observed single-node runtime; it does not exercise serialization/failover/rolling upgrades.

The four upstream javax-era serialized-lambda signatures remain unchanged. No app usage newly reaches those supplier owners; changing EmployeeBean to serializable ViewScoped stores its view-local Java model, not an upstream lambda. No library patch. At real cutover/rollback, drain and invalidate **this application's** old sessions/Faces views and any operator-managed persistent/replicated stores, with user notification. Do not mix old JavaEE/PF state with the new runtime or perform state-preserving mixed-version rolling deployment without separate proof. EAP actual passivation/replication/topology still requires review.

**Repository automated behavioral tests: zero; Gradle test NO-SOURCE.** The isolated session Playwright harness is executed acceptance instrumentation, not a committed/maintained regression suite. Browser actions plus screenshot inspection above replace neither target EAP tests nor a future maintained suite. Recommended minimum remains target-server startup/deploy, Save/Reset/SearchExpressions, both tables, row expansion, uploads/client+server/boundaries, editor/date/autocomplete/CSV, navigation/dialogs, poll/repeat, supported-browser visual/accessibility and configured session/failover checks.

Rollback remains **PARTIAL / NOT REHEARSED on EAP**. The initial Java21 candidate and pre-MIG-08 PF14Java11/JavaEE WAR/checkpoint hashes above remain preserved; initial candidate now has known table/export/validation defects and is not a production-approved rollback build. Keep the final candidate separately and retain the prior **compatible immutable runtime image** before release. Redeploy a matched runtime/WAR/config pair in an isolated environment, verify fresh-session startup/critical paths, then switch traffic. Never deploy old javax WAR on EAP8 or new Jakarta WAR on EAP7. No database changes, migrations or rollback SQL needed. Configuration rollback must pair prior descriptors/theme/validation settings with its WAR. Old views/sessions must not be reused in either direction. A WildFly restart is not an EAP rollback rehearsal.

### Updated acceptance matrix — provisional column only

| Area | Status | Evidence | Residual Risk | Action |
|---|---|---|---|---|
| Build/Java21 | PASS provisional | Final build/static logs, class major65, actual Temurin21 runtime | Gradle daemon remains JDK11; EAP support unobserved | Preserve toolchain and verify EAP JVM |
| JakartaEE10/Faces4 | PASS provisional | WildFly35 platform, Mojarra4.0.8/modules/lifecycle | Product differences | Repeat on EAP |
| PF15Jakarta | PASS provisional |15.0.16 initialization/resources/interactions | Upstream lambda strings remain | Retain risk review |
| EAP8.1 | BLOCKED | Registry unauthorized historical evidence | Product/runtime unvalidated | Supply entitled provisioned EAP |
| Deployment/descriptors/CDI | PASS WildFly only | Scanner deployed root, Weld5.1.4, management OK | EAP configuration unknown | Repeat startup/deployment |
| AJAX/SearchExpressions | PASS provisional | Actual @this/@form/IDs/process/update/lifecycle assertions | Target-product regression | Replay on EAP |
| Upload | PASS/PARTIAL | Boundary/client+server rejection/listener metadata | Stream contents/hostile-cap paths incomplete | Target replay and deeper limits |
| Editor/tables/calendar/CSV | PASS provisional | Three-engine persistence/data assertions | Edge cases not exhaustive | Maintain regression suite |
| Theme/PrimeIcons | MINOR MIGRATION DIFFERENCES | Captures/visual inspection and targeted icon correction | No original baseline; mobile clipping/wrapping | Owner visual sign-off/EAP replay |
| Browser compatibility | PASS tested engine paths; Safari NOT TESTED |54checks, errors0 | Stable product matrix not approved | Named browser/OS matrix |
| Accessibility/client behavior | PARTIAL | Keyboard close/reduced-motion media interaction | Not full audit; motion suppression unproven | Dedicated acceptance |
| Serialized state | LOW provisional / MANUAL REVIEW EAP | Config + restart probe + prior ownership trace | HA/serialization/rolling unknown | Invalidate old state; inspect EAP |
| Automated tests | NONE in repo | test NO-SOURCE; isolated harness retained | No ongoing regression protection | Separately authorize maintained suite |
| Rollback readiness | PARTIAL | Checkpoint/WAR preservation, local restart | No prior immutable EAP image/rehearsal | Compatible-pair EAP rehearsal |

### Evidence preservation and disposal

Evidence remains in the session directory named above: `pre-mig09-provisional-state.json`, `pre-mig09-provisional-remediation.patch`, `mig09-wildfly-runtime.json`, empty-startup/initial-deployment/final server logs, Java/module/standalone/session/health records; `mig09-provisional-final-build.log`, `mig09-provisional-final-static.log`, `mig09-provisional-browser.py`, `mig09-provisional-browser-results.json`, per-engine AJAX responses/CSV/DOM/screenshots, `mig09-provisional-supplemental-results.json`, original failed attempt logs/results and the validated WAR. Early stack traces are retained, not omitted because fixes passed. Supplemental first restart probe failed solely because Docker reassigned its ephemeral port; corrected probe queries the actual mapping and passed.

`mig09-provisional-evidence-manifest.json` records final artifact hashes; `mig09-provisional-acceptance.patch` preserves this change set without modifying earlier patches. Container is stopped after evidence capture; no shared images/caches/unrelated containers removed. Promote these local artifacts to controlled release storage. **EAP8.1 VALIDATED and ACCEPTED FOR PRODUCTION are not claimed.**

## MIG-09 additive actual EAP8.1 acceptance — 2026-10-27

**Final migration status: TECHNICALLY MIGRATED — EAP RUNTIME ACCEPTANCE INCOMPLETE.** Actual target deployment and functional/browser acceptance now pass; the reason for incomplete acceptance is no longer registry access. A reproducible same-container restart failure, unresolved production cloud configuration and PARTIAL operational rollback prevent production approval. Earlier blocked and WildFly records above remain historical; none is replaced or promoted into EAP evidence.

### Authority, artifact and immutable image identity

The supplied immutable images both resolved/pulled successfully in this environment:

| Role | Exact reference |
|---|---|
| Builder | `registry.redhat.io/jboss-eap-8/eap81-openjdk21-builder-openshift-rhel9@sha256:40f2d11ef2b181330eadb04fc1b89925b91921612f39f72fee475c55a53e06d6` |
| Runtime | `registry.redhat.io/jboss-eap-8/eap81-openjdk21-runtime-openshift-rhel9@sha256:6a3590ad17625af2bffd64d4cd6828da15c56102fcc57fa5c7be9bd4dc662845` |

The worktree Dockerfile was actually the earlier guarded single-stage build, not the multistage description in the request. The user explicitly selected **“Authorize adding the missing multi-stage provisioning using the pinned images.”** Only that authorized builder assembly, EAP8.1 channel/cloud-default-config, `/opt/server` copy and existing ROOT.war/runtime structure were implemented. Existing linux/amd64 platform and UID185 retained; obsolete Compose `EAP_IMAGE` input removed. No Java/XHTML/CSS/dependency changes and no WAR rebuild in this EAP run.

- Command: `docker build --platform linux/amd64 --progress plain -t primefaces-homeoffice:mig09-eap81-acceptance .` — **PASS**.
- Built image/index: `sha256:5c651567391eac85c3bbf185257597768c7ff505e40d120df742e781bd9a43c2`; platform manifest `sha256:2f4d53cdb596f4722be74ba5852cde5cfbaef0b5e0094f20befecd94aefdda66`; config `sha256:8d20796fd46cfdf4445fc8c1f5fad029d339a049dc3658a363394377161a267d`. These local image identifiers are not claimed as published registry references.
- WAR: **4,143,924 bytes**, SHA256 **`e03949114666f2abce73dd9c3f6c3aca933f1db1c1190b1c779c6196304fb5a0`**. Local WAR, previously WildFly-validated WAR and actual deployed ROOT.war are byte-identical.
- Provisioning: channel `org.jboss.eap.channels:eap-8.1`, resolved manifest **1.8.0.GA-redhat-00006**, packs `org.jboss.eap:wildfly-ee-galleon-pack:8.1.1.GA-redhat-00048` and `org.jboss.eap.cloud:eap-cloud-galleon-pack:2.0.0.Final-redhat-00040`; layer **cloud-default-config**, generated standalone.xml and Galleon state retained.
- **Base-image pinning does not freeze channel resolution.** Retain this built image plus resolved installation manifest/artifact streams for release reproduction; a later Docker rebuild may provision a different EAP8.1 update.
- Environment: macOS ARM host/Docker Linux ARM daemon, retained **linux/amd64 emulation**, Docker29.9.2, disposable containers, HTTP published only to loopback. This is actual Red Hat EAP testing, not native production-platform, OpenShift or HA certification.

### Observed runtime and deployment

Versions come from product-info/CLI, Java output, installed module artifacts/manifests and startup logs, not image names:

| Surface | Actual evidence/result |
|---|---|
| Product | **JBoss EAP8.1 Update8.0**, WildFly Core27.1.15.Final-redhat-00001 |
| Java | **Red Hat OpenJDK21.0.12.1+1-LTS**, build Red_Hat-21.0.12.1.1-1 |
| Jakarta platform | **Jakarta EE10** target: EAP8.1 product with Faces4/CDI4/Servlet6 modules below and successful migrated WAR initialization |
| Faces | **Mojarra4.0.11.SP1-redhat-00001** |
| CDI | **Weld5.1.6.Final-redhat-00001**, CDI API4.0.1.redhat-00001 |
| Servlet | **6.0.0.redhat-00007**, Undertow2.3.26.SP3-redhat-00001 |
| PrimeFaces | **15.0.16 Jakarta**, initialization log and actual rendered interactions |
| Fresh server startup | **PASS**: supported launcher admin-configuration phase followed by normal running state, no failed application services |
| Deployment | **PASS**: ROOT.war statusOK, context `/`, CDI/Faces/PF initialized, descriptors parsed, no rollback |
| Namespace/modules | **PASS observed deployment/feature paths**: no javax/jakarta linkage errors, missing application modules or classloader conflicts |

No separate empty-server image was substituted: this Dockerfile embeds ROOT.war. Launcher provisioning/configuration and normal boot completed before acceptance against the deployed application. Successful fresh starts were observed repeatedly; this does not override the failed second startup described below.

### Identical54-check comparison and supplemental checks

The original WildFly harness was copied **byte-for-byte**, verified by hash/comparison, then given the EAP endpoint through its runtime input. Historical `mig09-wildfly-runtime.json`/`mig09-provisional-*` filenames inside the isolated EAP evidence directory are harness compatibility filenames, **not claims that the server is WildFly**. The parent-directory WildFly results were not overwritten.

| Engine | EAP | WildFly baseline | Error counts on EAP |
|---|---|---|---|
| Chromium156.0.8078.4 | **18/18 PASS** |18/18 PASS | page/console/HTTP/Faces-partial-response:0 |
| Firefox157.0 | **18/18 PASS** |18/18 PASS |0 |
| WebKit27.2 | **18/18 PASS** |18/18 PASS |0 |
| Total | **54/54 PASS** |**54/54 PASS** | No check-status differences |

Each grouped check ran in all three engines; PASS means its existing rendered-content/event/assertion criteria, not HTTP200 alone:

| Check | EAP outcome |
|---|---|
| Startup/home/all five pages and CDI rendered data | PASS |
| Menus/navigation | PASS |
| Faces form/save AJAX/growl/messages | PASS |
| `@this`, reset/validation lifecycle | PASS |
| `@form` SearchExpression | PASS |
| Component IDs, `process=`, `update=`, AJAX partial-response lifecycle | PASS |
| Dialog open/confirm/close | PASS |
| Elements sorting/filtering/row-expansion postbacks | PASS |
| Employee sorting/filtering | PASS |
| Pagination | PASS |
| Calendar/dateSelect | PASS |
| Autocomplete/itemSelect | PASS |
| Text editor round-trip | PASS |
| Accepted upload, extension rejection, oversize validation feedback | PASS |
| CSV parsed/exported values | PASS |
| Poll/progress/ui:repeat | PASS |
| Keyboard/dialog focus/Enter with reduced-motion media | PASS within scope; not a full accessibility or motion-suppression audit |
| Visual resource/responsive captures | PASS capture/resource assertions; visual classification below |

Supplemental checks are separate from54 and **do not change that denominator**:

| Check | Result and limit |
|---|---|
| Accepted extensions/boundary | PASS: txt1,048,575bytes, csv1,048,576bytes, pdf32bytes |
| Server `p:validateFile` | PASS: bypass client metadata, upload `.exe`, receive actual Faces validationFailed/error message, preserve prior successful upload status |
| Upload listener/metadata/messages | PASS: actual filename/size/status/success and failure feedback; listener does not consume uploaded stream, so byte-for-byte contents verification remains NOT TESTABLE without new instrumentation |
| Separate employee views in one session | PASS: sorting/filtering one view does not mutate the other |
| Same-container restart | **FAIL — EAP CONFIGURATION ISSUE**, retained below |
| Fresh immutable-container replacement | PASS: same image, healthy deployment, old browser session cookie replaced and old model not restored |
| Distributable/HA failover and mixed-version rolling | NOT TESTABLE in this single-node, non-distributable-app run |
| Database/authentication integration | NOT APPLICABLE: application has neither |

### EAP-specific operational findings — failures are not suppressed

**Same-container restart FAIL:** the cloud launcher reprocesses a configuration already modified by the first startup. Its generated CLI aborts:

```text
Cannot configure jgroups 'kubernetes.KUBE_PING' protocol under 'tcp' stack. This protocol is already configured.
WFLYCLI0002: Error processing CLI script ...
WFLYCTL0002: Error booting the container ...
```

Classification: **EAP CONFIGURATION ISSUE**, cloud-entrypoint/generated-config lifecycle, not an APPLICATION MIGRATION ISSUE. The failed container exited. Recreating from the same immutable application image starts successfully; that is a different operation and is **not** relabeled a successful restart.

A supported `CONFIG_IS_FINAL=true` diagnostic was tried on a fresh instance, with no Dockerfile change. It skipped necessary initial discovery configuration; JGroups failed with `events [FIND_INITIAL_MBRS FIND_MBRS] ... not provided`, and EAP started **with31 services failed/missing**. This workaround was **rejected**, its logs preserved and container stopped. Neither this environment variable nor an entrypoint bypass was committed. Production needs a supported operator/vendor-reviewed idempotent or deliberately finalized configuration procedure and restart/upgrade rehearsal. No broad cloud configuration redesign was attempted.

Other real startup warnings/differences:

- No Kubernetes namespace/service account/API endpoint locally: KUBE_PING attempts `https://null:0/api/v1`, logs UnknownHostException and forms a one-member cluster. Missing service-account CA triggers an insecure trust-manager fallback. This does not constitute validated Kubernetes discovery or secure HA.
- Missing JGroups encryption/cluster authentication and application keystore/self-signed-first-use warnings. Local loopback tests do not approve production transport/management exposure, TLS, credentials or clustering.
- Provisioning logged Apache HttpClient invalid Cloudflare cookie-expiry warnings; dependencies nevertheless resolved and provisioning completed. No datasource dependency is used by this application; default ExampleDS/H2 presence is not application database acceptance.
- Product/Mojarra/Weld/Undertow patch versions, cloud launcher, cluster topology and amd64 emulation differ from the ARM WildFly standalone baseline. Functional check statuses and observed Saga Blue behavior do not differ.

### Saga Blue and browser acceptance

**Visual validation: MINOR DIFFERENCES.** Actual EAP-rendered Saga Blue styles, PrimeIcons/font resources, five-page desktop layout/navigation/forms, dialogs, tables/paginator, calendar, editor, upload, messages and responsive captures were checked with the same harness; representative Chromium desktop/row-expansion, Firefox/WebKit390px, dialog and upload feedback screenshots were visually inspected. No confirmed new EAP-specific visual regression. The earlier unverified original Omega baseline, inherited spacing/colors/overrides, narrow table clipping/wrapping, Firefox calendar-trigger wrapping and incomplete fixed-modal mobile sign-off remain. No redesign or CSS change in this run.

**Browser validation:** Chromium/Firefox/WebKit PASS executed paths. **Safari product NOT TESTED**; WebKit is not Safari certification. IE remains unsupported by the approved decision. Tooling engines do not establish an approved stable-product/version/OS support matrix; full accessibility and actual motion-suppression acceptance remain outside these assertions.

### Actual EAP session configuration and cutover decision

Compared with provisional WildFly, this cloud server really configures distributed web caches and active JGroups:

- App has no `<distributable>` or app-specific session-management override. Undertow default servlet container has no `persistent-sessions` setting; session timeout30minutes, `INGRESSCOOKIE` affinity.
- Distributable-web default Infinispan manager uses web cache container, SESSION granularity/JBoss marshaller and primary-owner affinity. Web default distributed `sessions` cache has owners2, **no store**; legacy `dist` cache has file-store/passivation/purge settings. Presence of that cache is not proof this app passivates.
- TCP/KUBE_PING channel `ee` is CONNECTED but has **one member only**. Available cluster services do not demonstrate replication of this non-distributable application's HTTP sessions. No persistent-session restoration or cross-node failover was shown.
- Fresh replacement with the same browser cookie loses old model and issues a new session cookie. This proves the observed local lifecycle only, not future production HA/persistence behavior.

**Cutover requirement: INVALIDATE ALL EXISTING SESSIONS / VIEWS for this application.** Drain/stop every old application instance; prevent any old persisted/replicated session or Faces state from being restored, using app-scoped storage cleanup/isolation only. Start fresh instances, require a fresh GET/new login if subsequently added, and do not replay old forms. Do not mix JavaEE/PF14 and Jakarta/PF15 nodes in a state-preserving rolling migration. Apply the same boundary on rollback. Current-node replacement is validated; production rolling/HA policy is not.

Four upstream javax-era serialized-lambda strings remain unchanged. Prior ownership review plus this non-distributable app configuration indicates **LOW observed-topology risk, MEDIUM confidence**, not binary serialization compatibility proof. No risk waiver for enabling replication/passivation later; repeat that review and failover tests before doing so.

### Operational rollback — PARTIAL

| Required item | Evidence/requirement |
|---|---|
| Previous deployable | Preserved pre-MIG08 PF14/Java11/JavaEE WAR SHA256 `5dc023c5faf09463f9b71055329314b3b88146bbb06e8f64777293670d388863` and checkpoints; compatible prior EAP7 image/configuration not available/rehearsed |
| Migrated deployable | WAR `e03949114666f2abce73dd9c3f6c3aca933f1db1c1190b1c779c6196304fb5a0`, built image/index `5c651567391eac85c3bbf185257597768c7ff505e40d120df742e781bd9a43c2`, both base digests above |
| Runtime prerequisites | Restore the correct Java/runtime/API family and exact config/secrets; never deploy javax WAR on EAP8 or Jakarta WAR on EAP7 |
| Configuration | Preserve resolved channel installation/provisioning manifests and the immutable built image; keep original pre-launch and actual post-launch configurations distinct. Restore operator-approved platform/TLS/cluster/configuration with its matching image, not a mutable already-adjusted container |
| Sessions/views | Invalidate at both cutover and rollback; do not reuse either version's view/session stores across the boundary |
| Database impact | No database/ORM/schema or persistent business data; no schema/data rollback required |

Procedure: retain verified compatible previous **image+WAR+configuration** before release; drain/stop all current app instances, invalidate/isolate this app's state, then create fresh containers from the retained rollback image with its matching configuration. Check clean server/deployment status, home/navigation/Faces forms/AJAX/upload/tables/CSV and logs; restore traffic only after validation. Do not rely on `docker restart`, rebuild a moving channel for rollback, or swap only the WAR across incompatible runtime families.

Fresh replacement of the current immutable EAP candidate was rehearsed. **Return to the previous runtime/application pair was not**, so readiness is **PARTIAL**, not READY; production approval withheld.

### Evidence preservation and final disposition

Evidence directory: `/Users/amineabri/.copilot/session-state/b576bbf4-7254-42d8-992a-9e42c392510e/files/mig09-eap-pinned/`; build log `../mig09-eap-pinned-build.log`; pre-run state `../pre-mig09-eap-pinned-state.json`.

Retained: both manifest/pull records, application image identity, Galleon/installation inventory and resolved artifacts, Java/product/module/configuration/management records, initial/final server logs, identical54-check harness/results and all three-engine DOM/CSV/AJAX/screenshots, original supplemental restart failure, rejected final-config diagnostic, separate immutable replacement probe/results, actual deployed WAR, `provisioned-image.tar`, evidence hash manifest and `../mig09-eap-pinned-acceptance.patch`. Local archive is a preserved candidate, not an approved production image. Promote to controlled release storage with appropriate access; session-local evidence is not a permanent release registry.

Owned acceptance/diagnostic containers stopped after capture; no shared images/caches or unrelated containers removed. No findings silently closed, historical risks/deferred gates not erased. **EAP startup/deployment and54/54 application checks are now evidenced; full operational acceptance and production approval are not. Stop after MIG-09.**
