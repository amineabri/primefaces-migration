# Transformation log: `<PROJECT_NAME>`

> Append one record per assessment, phase attempt, decision, acceptance or operational event. Never overwrite failed evidence. Current summaries point to superseding records; old results retain their original scope.

## Initial assessment record

Run/root: `<MIGRATION_ID>` / `<RUN_ROOT>`. Snapshot: `<CHECKPOINT_REF>`. Recorded time: `<TIMESTAMP_UTC>` or UNKNOWN.

Assessment/plan evidence: `<EVIDENCE_REF>`. Observed baseline commands/results: `<RESULT>`. Unexecuted checks and unknown constraints: `<RESULT>`. Current authorization: assessment/planning only. **Migration has NOT started.**

## Event: `<EVENT_ID>` / phase `<PHASE_ID>` / attempt `<ATTEMPT_ID>` (repeat)

| Field | Recorded observation |
|---|---|
| Observed UTC start/end / recorded at | `<TIMESTAMP_UTC>` or UNKNOWN; distinguish observation from report time |
| Authorization / owner / scope / plan revision | `<EVIDENCE_REF>` / `<OWNER>` / `<SCOPE>` / `<PLAN_REVISION>` |
| Prerequisites / decisions / exceptions | `<RESULT>` / `<EVIDENCE_REF>` |
| Before-checkpoint / dirty scope | `<CHECKPOINT_REF>` / `<EVIDENCE_REF>` |
| Module/finding IDs / files changed | `<MODULE_ID>` / `<FINDING_ID>` / actual paths |
| Reason / source -> target / behavior invariant | `<RESULT>` |
| Environment / artifact identities | `<ENVIRONMENT_ID>` / immutable references and actual versions |

| Gate | Actual command / working directory / assertion | Start/end if observed | Exit status / counts / result | Evidence and limitations |
|---|---|---|---|---|
| `<GATE_ID>` / `<CATEGORY>` | `<RESULT>` | UNKNOWN until observed | UNKNOWN until observed | `<EVIDENCE_REF>` |

Record build, maintained tests (NO TESTS when applicable), static, runtime, functional, theme/resource/visual, browser, session/rollback and operations gates separately. Preserve prior diagnostics and remediation/retry rationale.

- Findings resolved/mitigated/remaining, with validation: `<RESULT>`.
- Theme/default/fallback/CSS impact and required browser decisions: `<RESULT>`.
- Residual risks/deferrals, approval owner/record/scope and follow-up gates: `<RESULT>`.
- After-checkpoint/artifact hash/evidence manifest and safe cleanup: `<EVIDENCE_REF>`.
- Outcome: `<STATUS>` from actual phase/gate contract, not prefilled success.
- Supersedes earlier summary (not raw evidence): `<EVIDENCE_REF>` or NOT APPLICABLE.
- Independent application/runtime/production statuses: `<RESULT>`.
- Next gate/blocker and required authorization: `<ACTION>`.

**Stop after the authorized phase/event scope.**
