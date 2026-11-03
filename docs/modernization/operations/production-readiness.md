# OPS-01 — Production operational readiness

**Recorded:** 2026-10-27. **Application migration: COMPLETE. EAP acceptance: PASS. Production readiness: OPERATIONALLY INCOMPLETE.**

**OPS-03 handover decision, 2026-10-28: NOT READY — OPERATIONAL BLOCKERS REMAIN.** Immutable GHCR image availability reconfirmed without rebuild/deployment; user confirms approved previous-production rollback package is unavailable (**ROLLBACK BLOCKED**). Actual production hostname/CA/DNS/platform, assigned monitoring/on-call ownership and live environment acceptance remain missing. See [go-live readiness](go-live-readiness.md) and the gated [go-live runbook](go-live-runbook.md), including minimal smoke and monitoring handover. Prior OPS-01/02 evidence below remains unchanged historical evidence; no live-production success or risk waiver claimed.

**OPS-02 current disposition, 2026-10-28: OPERATIONALLY INCOMPLETE. LOCAL PRODUCTION-TOPOLOGY TLS VALIDATION: PASS.** Exact image promotion to `ghcr.io/amineabri/primefaces-migration@sha256:63126aa490725adbcf1f02170a251f1d0b949ddaeb6b2c574712c4d864a003fe` retains the validated digest. Following explicit local-only authorization, unchanged EAP behind Nginx/development TLS at **https://localhost:8443** passes27/27 focused browser checks with production-default Secure/HttpOnly/SameSite=Lax cookies. Separate in-container health, local failed-readiness routing, repeated-failure alerts, startup grace, immutable replacement and maintenance-gated cutover pass; old session/model not restored. **ROLLBACK BLOCKED** pending approved previous production pair. Resource/error-rate alerts and durable production supervision/hostname/CA/platform acceptance remain open. No LIVE PRODUCTION TLS VALIDATION claimed. See the latest [production acceptance](production-acceptance.md) addendum; OPS-01 evidence below remains historical.

**Initial OPS-02 attempt, 2026-10-27: BLOCKED.** Image promotion and independent remote inspection passed at2026-10-27T23:43:47Z, but the initially supplied `https://localhost` endpoint refused port443 connections with no local containers. The user subsequently authorized local proxy/TLS provisioning on8443; this historical failure is not erased or relabeled a successful original attempt.

OPS-01 is an operational continuation, not a reopened migration phase. The user selected **single EAP instance on standalone Docker, immutable replacement, TLS at a reverse proxy**. No application Java, Facelets, CSS, dependencies or WAR changes were made. Previous MIG-09 blocked attempts, WildFly results, actual EAP results and checkpoints remain historical evidence in [final acceptance](../migration/final-acceptance.md).

## Validated stack and artifact

| Item | Observed value |
|---|---|
| Server | **JBoss EAP 8.1 Update 8.0**, Core27.1.15.Final-redhat-00001 |
| Java | **Red Hat OpenJDK21.0.12.1+1-LTS**, Red_Hat-21.0.12.1.1-1 |
| Platform | Jakarta EE10 application/API family; operational server provisions only needed web/Faces/CDI services, not every EE subsystem |
| Faces | Mojarra4.0.11.SP1-redhat-00001 |
| CDI | Weld5.1.6.Final-redhat-00001, CDI API4.0.1.redhat-00001 |
| Servlet |6.0.0.redhat-00007; Undertow2.3.26.SP3-redhat-00001 |
| Application | PrimeFaces15.0.16 Jakarta, Saga Blue |
| WAR |4,143,924bytes; SHA256 `e03949114666f2abce73dd9c3f6c3aca933f1db1c1190b1c779c6196304fb5a0` |
| Application identity | Local WAR, WildFly-validated WAR, MIG-09 EAP ROOT.war and OPS-01 deployed ROOT.war are identical |
| Deployment | PASS: ROOT.war/context `/`, CDI/Faces/PrimeFaces initialization; healthy server and no boot errors |
| Prior acceptance | MIG-09 actual EAP54/54, Chromium/Firefox/WebKit PASS; no functional differences from WildFly35.0.1.Final54/54 |
| OPS-01 profile replay | **54/54 PASS**, same byte-identical harness/criteria;18each Chromium156.0.8078.4, Firefox157.0, WebKit27.2 |

