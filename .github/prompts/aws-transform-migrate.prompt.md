---
description: Resume and execute the next gated migration stage for this repository's assessed PrimeFaces/Jakarta/EAP modernization.
agent: aws-transform-migrator
---

Execute the next incomplete migration stage for this repository only after this prompt is deliberately invoked by the user.

1. Read `docs/modernization/migration/migration-state.json` first.
2. Read `docs/modernization/assessment/manifest.json`, then `assessment.json`, `transformation-plan.md`, `findings.md`, and the matching detailed assessment artefacts.
3. Read `.github/instructions/aws-transform-migration.instructions.md` and the matching `aws-transform/eap-primefaces-modernization/migration/.../transformation_definition.md`.
4. Identify the next incomplete stage from state and verify every prerequisite, blocker, prior build/QA gate and Git checkpoint. Read `docs/modernization/migration/theme-browser-gates.md`, including execution addenda, and evaluate `themeState`, `browserSupportState` and the matching `remainingPhaseGates` entry. The Omega static gate was resolved in MIG-04 by user-approved explicit Saga configuration; visuals remain DEFERRED. Revalidate resources/compatibility at every target. Do not infer completion from chat history.
5. Execute only that stage. Use its finding IDs for traceability, preserve behavior, and avoid unrelated refactoring.
6. Run the repository build command `./gradlew clean build`, then `./gradlew test`; report that no automated behavioral suite exists unless tests have since been added.
7. Remediate only clear migration-related failures, rebuild and retest. Stop for manual review when an API, descriptor, deployment or behavior decision is uncertain.
8. Run the stage's manual validation gate. Do not claim deployment success if EAP 8.1 or its image is inaccessible; record `BLOCKED — ENVIRONMENT REQUIRED`.
9. Record the checkpoint, source changes, ATX-FIND IDs, commands, actual results and outcome in `docs/modernization/migration/transformation-log.md`.
10. Update `migration-state.json` with observed current stage, completed/pending/blocked stages, findings resolved/remaining, build/test status and current/target versions.
11. Continue to another stage only if the user requested continuation and the current stage's build, tests, validation and checkpoint all pass. Otherwise stop and report the precise state.

Every MIG-04 through MIG-08 report must include theme compatibility/current/target theme/Omega status/custom CSS impact/visual validation and browser compatibility/IE-specific code/IE impact. Do not silently accept a framework default or use PrimeOne as a literal theme name. Stop on unresolved product IE decisions or static theme incompatibility; runtime visual deferral requires explicit stage-specific acceptance. This prompt's creation/update is not authorization to migrate.

Approved order:

- MIG-00: Baseline.
- MIG-01: PF 6.2.30 → 7.0.
- MIG-02: PF 7.0 → 8.0.
- MIG-03: PF 8.0 → 10.0.0.
- MIG-04: PF 10.0.0 → 11.0.0.
- MIG-05: PF 11.0.0 → 12.0.0.
- MIG-06: PF 12.0.0 → 13.0.0.
- MIG-07: PF 13.0.0 → 14.0.0.
- MIG-08: Atomic PF14 → PF15 Jakarta / Jakarta EE 10 / Java 21 / EAP 8.1 cutover.
- MIG-09: Final acceptance.

Do not add PF9 or represent mixed namespace stages as a completed application. MIG-08 user scope explicitly selected ordered A-F build/static gates, Java21 toolchain and deployment guard pending a provisioned EAP8.1 image; these are conditionally complete. The bare EAP runtime image has no server. Do not remove required EAP_IMAGE guard, provision/start a runtime or execute MIG-09 without new authorization. Current Saga theme name is explicitly saga-blue bundled in core; visuals remain HIGH risk/DEFERRED. Read state for exact evidence and inherited/vendor serialization risks.
