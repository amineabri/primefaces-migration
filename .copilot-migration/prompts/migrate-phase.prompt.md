---
description: Execute exactly one authorized phase from the selected run's approved dynamic plan.
---

# Execute one phase

Inputs required: actual `<RUN_ROOT>`, generated `<PHASE_ID>` and explicit user authorization for that phase's scope. Missing/ambiguous inputs require clarification, not selection by guess.

Load [README](../README.md), [shared policy](../copilot-instructions.md), [migrator role](../agents/migrator.agent.md) and [migration instructions](../instructions/migration.instructions.md). Load [acceptance](../instructions/acceptance.instructions.md) or [operations](../instructions/operations.instructions.md) instructions only if relevant to this phase.

Read the selected state, approved plan revision, matching findings and latest transformation entries. Verify all prerequisites, gate exceptions, target compatibility, checkpoint and environment permissions. Stop BLOCKED if these cannot be established.

Execute only this phase using exact target evidence and the discovered build/test/static commands. Preserve baseline failures and unrelated work. For every implementation phase, build and test after changes, inspect actual test counts and validate relevant runtime/UI behavior where authorized/available. Never turn NO TESTS, unavailable runtime or missing visual baseline into PASS.

Retain each attempt's commands/results/artifact/environment identity, theme/browser decisions and rollback evidence. Remediate only diagnosed in-scope defects, repeat affected gates and stop for manual decisions when uncertain.

Append an entry using [transformation-log.template.md](../templates/transformation-log.template.md); update state/checkpoints and independent application/runtime/operations summaries from actual results. Report phase outcome, changes, gate statuses/counts, finding dispositions, confidence and risks. **Stop after this phase, even on success.** Do not begin or pre-approve the next phase.