OPS-01 replay used a separate diagnostic instance with `SERVER_ARGS=-Dops.session.cookie.secure=false` because WebKit does not retain Secure cookies over the local plain-HTTP endpoint. **This is not a production setting or TLS acceptance.** Production-default instance separately verified Secure/HttpOnly/SameSite=Lax cookies, server configuration, health and lifecycle/session invalidation using Chromium's loopback behavior. No acceptance assertions were removed or weakened. The cookie override must not be used in production.

The local ARM host runs the retained **linux/amd64 image under emulation**. These results do not certify native production performance, capacity, availability or the operating environment.

## Image identity and reproducibility

| Item | Exact identity |
|---|---|
| Builder | `registry.redhat.io/jboss-eap-8/eap81-openjdk21-builder-openshift-rhel9@sha256:40f2d11ef2b181330eadb04fc1b89925b91921612f39f72fee475c55a53e06d6` |
| Runtime base | `registry.redhat.io/jboss-eap-8/eap81-openjdk21-runtime-openshift-rhel9@sha256:6a3590ad17625af2bffd64d4cd6828da15c56102fcc57fa5c7be9bd4dc662845` |
| Locked channel | `org.jboss.eap.channels:eap-8.1:1.8.0.GA-redhat-00006` |
| EAP feature pack | `org.jboss.eap:wildfly-ee-galleon-pack:8.1.1.GA-redhat-00048` |
| Cloud feature pack | `org.jboss.eap.cloud:eap-cloud-galleon-pack:2.0.0.Final-redhat-00040` |
| OPS-01 application image/index digest | **`sha256:63126aa490725adbcf1f02170a251f1d0b949ddaeb6b2c574712c4d864a003fe`** |
| Platform manifest digest | `sha256:193258104ad4478cf8f91849f3133c119fb0bada2be303a5e7bebdd466d52fe5` |
| Image config digest | `sha256:ed8fc11f47e427f38e9a5dc3865ec79242bc89f2f8b987c5250f6bd0ab313b61` |
| Local tag | `primefaces-homeoffice:ops01-eap81` — convenience only, not immutable deployment identity |

The Dockerfile keeps both supplied base digests, builder assembly, `/opt/server` copy, UID185, existing amd64 configuration and unchanged ROOT.war. OPS-01 replaces `cloud-default-config` with explicit **`jsf,bean-validation,management,core-tools,deployment-scanner,logging,health,request-controller`** layers. Their dependency closure provides the application's web/Faces/CDI services without JGroups, Infinispan or distributable-web configuration. This is server configuration, not application modernization. The same pinned cloud feature pack supplies launcher integration; its all-purpose HA configuration layer is no longer selected.

The vendor builder's channel parser accepts the third Maven coordinate as an exact manifest version. The previously moving channel is now pinned to the **same resolved version actually tested in MIG-09**. Installed channel/provisioning records confirm Update8.0 and both feature-pack versions; **269 shared resolved artifact streams retain identical versions** against MIG-09. Preserve those records and artifact streams; retain entitled repository access or a controlled authorized artifact mirror.

This locks dependency selection, **not guaranteed byte-identical Docker rebuilds**: timestamps, installation identity, caches and provenance attestations can affect image bytes. Promote the single tested image rather than rebuilding for each environment. The local index/platform digests above are real, but **no application registry repository was supplied and no image was pushed**. Obtain a controlled registry, push/promote the tested image, record/verify its resulting `repository@sha256:...` identity and archive the image/manifest/WAR/config/source provenance together. Do not invent a published repository digest.

`docker-compose.production.yml` has **no build section** and requires `EAP_APPLICATION_IMAGE`. Use:

```bash
# Set EAP_APPLICATION_IMAGE to the verified published application repository@sha256 digest.
bash operations/eap/replace-container.sh
```

The helper rejects empty/mutable/malformed references, pulls the exact amd64 image before replacement, then uses production Compose `--no-build --force-recreate --wait`. It fails explicitly on pull/start/readiness errors. Registry deployment remains untested until a real destination is supplied; the equivalent fresh-container lifecycle was rehearsed locally by immutable image ID. Retain the last known-good compatible image/config before invoking replacement: a failure after old-container removal can leave this single-instance service unavailable.

