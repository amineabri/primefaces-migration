---
description: Document or execute explicitly authorized operational readiness stages relevant to the actual deployment.
---

# Operational readiness and handover

Inputs: `<RUN_ROOT>`, actual operational stage/objective and permission scope. Require explicit environment/owner authorization for promotion, deployment, probes, rehearsal or traffic changes; otherwise perform documentation only.

Load [README](../README.md), [shared policy](../copilot-instructions.md), [operations instructions](../instructions/operations.instructions.md), [production readiness template](../templates/production-readiness.template.md) and [go-live readiness template](../templates/go-live-readiness.template.md).

Read plan/state/current acceptance and previous operations evidence. Discover what applies: image/non-image release, registry, actual runtime/platform, real hostname/TLS/proxy, health/replacement, clustering, session strategy, data/identity/configuration and monitoring ownership. Do not instantiate optional infrastructure or infer local exercises as production validation.

For the one authorized stage, document or verify immutable promotion/identity, secure real entry point, trust/exposure, health/recovery, controlled cutover/session boundary, approved prior compatible rollback package/rehearsal, critical production smoke, logs/alerts/resource monitoring and named ownership. No rebuild or artifact change without a proven defect and separately approved remediation/revalidation scope.

Generate/append `<RUN_ROOT>/operations/production-readiness.md`. When exercises occur, append `operations/production-acceptance.md` using the required report sections in operations instructions. Generate `operations/go-live-runbook.md` with PRE-CUTOVER, CUTOVER, POST-CUTOVER, focused smoke, rollback triggers/procedure and monitoring handover using the production template's outline; unknown inputs remain HOLD. Generate `operations/go-live-readiness.md` with exactly one supported decision.

Keep application migration/runtime validation separate from production/handover readiness. Preserve absent rollback packages, unknown owners and residual browser/accessibility/mobile/test gaps explicitly; do not reconstruct prior releases or invent accepted risks. Update state/log. Report decisions and blockers, then **stop after this operational stage**.
