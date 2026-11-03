---
description: Produce or append a repository-specific assessment without transforming the application.
---

# Assess

Load [README](../README.md), [shared policy](../copilot-instructions.md), [assessor role](../agents/assessor.agent.md) and [assessment instructions](../instructions/assessment.instructions.md).

Require the selected `<RUN_ROOT>` and assessment scope. If there is no initialized run, follow [initialize.prompt.md](initialize.prompt.md) instead and stop before transformation. If reassessing an existing run, preserve original reports and write a versioned assessment/manifest; do not reset migration history or approved outcomes.

Inspect the entire target repository afresh using all five assessment templates in `../templates/`. Detect actual build/Java/namespace/UI/theme/runtime, module graph, dependencies/API compatibility, Linux/Windows constraints, persistence/identity/configuration, browser/visual needs, build/tests and environment availability. Cite evidence and distinguish unknowns from proven absences.

Render the assessment, project, findings, dependency and API reports. Provide overall/per-project complexity, readiness, blockers/risks, replacements, automation confidence and evidence-backed best/likely/high engineering hours/days separately from agent execution/calendar estimates. Record commands actually executed, missing permissions and confidence; do not repair source/build/deployment or invent runtime results.

Propose plan changes only as unapproved revisions; use [plan.prompt.md](plan.prompt.md) for detailed planning. Preserve state, append a dated assessment observation to the transformation log and stop. State **ASSESSMENT COMPLETE** and **Migration has NOT started** for a fresh run; for a resumed run report the actual existing execution state instead of denying prior migration.