## Deployment architecture and restart model

**Architecture A: IMMUTABLE CONTAINER REPLACEMENT.** One EAP instance, one host reverse proxy, no Kubernetes/OpenShift target, no HA/session-replication requirement for this approved topology. Single-instance outage and loss of in-memory drafts during replacement are inherent, not hidden behind a rolling-upgrade claim. A new HA requirement is a separate architecture decision requiring discovery, replication, join/leave/failover and mixed-version policy testing.

**Restart finding: RESOLVED BY IMMUTABLE DEPLOYMENT MODEL.** The new standalone finalized configuration also passes a same-container restart smoke test, but repeated mutable reconfiguration/restart is not the production contract.

### Exact root cause of the historical failure

1. `cloud-default-config` explicitly includes `web-clustering`, distributed-EJB and `os-clustering` features; the provisioned TCP stack is intended to receive discovery configuration from cloud startup scripts.
2. `/opt/server/bin/launch/openshift-common.sh` defaults `CONFIG_ADJUSTMENT_MODE=xml_cli`. `/opt/server/bin/launch/ha.sh` selects `${JGROUPS_PING_PROTOCOL:-kubernetes.KUBE_PING}` whenever the JGroups subsystem exists.
3. First launch adjusts the server's `standalone/configuration/standalone.xml`, adding discovery before normal boot. That XML lives in the container's writable layer; it is **not** reset by `docker stop/start` or `docker restart`, even without a Docker volume.
4. On subsequent startup, the vendor `configure_protocol_cli_helper` in `jgroups_common.sh` tests whether that protocol already exists. If it does, it writes **“Cannot configure jgroups 'kubernetes.KUBE_PING' ... This protocol is already configured”** and issues CLI `quit`, aborting configuration/startup. This is a deliberately non-idempotent configuration path, not a Faces/PrimeFaces defect.
5. A new container gets original image-layer XML, so initial cloud adjustment succeeds. Reusing the old writable configuration causes the duplicate. Kube namespace/API/CA environment variables were also absent locally; that explained discovery warnings but not the duplicate-configuration failure.

Simply setting `CONFIG_IS_FINAL=true` on the old cloud profile was previously rejected: it skipped the **required initial** discovery setup, leaving an incomplete JGroups stack. OPS-01 does **not** repeat that workaround. It first provisions a complete **non-clustered** profile, applies the checked-in build-time CLI configuration, then sets the vendor-supported `CONFIG_IS_FINAL=true` so startup does not reapply environment-based XML/CLI adjustments.

### Implemented deployment controls

- Both Compose definitions explicitly set `restart: "no"`; production creation has no persistent volumes and no runtime build. Never attach `/opt/server`, configuration, data, tmp or deployment directories from an old container.
- Configuration is versioned in the image through `operations/eap/configure.cli`; image replacement replaces configuration too. Bind-address environment values are explicit. Do not override final-config mode, add cloud discovery variables or make persistent ad-hoc CLI edits. Future secrets, if needed, must be external least-privilege inputs, not committed/baked values; none is required by this sample.
- The process runs as UID185, drops capabilities and uses no-new-privileges. Writable logs, temporary uploads and server runtime files are disposable. The app uses sample data/session/view memory only; its upload listener records filename/size/status and does not store a required file or database record. No required application data resides on container disk.
- The lifecycle rehearsal stopped/removed the old container and created a different instance from the **same immutable image**, preserving the fresh configuration hash. Existing browser cookie changed and prior model was not restored. No persistent mounts were present.
- Operational monitor/on-call response must call the replacement helper for **exited or unhealthy** containers, after the configured startup grace, rather than `docker restart`. Docker healthchecks alone do not replace unhealthy containers. **An automatic supervisor/alerting integration has not been installed or rehearsed on a production host**; this remains a release gate. `restart: "no"` deliberately fails closed rather than pretending recovery is configured.

### Clustering decision

**CLUSTERING REQUIRED: NO.** One replica, local sessions, no replica failover promise or sticky-balancing requirement. Reverse proxy routes to the one loopback backend. **No KUBE_PING/JGroups/Infinispan/distributable-web subsystems are configured** in the observed OPS-01 management model. The inherited cloud affinity cookie was explicitly removed; production emits JSESSIONID only, not INGRESSCOOKIE.

