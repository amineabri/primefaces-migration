---
description: Generate or revise the phase graph and approval gates from a fresh assessment without execution.
---

# Plan

Load [README](../README.md), [shared policy](../copilot-instructions.md), [assessment instructions](../instructions/assessment.instructions.md), [migration field contract](../instructions/migration.instructions.md) and [plan template](../templates/migration-plan.template.md).

Resolve the actual `<RUN_ROOT>`; read its assessment reports, findings, current state and log. If these are missing, initialize/assess before planning. Ask for unresolved target/product/architecture constraints rather than inheriting defaults.

Create a new plan or a preserved, versioned revision. Determine actual module dependencies, supported intermediate versions, atomic Java/namespace/runtime boundaries and theme/browser decisions. Generate phase IDs/categories and a dependency graph without a preset count or range. Include every phase's prerequisites, finding IDs, scoped files, target matrix, build/test/static/runtime/visual/browser/rollback gates, approvals, stop conditions, checkpoints and estimates.

Reconcile per-project and per-workstream engineering hours/days, best/likely/high cases and shared work. Separate prospective agent/tool execution and elapsed window from engineering effort; explain assumptions/confidence. Runtime absence creates explicit deferred/blocked gates, never a planned success.

Populate pending phase records in state per the field contract without erasing completed/failed attempts. Preserve plan revision/approval history; a revision invalidates affected approvals until reconfirmed, not unrelated observations. Append rationale to the log.

Stop with **PLAN PROPOSED - NOT EXECUTED**. Request explicit approval of the plan revision, then separate authorization for the first eligible phase. Do not start migration.
