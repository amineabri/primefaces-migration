---
description: Optional operational readiness and handover gates for the actual deployment model, without assumed infrastructure.
---

# Operations instructions

Load [shared policy](../copilot-instructions.md), current acceptance and the selected run's plan. Invoke only relevant workstreams. Discover the deployment model first; do not introduce containers, a cluster, a proxy or a platform just because this toolkit describes them.

Document-only readiness review does not authorize deployment, promotion, fault injection or traffic changes. Require named environment, owners, scope, maintenance/cleanup boundaries and rollback before live execution. Unknown inputs remain blockers.

## Release and infrastructure gates

- **Immutable release, if images apply:** verify approved registry/repository, pull access from target platform, source/deployed digest, index/platform identities, architecture and promotion UTC timestamp. Promote the exact accepted image without rebuilding when possible. Base pins do not freeze moving provisioning channels; retain resolved installation/configuration/provenance. A digest-changing rebuild is a NEW IMAGE requiring relevant acceptance again. For non-image deployments, retain immutable artifact/runtime/configuration identities instead.
- **TLS/proxy, if applicable:** real hostname/DNS, trusted CA chain/expiry/renewal, HTTPS redirects/origin, Forwarded/X-Forwarded handling, trusted proxy-only reachability, secure/HttpOnly/SameSite policy appropriate to actual identity flows, session/redirect/Faces resource/AJAX/upload/export and WebSocket/polling behavior where used. No insecure diagnostic override in production. Self-signed/local topology evidence is not live production TLS acceptance.
- **Exposure/trust:** management interface and health visibility, backend isolation, host validation, overwritten untrusted forwarding headers, security headers at correct layer, server-detail exposure and identity ownership. Separate application controls from accepted infrastructure-owned controls with actual owner/evidence; do not inject untested CSP or assume a universal cookie policy.
- **Health/lifecycle:** distinct startup, liveness and readiness criteria; verify actual deployment/content, not just a live process/port. Integrate with real platform routing/recovery. Negative tests must prove unready instances receive no traffic, startup grace prevents premature replacement, liveness failure triggers the approved bounded restart/replacement, and repeated failures alert.
- **Lifecycle model:** decide mutable restart vs immutable replacement from evidence and platform requirements. Container healthchecks alone do not prove recovery. Test intended fresh-instance/restart behavior; do not bypass initial configuration or adopt prior workarounds without proving correctness.
- **Clustering/session:** explicit required/not-required decision, local/replicated/persisted/passivated behavior and compatibility. HA needs discovery/auth/encryption/join/leave/failover and mixed-version policy evidence. Single-node success is not HA proof. Define user-visible session/view loss, sticky routing, downtime and cutover/rollback boundary.
- **Observability:** application/runtime/container-or-service/proxy logs, deployment/probe/restart/replacement events, HTTP error and resource-pressure/certificate alerts. Assign alert recipient/on-call/backup, dashboards, retention/redaction/access, thresholds/windows/minimum-volume/grace/retry cap, escalation and tested notification delivery. Unknown ownership/policy stays UNASSIGNED, not passed.
- **Rollback:** obtain actual approved previous application artifact plus compatible runtime/configuration/version/deployment instructions and secure external references. Never reconstruct from migration history. Rehearse reverse deployment and relevant data recovery, startup, critical path and monitoring. Missing approved pair is BLOCKED. For a first release, require an explicitly approved contingency instead of fabricating a prior release.

## Cutover and go-live runbook

Generate `<RUN_ROOT>/operations/go-live-runbook.md` with concrete commands only after discovering/approving them; before then use explicit unresolved inputs and HOLD status. Include:

1. PRE-CUTOVER: verify immutable identity, infrastructure/config/secrets, real TLS, monitoring/delivery, rollback package/rehearsal, numeric abort criteria and named approvals; announce maintenance and drain old deployment if applicable.
2. CUTOVER: gate traffic, invalidate/migrate sessions/views per assessed policy, deploy accepted release, wait startup/readiness, route only to ready instances, run critical HTTPS smoke and record UTC timings.
3. POST-CUTOVER: inspect logs/alerts/health/session/critical journeys, monitor approved error budget/observation window, obtain business sign-off and record outage/user impact.
4. ROLLBACK TRIGGERS: deployment/startup/readiness failure, critical functional regression, TLS/security failure, sustained owner-defined error threshold or resource/replacement loop; name decision owner and explicit compatible restore procedure.

Do not invent numeric policies or executable prior-release commands. Preserve evidence before removing owned resources.

## Focused smoke and reports

Derive a minimal production smoke from actual critical journeys: HTTPS application content, identity/session and real logout if present, navigation/resources, form/AJAX/validation, uploads, table operations, dialogs/messages and parsed exports if present. It supplements, never replaces, full acceptance. Validate semantic outcomes, not just HTTP status.

Use the production-readiness and go-live-readiness templates. If an exercise is authorized, append `<RUN_ROOT>/operations/production-acceptance.md` with environment/identity, attempt times, commands/results, TLS/proxy/trust, probe integration, controlled cutover, rollback, smoke, monitoring, owners and limitations. Separate local/provisional and real production evidence.

Production status: PRODUCTION READY / PRODUCTION READY WITH KNOWN RISKS / OPERATIONALLY INCOMPLETE / BLOCKED. Go-live status: READY FOR PRODUCTION DEPLOYMENT / READY WITH ACCEPTED RISKS / NOT READY - OPERATIONAL BLOCKERS REMAIN / BLOCKED. A ready decision requires an available validated release, defined live environment/TLS, assigned monitoring/recovery ownership, credible rehearsed rollback (or approved applicable contingency), completed cutover/runbook/smoke gates and no unresolved critical issue. "With risks" still requires mandatory gates and explicit owner acceptance, not hidden blockers. Stop after the authorized operational stage.