There are no Kube discovery, cluster authentication/encryption or service-account CA warnings in the new profile's startup path. Such controls are not “passed HA tests”; HA is **NOT APPLICABLE to this selected topology**. A subscription/vendor support determination for these images on the intended standalone Docker host remains an operator prerequisite; local execution is not a vendor support entitlement certification.

## Session strategy and cutover requirement

| Strategy | Actual configuration/outcome |
|---|---|
| LOCAL | **YES**, application HTTP/session-scoped and Faces view state in the single JVM |
| REPLICATED | **NO**, no clustering/distributable-web services and app has no `<distributable>` |
| PERSISTED | **NO**, no Undertow persistent-sessions setting or session volume |
| PASSIVATED | **NO configured application/session passivation**, no Infinispan/passivation caches in this operational profile |
| Timeout | Undertow default30minutes; session cookie has no persistent Max-Age |
| Cookie | JSESSIONID, Secure, HttpOnly, SameSite=Lax; no custom domain; affinity cookie removed |
| Replacement behavior | Old model lost, old cookie replaced; no cross-version state restoration |

**Mandatory at cutover and rollback: INVALIDATE ALL EXISTING SESSIONS / VIEWS for this application.**

1. Announce a maintenance window and unsaved form/upload/editor/draft loss; remove traffic or put the reverse proxy into maintenance mode.
2. Drain in-flight requests, then stop **all** old application instances before enabling the new version. Audit/remove only this application's old replicated/persisted stores if any exist outside this tested topology; never blanket-delete shared server data.
3. Start fresh instances without reusing old configuration/data/temp/session volumes. Do not restore serialized session/view objects, the old JavaEE/PF14 state, or an earlier production PF6 state. Keep different runtime families isolated.
4. Wait for readiness and require a fresh GET/navigation. An old open Faces form contains stale view-state and must not be replayed; users must reload. Do not silently resume an old view or rely on client cookie expiry to invalidate server state.
5. This application has **no authentication/login integration**. A fresh initial sample session/model is expected, not a “login passed” claim. If authentication is later deployed at the proxy or app, separately specify logout/reauthentication/SSO boundaries.
6. Repeat the invalidation boundary during rollback. No state-preserving mixed-version rolling upgrade is approved.

Historical upstream serialized-lambda signatures remain unchanged, but no cross-version state is carried across this procedure. Future persistence/replication would require a new compatibility/failover assessment; it cannot inherit this local-session result.

## TLS and production security

**Selected TLS termination: host reverse proxy. Status: architecture defined, production TLS NOT CONFIGURED/NOT VALIDATED.** No production certificate was generated. Production hostname, proxy product/configuration, certificate/private-key provisioning, trust/renewal and production host were not supplied.

| Control | Implemented versus required |
|---|---|
| Backend isolation | Both Compose files publish **127.0.0.1:8080 only**. Only the trusted host proxy may reach it. Firewall/network policy must prevent external access or alternate published mappings |
| Management isolation | Actual EAP management binds **127.0.0.1:9990 inside the container**, console disabled, no host port mapping. Access via controlled `docker exec`/local CLI only; do not proxy management/health paths |
| HTTPS enforcement | Proxy must redirect/reject public HTTP and serve only approved HTTPS origin/TLS policy. No direct backend HTTP access for users |
| Proxy forwarding | Undertow `proxy-address-forwarding=true`; proxy must **overwrite**, not append/trust client-supplied, X-Forwarded-For/Host/Proto/Port and validate Host/origin. Only trusted proxy traffic may reach backend; EAP does not supply a proxy-IP allowlist here |
| Session cookie | Actual Secure/HttpOnly/SameSite=Lax response verified. Production default secure=true; the plain-HTTP test override is prohibited in production |
| SameSite policy | Lax chosen for current same-origin app/no login federation. Reassess before cross-site iframe/SSO integrations; do not blindly set None |
| Headers | Proxy must implement approved HSTS (after HTTPS verified; subdomain/preload decisions separately), nosniff, clickjacking/frame policy and Referrer-Policy. Validate resource behavior; CSP needs report-only/design review because Faces/PF inline scripts are present—no untested strict CSP injected |
| Upload/AJAX | Proxy must preserve request bodies/cookies, streamed CSV responses and AJAX timeouts. Align body/request limits with current upload validation so rejected files retain usable feedback |
| Authentication/access | App supplies no authentication/authorization. Owner must decide whether proxy access control is required; anonymous sample functionality is not an authenticated-production security acceptance |

