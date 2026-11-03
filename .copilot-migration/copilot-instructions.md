# Shared migration contract

Read this policy explicitly for every toolkit task; do not assume editor auto-loading. Resolve the target repository's own instructions first. The toolkit is methodology, not evidence about the target.

- **Assessment before transformation.** Discover actual source/configuration, target constraints and runtime availability. Do not assume values from previous migrations.
- During initialization/assessment/planning, change only new approved run artifacts. Do not edit application source, build/dependency files, descriptors, deployment configuration, existing instructions or historical evidence.
- Generate a fresh dependency-ordered plan and stable phase/finding/gate IDs. Execute exactly one explicitly authorized phase. Creating a prompt/agent/state or approving a plan does not authorize implementation.
- Preserve behavior, deployment invariants and unrelated user changes. No new features, framework replacement, database, authentication, cluster or infrastructure unless the assessed scope and phase authorization require it.
- Before writes, inspect the worktree and record recoverable checkpoints. No commits, destructive reset/cleanup, shared-resource access, deployment or fault injection without relevant permission.
- Use exact artifact/taglib/API/runtime evidence. Distinguish configured, resolved, packaged and observed versions; target intent is not a runtime fact. Do not blindly replay a former migration recipe.
- Build and test after every implementation phase using discovered commands. Record baseline failures and narrowly remediate phase-caused defects. Validate static compatibility and relevant manual/runtime behavior. An empty/skipped test task is not behavioral coverage.
- Treat theme choice/resource changes, browser support removal, Java/build-JVM compatibility, enterprise namespace and runtime boundaries as explicit gates. Stop for unresolved product/security/compatibility decisions.
- Keep static, runtime, functional, visual and operational results separate. Community/provisional runtime evidence is not target-product acceptance. Local TLS is not production TLS. Tooling engines are not untested browser products.
- Preserve every attempt and append corrections; never erase earlier failures. Keep a single explicit current summary pointing to the latest evidence; reconcile state/log/report contradictions with traceable superseding entries.
- State only observed outcomes. Use UNKNOWN for missing facts; NOT RUN for unexecuted checks; BLOCKED for missing prerequisites; DEFERRED only with recorded authority; NOT APPLICABLE with rationale. NO TESTS must remain explicit.
- Resolve a finding only when its required validation is demonstrated. Risk acceptance needs owner, scope, rationale, date and follow-up; it does not change a failed/unrun check to PASS.
- Application migration, target-runtime acceptance and production readiness are independent decisions. Missing required runtime or production gates remain incomplete.
- Maintain `<RUN_ROOT>/migration-state.json` and append `<RUN_ROOT>/transformation-log.md` after each attempt. Stop after the authorized task/phase and report blockers and next gate, without silently starting it.
- Keep secrets outside artifacts; use references and redaction. Collect only authorized evidence. Retain failed logs safely before owned temporary-resource cleanup.

## Evidence and time

For each claim link path/line or command/result/artifact/environment. Record actual UTC timestamps only where observed, identify timezone uncertainty and distinguish generation timestamps from execution/completion. Label confidence HIGH / MEDIUM / LOW with reasons. Separate prospective engineering estimates, agent/tool elapsed estimates, calendar intervals and retrospective inferred activity; none substitutes for a timesheet.

## Run selection

Use the fresh run layout in [README.md](README.md). Every non-initialization prompt must receive the actual `<RUN_ROOT>`, or ask for it if no unique run can be established. If the run does not exist, stop and initialize rather than transforming from an empty state. Never write into a previous project's run or execute a command containing unresolved placeholders.
