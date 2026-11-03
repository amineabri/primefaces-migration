# Copilot migration toolkit

A portable, evidence-first workflow for assessing and modernizing Java applications, including Faces/PrimeFaces projects. It supplies reusable agent roles, instructions, task prompts and blank report templates. It is not a migration engine, vendor certification or a pre-approved upgrade recipe. It contains no previous application's versions, artifacts, results or production authorization.

## Quick start

1. Copy `.copilot-migration/` into the target repository without overwriting an existing toolkit.
2. Open Copilot in the target repository.
3. Run `.copilot-migration/prompts/initialize.prompt.md` by attaching/opening it and explicitly asking Copilot to follow it.
4. Review the fresh assessment, unknowns, estimates and proposed phase gates.
5. Approve the migration plan and its target constraints.
6. Run one migration phase at a time with `prompts/migrate-phase.prompt.md`, authorizing a specific generated phase ID each time.
7. Complete acceptance with `prompts/accept.prompt.md`.
8. Complete operational readiness with `prompts/operations.prompt.md` if required.
9. Generate evidence-based metrics with `prompts/metrics.prompt.md`.

**Do not assume values from previous migrations.** Copy the methodology only, not a prior run directory.

## Loading and editor integration

This folder is intentionally standalone. Copilot clients may not auto-discover agents, instructions or prompts outside their conventional configuration directories. Do not assume these files are active just because they exist. The initialization prompt explicitly loads the root policy, relevant instructions, agent role and templates using their repository paths. Later prompts do the same.

In a client supporting prompt files, attach/invoke the chosen file. Otherwise paste its content and ask Copilot to read its referenced files. Agent front matter describes a reusable role, not a guarantee of automatic registration. No command alias or external extension is required.

Do not automatically copy files into `.github/`, `.aws/` or another client's settings. Optional registration requires separate user approval and reconciliation with existing policies. Target-repository instructions and higher-priority safety rules still apply. Stop on conflicting scope or authorization.

## Reusable contents

| Files | Purpose |
|---|---|
| [copilot-instructions.md](copilot-instructions.md) | Shared safety, evidence, status and authorization contract |
| [agents/assessor.agent.md](agents/assessor.agent.md) | Discovery, compatibility, uncertainty and planning role; no transformation |
| [agents/migrator.agent.md](agents/migrator.agent.md) | Exactly one authorized phase, validation and state/log updates |
| [instructions/assessment.instructions.md](instructions/assessment.instructions.md) | Repository inventory, estimates, support evidence and dynamic phase design |
| [instructions/migration.instructions.md](instructions/migration.instructions.md) | Preconditions, checkpoints, build/test loop, namespace/theme/browser gates |
| [instructions/acceptance.instructions.md](instructions/acceptance.instructions.md) | Actual runtime, functional, visual, browser, session and rollback evidence |
| [instructions/operations.instructions.md](instructions/operations.instructions.md) | Relevant release, infrastructure, production and handover gates |
| `prompts/` | Initialization, assessment, plan, one phase, acceptance, operations and metrics entry points |
| `templates/` | Blank assessment, compatibility, plan, state, log, acceptance, readiness and metrics structures |

## Parameters and fresh discovery

Angle-bracket tokens are placeholders, not shell variables, commands or known facts. Replace them only in **generated run artifacts** with evidence-backed values. Keep this toolkit generic. A missing value stays `UNKNOWN` (or JSON `null`), with an owner/action, rather than a guessed default. `NOT APPLICABLE` requires a reason.

| Placeholder | How to resolve |
|---|---|
| `<PROJECT_NAME>`, `<MODULE_ID>`, `<MODULE_PATH>` | Discover build/module/deployable identities; do not infer one module |
| `<MIGRATION_ID>`, `<RUN_ROOT>` | Choose a new run ID and unused output directory; proposed convention `.migration/<MIGRATION_ID>/` |
| `<SOURCE_FRAMEWORK_VERSION>`, `<TARGET_FRAMEWORK_VERSION>` | Inspect resolved/configured framework; target requires constraints/support review and owner agreement |
| `<SOURCE_JAVA_VERSION>`, `<TARGET_JAVA_VERSION>` | Distinguish source, bytecode, build JVM, toolchain and deployed JVM |
| `<SOURCE_PLATFORM>`, `<TARGET_PLATFORM>` | Discover enterprise API family, specification levels and namespace compatibility |
| `<SOURCE_RUNTIME>`, `<TARGET_RUNTIME>` | Inspect declared and actual product/patch/configuration separately; target not presumed |
| `<SOURCE_THEME>`, `<TARGET_THEME>` | Concrete configured theme/resource provenance and approved design decision |
| `<SOURCE_NAMESPACE>`, `<TARGET_NAMESPACE>` | Actual application API/descriptor namespaces; not a blanket prefix replacement |
| `<WAR_NAME>`, `<CONTEXT_PATH>` | Discover only if WAR deployment applies; preserve unless explicitly changed |
| `<BUILD_COMMAND>`, `<TEST_COMMAND>`, `<STATIC_COMMAND>` | Derive safe module-aware commands from wrappers/configuration; do not execute unresolved tokens |
| `<IMAGE_REGISTRY>`, `<IMAGE_REPOSITORY>`, `<IMAGE_DIGEST>` | Approved immutable release identity if images apply; record index/platform identities |
| `<HTTPS_ORIGIN>`, `<ENVIRONMENT_ID>` | Owner-provided environment and actual entry point, not an assumed local substitute |
| `<PHASE_ID>`, `<FINDING_ID>`, `<GATE_ID>` | Generate stable unique IDs from this plan; no preset stage count/sequence |
| `<EVIDENCE_REF>`, `<CHECKPOINT_REF>`, `<OWNER>` | Real retained evidence, recoverable revision and accountable decision maker |
| `<TIMESTAMP_UTC>`, `<STATUS>`, `<RESULT>` | Actual timestamp and controlled observed state, never a prefilled pass |