Unused Elytron keystore warnings may remain from default security-layer services; no EAP HTTPS listener/certificate is relied on for termination. Weld reports transactional services unavailable in the minimal profile; this app does not use transactions/database/EJB. These are explicit configuration differences, not application errors.

Before release, run real HTTPS/browser checks through the chosen proxy: certificate/hostname/renewal, redirect and spoofed-forwarding rejection, Secure cookie round-trip, Faces AJAX/upload/CSV behavior, headers, backend isolation and management non-exposure. A local injected forwarded header and cookie response **do not** prove that architecture end-to-end.

## Startup, liveness and readiness

`operations/eap/healthcheck.sh` is copied into the runtime at `/opt/server/bin/ops-healthcheck.sh`:

| Probe | Check and interpretation |
|---|---|
| STARTUP | CLI reports `server-state=running` and local management `/health/ready` returns success, including no boot errors/suspend/deployment health. Conservative: it can wait for deployment as well as server startup |
| LIVENESS | Local management `/health/live` succeeds. Tests server responsiveness independently of whether ROOT is ready |
| READINESS | STARTUP plus exact `/deployment=ROOT.war` status **OK**, then successful root response containing the expected application home title. Open8080 alone or a default welcome page cannot pass |

Docker HEALTHCHECK runs **readiness** every30seconds, timeout25seconds, startup grace120seconds, three retries. Requests and CLI have bounded timeouts. Docker has one health state; an external monitor must distinguish the startup grace, live-server failure and unready deployment before replacing/escalating. These are service checks, not synthetic end-to-end feature coverage or capacity tests.

**Verified negative test:** disable ROOT with the local management CLI; liveness remains success while readiness returns nonzero/HTTP503 even though EAP/8080 are still running. Re-enable ROOT and readiness passes. Fresh creation, replacement and the finalized-profile diagnostic restart all pass startup/readiness. The negative test was performed only on an owned disposable container.

Do not expose unauthenticated management health endpoints externally. The health subsystem's `security-enabled=false` is limited to the loopback management interface so in-container probes work without embedding credentials.

## Rollback rehearsal — BLOCKED

**CURRENT:** PF15 Jakarta / Java21 / EAP8.1 Update8.0, immutable OPS-01 image above.

**ROLLBACK ARTIFACT:** an **approved previous production application + compatible runtime + configuration pair has not been supplied**. The preserved pre-MIG08 PF14/Java11/JavaEE WAR (`5dc023c5faf09463f9b71055329314b3b88146bbb06e8f64777293670d388863`) is an intermediate migration checkpoint, **not automatically an approved previous production release**. Original private PF6.2.30 artifact/provenance remains unavailable.

A new registry manifest request for the historical `registry.redhat.io/jboss-eap-7/eap73-openjdk8-openshift-rhel7:7.3.10-2` tag now **succeeds**. Therefore the blocker is not asserted registry authorization failure: it is missing approved deployable production artifact/hash, matching immutable runtime/platform/Java identity, prior production configuration/secrets and permission to rehearse that actual pair. Manifest accessibility alone does not establish a runnable, approved rollback environment. No incompatible deployment was attempted.

| Rehearsal step | Result |
|---|---|
| Stop/remove migrated container | PASS in controlled current-image replacement rehearsal |
| Invalidate local sessions/views | PASS local model/cookie observations; production cross-family boundary still mandatory |
| Restore previous compatible runtime | **BLOCKED** pending approved prior pair and environment |
| Deploy approved previous artifact | **BLOCKED**; no pre-Jakarta WAR deployed onto EAP8 |
| Verify prior startup/critical application path | **NOT TESTABLE** without the pair |
| Complete reverse-deployment rehearsal | **ROLLBACK REHEARSAL BLOCKED** |

Required controlled rehearsal once supplied:

