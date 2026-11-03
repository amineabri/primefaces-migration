---
description: Evidence-first Java modernization assessment and dynamic planning; no transformation authorization.
---

# Assessment instructions

Load [shared policy](../copilot-instructions.md). This file applies when explicitly loaded for assessment/planning; it is not an implicit whole-repository edit rule.

## Discover before prescribing

Inspect existing repository guidance (including conventional Copilot configuration if present), all module/build descriptors/wrappers, source/assets, deployment descriptors, container/runtime definitions, tests/CI, existing reports and relevant Git ancestry. Do not assume any file, build system, server or UI framework exists.

Record the following with file/line or observed command evidence and confidence:

| Area | Required discovery |
|---|---|
| Repository/solution | Roots, modules, deployables, languages, physical LOC vs code LOC, exclusions/count method, dependency graph and shared resources |
| Java/build | Build system/wrapper/plugins; source/release/bytecode; build JVM, compiler toolchain and actual runtime JVM; compatibility of each |
| Enterprise/UI | Java EE/Jakarta/other API family and descriptors; configured/resolved server-provided implementations; Faces/UI framework versions/classifiers; actual theme/resources, CSS/icons/fonts and fallback behavior |
| Runtime/deployment | Intended vs observed product/patch, architecture/OS, packaging/context path, supported model, server provisioning, permissions/entrypoint, environment/access availability |
| Dependencies | Direct/transitive/plugin/local/private artifacts, repository provenance, scope/classifiers, duplicate APIs/implementations, support/deprecation evidence, replacements and license/access constraints |
| APIs | Used Java/taglib/EL/client APIs, descriptors, removed/deprecated features, reflection/service-loader/serialization and server-specific coupling |
| OS/Linux | Native libraries, binaries, paths/case/encoding/newlines, shell/service dependencies, filesystem permissions, fonts/timezones, containers/architectures and Windows-only integration |
| Data | Actual database/driver/ORM/schema/migration tooling, transactions, vendor SQL, backups/restore, data compatibility and rollback constraints; record absent only after scoped inspection |
| Identity/configuration | App/proxy identity, SSO/logout, authorization, external config/secrets references, environment dependencies and secure ownership; no credential extraction |
| Product/UI | Required browser products/versions/OS, legacy browser decisions, accessibility/responsive/visual criteria and baseline availability |
| Quality | Baseline build health, tests discovered/executed/coverage reports, manual acceptance, CI evidence freshness, runtime availability; unknown != absent |

Separate declared, resolved, packaged and deployed facts. Exact source/target versions, theme and runtime must be detected/confirmed, not inherited from this toolkit. Targets are proposals until owner constraints/support requirements are confirmed. If target policy is missing, document options and ask; unresolved values block transformation, not creation of an honest assessment.

## Safe assessment execution

Default to read-only inventory. Build scripts/plugins/wrappers may execute code, download dependencies or alter caches/generated outputs. Before baseline commands, inspect them and obtain permission for those side effects when not already authorized. If unavailable/unauthorized, mark build/runtime NOT RUN or UNKNOWN; do not repair build files during assessment. No source, dependency, descriptor, runtime or deployment changes. No credentials, image pulls, provisioning, servers or production probes by assumption.

An unavailable private baseline must not be silently replaced or renamed. Document provenance gaps; propose separately authorized reconstruction with explicit non-equivalence, confidence and risk. Existing successful build messages do not prove a reproducible current build.

## Compatibility, complexity and estimates

Check exact release support/migration documentation or installed artifact metadata; cite source/date and distinguish vendor support from observed compatibility. Unsupported/deprecated/replacement status needs evidence, not "latest is newer." Do not rewrite still-supported APIs just because an old plan suggested removal.

Report overall and per-project complexity with drivers: size/coupling, semantic API changes, data/identity, namespace/runtime boundaries, UI exposure, test safety net and deployment constraints. Record Linux readiness, automation confidence, blockers, risks and unknowns. Confidence is HIGH / MEDIUM / LOW, always explained.

Estimate best/most-likely/high-risk **engineering hours** and days using a stated hours-per-day convention. Break down by module and workstream; explain shared/cross-cutting allocations so totals do not double count. Separately estimate likely agent/tool execution and elapsed delivery window, including environment/QA waits and parallelism assumptions. If evidence is insufficient, use UNKNOWN or a bounded range, not invented precision. Prospective estimates are not actual effort.

## Generate a fresh plan

Generate IDs and an ordered dependency graph from detected constraints; do not prescribe a fixed number of phases. For each phase define objective, source/target constraints, modules/files, finding IDs, prerequisites, scope/exclusions, rollback/checkpoint, build/test/static/runtime/visual/browser/QA gates, owner approvals, completion/stop criteria and estimates.

Possible categories (select only when required): baseline verification/reconstruction, dependency/UI/Java upgrade, enterprise namespace/runtime migration, theme migration, browser support boundary, containerization, runtime acceptance, operations. Prove supported intermediate steps. Couple incompatible namespace/runtime/dependency changes atomically with ordered sub-gates; do not call an uncompilable intermediate state a completed phase.

Explicitly gate removed theme resources/default fallback and product browser-support changes. A framework default is not an approved application theme. A lack of legacy code is not approval to drop a required browser.

## Outputs and stop

Use templates under `../templates/` to generate all five assessment reports, migration plan, fresh state and initial transformation-log entry under `<RUN_ROOT>`. Record inventory/revision/evidence manifest and source/target decisions. Include prospective effort tables in the assessment and plan; separate files are optional.

Initialize state with `migration_started: false`, no completed phase, unknown/unrun gates and unapproved execution. Populate dynamically planned phases; a baseline measurement is not a migration result. Append assessment observations, including failed/unexecuted commands.

Stop after assessment/planning. State **ASSESSMENT COMPLETE** and **Migration has NOT started.** Ask for missing target constraints and plan approval as needed, then request explicit authorization for the first generated phase. Do not begin it.