Additional descriptive tokens in templates name fields to discover, such as `<RATIONALE>`, `<ACTION>` and `<CONFIDENCE>`. Confidence is HIGH / MEDIUM / LOW with evidence and limitations. Clear every required placeholder before approving a generated artifact; unresolved targets block affected execution.

## Generated artifacts and evidence

Initialization proposes an unused `<RUN_ROOT>` and records its actual path in a fresh `migration-state.json`. If multiple runs exist, require the user to select one; never choose the newest by assumption. Subsequent prompts require this path. All paths below are relative to that run root:

```text
assessment/
  assessment-report.md
  project-analysis.md
  findings.md
  dependency-compatibility.md
  api-compatibility.md
migration-plan.md
migration-state.json
transformation-log.md
acceptance/final-acceptance.md
operations/production-readiness.md          (if applicable)
operations/production-acceptance.md         (if exercised)
operations/go-live-runbook.md               (before go-live)
operations/go-live-readiness.md             (if applicable)
metrics/migration-effort-metrics.md
evidence/<PHASE_ID>/<ATTEMPT_ID>/manifest.json
```

Render Markdown templates by replacing tokens and repeating/removing clearly marked rows/sections as the inventory requires. The JSON state template is a **blank initial state**, not a populated plan or JSON Schema. Keep its arrays empty until discovery; populate phase/gate records using the field contracts in the migration instructions and plan template. JSON `null` means unknown; empty arrays mean no records yet, not "no risks."

No separate runbook/production-acceptance template is needed: the operations prompt generates them from the required sections in `instructions/operations.instructions.md` and the runbook outline in `templates/production-readiness.template.md`.

Keep logs, screenshots, command records and result data in attempt-specific directories. A manifest records command/working directory, UTC start/end if observed, exit status, environment, artifact identities, relative evidence paths/checksums and limitations. Preserve failed attempts. For large/binary/sensitive evidence, use approved access-controlled storage and retain redacted references/integrity records in the run. Never commit secrets, TLS private keys, credentials, full session cookies or personal data. Do not invent timestamps for old evidence.

## Phases and approval gates

Assessment generates a dependency-ordered phase graph for actual modules and compatibility boundaries. Possible categories include baseline reconstruction, dependency/UI/Java/namespace/runtime/theme changes, browser-support decisions, containerization, acceptance and operations. Categories are **not mandatory phases**. Do not invent intermediate versions, copy a former version ladder or force a fixed identifier range. Couple changes atomically when the compatibility matrix requires it; document sub-gates and expected intermediate failures without calling them passing checkpoints.

Plan approval is not execution approval. Each invocation authorizes **one identified phase** only. Gate outcomes are PASS, FAIL, BLOCKED, DEFERRED, NOT RUN, UNKNOWN or NOT APPLICABLE; findings/risks have separate dispositions. An absent test suite is `NO TESTS`, not PASS. A required deferred gate blocks phase completion unless an authorized owner explicitly accepts a narrowly scoped conditional transition, with a follow-up gate. Conditional advancement never creates runtime/visual/production acceptance.

Record before/after checkpoints and actual gate results, append the transformation log, update state and **stop after every phase**. An acceptance report's existence is not acceptance, and application migration completion is not go-live readiness.

## Do not copy from previous projects

Do not carry over source/target versions, phase outcomes, state/log histories, finding IDs, screenshots, browser matrices, test counts, local harness assumptions, proprietary artifacts, built WARs/images, digests, registry URLs, credentials, certificates, deployment configuration or approval records. Recreate evidence for the target repository. Neither this toolkit nor a prior report authorizes builds with side effects, downloads, deployments, fault injection, credential changes or production traffic changes.