1. Preserve current image/config and state policy; take maintenance traffic off the application.
2. Drain/stop/remove migrated instance; invalidate only this app's sessions/views/stores.
3. Restore the **previous compatible runtime, Java, image/configuration and artifact together** in an isolated disposable environment first. Never deploy javax WAR on EAP8 or Jakarta WAR on EAP7.
4. Verify clean server startup, deployment, actual previous home/navigation and critical form/AJAX/upload/table paths against its approved baseline.
5. Record exact immutable identities, logs/results, duration and completion; validate the reverse procedure to restore the current approved image.
6. Approve the rollback pair and on-call procedure before public release. No database/schema changes exist in this application, so no database rollback is needed.

Current immutable-image replacement is a **recovery rehearsal, not proof of rollback to a previous production application**. No previous-production success is claimed.

## Test gap and product acceptance limits

**Maintained repository behavioral tests: 0.** The preserved Playwright acceptance harness is executed evidence, not a committed/maintained regression suite. OPS-01 added operational probes/configuration and isolated evidence scripts, not a large test framework or application test suite.

Recommended separately authorized maintained checks: clean EAP startup/deploy/module identity; readiness rejection of undeployed ROOT; home/navigation; Faces `@this`/`@form`/ID process/update lifecycle; upload allow/deny/size/server-validator behavior; editor persistence; table sort/filter/page/expand and per-view isolation; parsed CSV values; session loss across replacement; proxy HTTPS/cookie/forwarding behavior. Run critical browser paths on approved product versions; retain the broader54-check harness as migration evidence.

| Product surface | Disposition |
|---|---|
| Safari product | **NOT TESTED**; WebKit is not Safari certification |
| Accessibility | **PARTIAL / NOT FORMALLY ACCEPTED**; keyboard focus/dialog/Enter and reduced-motion media exercised, not a WCAG or motion-suppression audit |
| Mobile/responsive | Existing narrow table clipping/wrapping, Firefox calendar trigger wrapping, fixed-dialog mobile limits and inherited spacing/colors; no original Omega baseline for equivalence |
| IE | Unsupported by the approved migration decision |
| Product risk acceptance | Owner sign-off for these known limitations and stable browser/version/OS policy **not recorded**; do not infer acceptance |

## Evidence, ownership and final readiness

Session evidence root: `/Users/amineabri/.copilot/session-state/b576bbf4-7254-42d8-992a-9e42c392510e/files/`.

- `mig09-eap-pinned/` and earlier parent files retain original blocked/provisional/actual EAP evidence and old restart/failed-final-config diagnostic; untouched.
- `ops01/` retains exact vendor layer packs, initial/final build logs, product/module/channel/WAR/configuration records, installation/provisioning state, runtime image inspection, cookie/health responses, byte-identical acceptance harness/results/DOM/AJAX/CSV/screenshots, `lifecycle-probe.py`/results/log, historical-runtime manifest access result, final logs, `provisioned-ops-image.tar`, `evidence-manifest.json` and `worktree.patch`. The patch includes earlier uncommitted MIG-09 records plus OPS-01 changes; the earlier MIG-09 patch remains untouched.
- Local image/configuration hashes and evidence are retained; they must be promoted to controlled release storage/registry. Only OPS-01-owned containers were stopped after capture; no shared images/caches or unrelated containers removed.
- Migration records are not relabeled or erased. This report is the current **operational** disposition; it does not undo the user's completed application migration/EAP acceptance.

| Release condition | Status |
|---|---|
| Application migration / EAP feature acceptance | **COMPLETE / PASS** |
| No-cluster immutable profile / health / local-session replacement | **PASS local evidence** |
| Restart finding | **RESOLVED BY IMMUTABLE DEPLOYMENT MODEL**; finalized-profile restart smoke also PASS |
| Pinned dependencies and local application image digest | **IMPLEMENTED**; registry publication/promotion not yet performed |
| Automatic failed/unhealthy-instance replacement and alerting | **NOT DEPLOYED/NOT REHEARSED on production host** |
| Production proxy/TLS/trust/header/capacity/platform/vendor-support acceptance | **INCOMPLETE** |
| Previous-production compatible-pair rollback | **ROLLBACK REHEARSAL BLOCKED** |
| Safari/accessibility/mobile and test gap | Explicit owner risk acceptance/targeted follow-up required |

**Final classification: OPERATIONALLY INCOMPLETE.** No application migration defect was discovered. Remaining release gates are operational and product-risk decisions, not a request for further modernization. **Stop after OPS-01.**
