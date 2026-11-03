---
description: One-phase execution, compatibility gates, checkpoints and evidence tracking for a freshly approved plan.
---

# Migration instructions

Load [shared policy](../copilot-instructions.md). Require actual `<RUN_ROOT>` and `<PHASE_ID>`; do not guess the run or copy a previous sequence.

## Preconditions and checkpoint

1. Read the selected run's state, exact approved plan revision, findings and latest transformation entries. Reconcile outdated summaries before acting; preserve old evidence.
2. Verify explicit authorization for this phase, dependency gates and target decisions. Plan approval alone is insufficient. A prerequisite may be conditionally traversed only with a recorded owner-approved exception and named follow-up gate; it remains incomplete evidence.
3. Inspect current diff/baseline failures and preserve unrelated changes. Record a recoverable before-checkpoint (revision plus scoped dirty patch/artifact references where needed), without creating commits unless requested.
4. Verify artifact access/provenance, tooling, environment permission, data/session strategy and rollback prerequisites. Missing or conflicting prerequisites mean BLOCKED; ambiguous scope/behavior means manual decision.

## Execution loop

Resolve approved dependencies -> build using `<BUILD_COMMAND>` -> classify failure -> make only deterministic, in-scope corrections -> rebuild -> execute `<TEST_COMMAND>` and inspect counts -> static compatibility via `<STATIC_COMMAND>` or documented inspection -> relevant functional/visual/browser/runtime gates -> after-checkpoint -> append log/update state -> **STOP**.

Choose real commands from assessment; unresolved placeholders are not executable. For multiple modules, validate changed modules and affected consumers, escalating as needed. Record command, directory, environment, UTC observed start/end, exit status, result counts and logs. A missing test framework is NO TESTS, a skipped/empty task is not a behavioral pass, and a passing process exit does not prove its assertions.

Do not apply a broad namespace search/replace: distinguish Java SE packages from enterprise APIs, application-owned references from vendor metadata, and names in serialized state/reflection/services from live API links. Validate dependency coordinates/classifiers, compile/runtime levels, descriptors/schemas, Facelets namespaces, provided-vs-packaged APIs and actual initialization. Avoid duplicate container implementations.

Preserve behavior; inspect exact target taglibs/APIs and evidence before changing components, EL, events, widgets, converters, upload semantics, exports or scopes. A successful compiler does not exercise view rendering/lifecycle, mutable collections, session/view ownership or resource loading.

## Theme/browser gates

Before and after every affected UI phase record configured concrete theme, framework default, packaged/served resources, CSS/icon/font dependencies and fallback status. Missing resources or implicit fallback are uncontrolled visual changes, not PASS. Obtain approval for replacement/design changes.

Record the required browser product/version/OS matrix and target support evidence. A support removal requires a product decision even when no browser-specific code is found. Classify workarounds REMOVE / RETAIN / REPLACE / UNKNOWN with evidence; do not remove speculative "legacy" code.

Keep static theme compatibility separate from runtime resource/visual validation. Capture relevant screens/interactions, breakpoints, keyboard/focus, messages/dialogs/tables/forms and changed controls. No runtime means DEFERRED/NOT RUN, never visual equivalence. Carry missing baseline, accessibility and responsive gaps forward explicitly.

## State and phase field contract

`templates/migration-state.template.json` supplies safe initial values. Populate `phases` with one object per actual planned phase; do not retain sample completed phases. Required fields:

| Field | Contract |
|---|---|
| `id`, `category`, `title`, `plan_ref` | Unique generated ID, actual category, objective and approved plan reference |
| `depends_on`, `finding_ids`, `affected_modules` | Arrays of real IDs; no dangling references/cycles |
| `status` | PENDING / IN_PROGRESS / COMPLETE / CONDITIONAL / BLOCKED / FAILED |
| `authorization` | Object with `status` (NOT_REQUESTED / REQUESTED / GRANTED), `owner`, `record_ref`, `scope`, `at`; null unknown fields |
| `before_checkpoint`, `after_checkpoint` | Real recoverable references or null; no invented commits |
| `gates` | Array of gate records defined below |
| `attempt_refs`, `risk_ids` | Append evidence/log references; preserve earlier attempts and risks |
| `started_at`, `finished_at` | Observed UTC values or null, never inferred file mtimes |

Each gate object has `id`, `category`, `required` (boolean), `status`, `criteria`, `environment_ref`, `evidence_refs`, `counts` and `exception_ref`. Categories distinguish build, maintained tests, static, deployment, runtime, functional, visual, browser, session, rollback and operations. Gate status: UNKNOWN / NOT_RUN / PASS / FAIL / BLOCKED / DEFERRED / NO_TESTS / NOT_APPLICABLE. Counts use null for unknown, zero only for observed zero. An exception changes advancement permission, not the status of an unrun/failed check.

Keep current source/target context in state, append history/log references, update `current_phase_id` and the independent summary statuses. Risk/deferral records require ID, owner, scope, disposition, evidence, acceptance reference and follow-up gate; acceptance fields remain null unless granted.

## Completion, failures and rollback

COMPLETE requires all required gates PASS or justified NOT APPLICABLE and retained checkpoint/evidence. CONDITIONAL requires explicit phase-scoped approval of deferred validation, a named follow-up gate and residual risk; it is not final acceptance. Empty tests need an explicit alternative QA disposition, not a synthetic test pass.

Retry only after a diagnosed bounded correction; keep original failures and changes traceable. Stop for ambiguous API/security/product decisions, unresolved baseline failure, inaccessible target, unsafe checkpoint, conflicting user changes or unauthorized scope expansion.

For rollback, use the actual compatible checkpoint/artifact/runtime/configuration and data/session policy. Roll back only owned changes with permission; never reset unrelated work. Rerun prior relevant gates and preserve failed logs. A source checkpoint is not a rehearsed previous-production rollback. Stop after the phase, including when it passes; request new authorization before any next phase.
