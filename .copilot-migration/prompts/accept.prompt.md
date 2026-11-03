---
description: Assess or execute authorized acceptance for the identified candidate and actual target environment.
---

# Acceptance

Inputs: `<RUN_ROOT>`, acceptance phase ID, candidate artifact identity, actual `<ENVIRONMENT_ID>` and permission scope (report-only or authorized execution).

Load [README](../README.md), [shared policy](../copilot-instructions.md), [acceptance instructions](../instructions/acceptance.instructions.md), [migration field contract](../instructions/migration.instructions.md) and [final acceptance template](../templates/final-acceptance.template.md).

Read the approved plan, state, findings, latest log and retained prior evidence. Verify candidate revision/artifact checksum, exact runtime/JVM/configuration, environment scope and dependencies. Missing target access is BLOCKED; do not provision/substitute/deploy without authorization. Report-only mode must not execute deployment, fault injection or traffic changes.

Validate applicable build, maintained tests, static compatibility, deployment/initialization, actual functional assertions, visuals, required browser products, sessions/cutover and rollback. Derive checks from application features; use justified NOT APPLICABLE for absent features. Keep provisional/local results distinct from required target acceptance.

Generate or append `<RUN_ROOT>/acceptance/final-acceptance.md` without deleting prior attempts. Report actual counts/denominators and failures, untested products, missing maintained tests, visual/accessibility/mobile gaps and residual risk ownership. No fixed acceptance count or preselected result.

Update state/log and choose the acceptance decision supported by mandatory gates. Application migration, target-runtime acceptance and production readiness remain separate. Stop after acceptance; do not promote/deploy to production or start operations implicitly.
