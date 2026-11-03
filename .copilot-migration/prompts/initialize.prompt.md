---
description: Initialize a fresh evidence-based assessment and migration plan; stop before transformation.
---

# Initialize a new migration

Follow this prompt only when deliberately invoked by the user.

**Do not assume values from previous migrations.**

1. Inspect the target repository and its applicable instructions. Load [toolkit README](../README.md), [shared contract](../copilot-instructions.md), [assessor role](../agents/assessor.agent.md) and [assessment instructions](../instructions/assessment.instructions.md). If any required file is unavailable, stop and report it; do not silently use a previous project's policy.
2. Inspect Git/worktree state and existing migration artifacts. Propose a fresh `<MIGRATION_ID>` and unused `<RUN_ROOT>` following the README convention. Verify the destination is unused before writing. If a run already exists, ask whether to resume the identified run or initialize a distinct one; never overwrite it. Record the chosen path in the fresh state.
3. Perform a fresh whole-repository assessment. Detect build system/modules, Java source/build/toolchain/runtime versions, enterprise namespaces, UI framework/theme, packaging, runtime/deployment model, dependencies, APIs, data/ORM, identity/configuration, OS/Linux constraints, browser needs, tests, build health and runtime availability. Distinguish declared/resolved/observed facts and absent/unknown evidence.
4. Detect actual source and target constraints from this repository and owner requirements. Ask focused questions for missing target versions, platform, browser/theme or scope decisions; document unresolved choices explicitly. Never assume a target release, version ladder, phase count, test count, runtime/image or production topology. Do not execute code/builds with side effects, resolve private artifacts or deploy without applicable authorization.
5. Read these templates and render fresh artifacts under the chosen run root:
   - [Assessment report](../templates/assessment-report.template.md) -> `assessment/assessment-report.md`
   - [Project analysis](../templates/project-analysis.template.md) -> `assessment/project-analysis.md`
   - [Findings](../templates/findings.template.md) -> `assessment/findings.md`
   - [Dependency compatibility](../templates/dependency-compatibility.template.md) -> `assessment/dependency-compatibility.md`
   - [API compatibility](../templates/api-compatibility.template.md) -> `assessment/api-compatibility.md`
   - [Migration plan](../templates/migration-plan.template.md) -> `migration-plan.md`
   - [Initial state](../templates/migration-state.template.json) -> `migration-state.json`
   - [Transformation log](../templates/transformation-log.template.md) -> `transformation-log.md`
6. Generate a fresh dependency-ordered phase graph and estimates from the assessment. Load [phase/state field contract](../instructions/migration.instructions.md) to populate proposed phase records, but do not execute it. Set `migration_started` false, plan approval NOT_REQUESTED and each phase PENDING with authorization NOT_REQUESTED; gates remain UNKNOWN/NOT_RUN unless a permitted measurement was actually performed. Generate IDs from this plan; leave no copied outcomes.
7. Record source revision, inventory/LOC method, evidence locations, confidence, blockers, known risks, prospective engineering hours/days and separate agent/tool/elapsed estimates. Initial log records assessment observations, not migration completion. A failed baseline remains a finding, not permission to repair it.
8. **Stop before making migration changes.** Do not edit application source, build/dependency/configuration/descriptors, deployment, existing instructions, evidence or previous runs. This invocation permits only new assessment/planning/state artifacts.
9. Report **ASSESSMENT COMPLETE** and **Migration has NOT started.** Present the proposed sequence, unknowns, first phase's exact ID/scope/gates and request plan approval plus explicit authorization to begin that phase. Do not infer either approval from this initialization request.
