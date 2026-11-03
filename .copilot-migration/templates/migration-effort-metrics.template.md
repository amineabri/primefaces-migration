# Migration effort metrics: `<PROJECT_NAME>`

> Evidence-only retrospective. Unknown time/count data remain UNKNOWN. No prior project's duration, phases, transitions or validation counts apply.

## Executive summary

| Metric | Result | Confidence / evidence |
|---|---|---|
| Application migration / target acceptance / operational readiness | `<RESULT>` | `<CONFIDENCE>` / `<EVIDENCE_REF>` |
| Scope start/end and calendar elapsed | `<RESULT>` | `<CONFIDENCE>` / `<EVIDENCE_REF>` |
| ESTIMATED ACTIVE ENGINEERING TIME / sessions | `<RESULT>` | `<CONFIDENCE>` / `<EVIDENCE_REF>` |
| Actual phase count / defined technology boundaries | `<COUNT_OR_UNKNOWN>` | `<CONFIDENCE>` / `<EVIDENCE_REF>` |
| Relevant commits / net files / additions/deletions | `<COUNT_OR_UNKNOWN>` | `<CONFIDENCE>` / `<EVIDENCE_REF>` |
| Validation instances / denominator / pass rate | `<RESULT>` | `<CONFIDENCE>` / `<EVIDENCE_REF>` |
| Validated artifact/image if applicable | `<EVIDENCE_REF>` | UNKNOWN if not established |

**The active engineering time is an estimate reconstructed from repository activity and is not equivalent to formal timesheet data.**

## Scope and timeline evidence

Frozen baseline/head/dirty scope: `<CHECKPOINT_REF>` / `<EVIDENCE_REF>`. Branch inclusion, alternative-history/merge handling, reporting-task exclusion and evidence availability: `<METHOD>`.

| Milestone | Observed UTC timestamp or UNKNOWN | Evidence | Confidence/limitation |
|---|---|---|---|
| Earliest scoped modernization/preparation | `<TIMESTAMP_UTC>` | `<EVIDENCE_REF>` | `<CONFIDENCE>` |
| Actual transformation start | `<TIMESTAMP_UTC>` | `<EVIDENCE_REF>` | `<CONFIDENCE>` |
| Application/runtime completion | `<TIMESTAMP_UTC>` | `<EVIDENCE_REF>` | `<CONFIDENCE>` |
| Requested handover/scope completion | `<TIMESTAMP_UTC>` | `<EVIDENCE_REF>` | `<CONFIDENCE>` |
| Persistence checkpoint, if later | `<TIMESTAMP_UTC>` | `<EVIDENCE_REF>` | Not the same as actual response/deployment time |

Calendar difference/formula and excluded intervals: `<METHOD>`. Calendar is not labor; date-only headings/file mtimes are not exact event times.

## Dynamic phase timeline

| Phase | First/last observation | Commits | Files changed | Build/test activity | Outcome | Observed span | Confidence/evidence |
|---|---|---|---|---|---|---|---|
| `<PHASE_ID>` | UNKNOWN until evidenced | `<EVIDENCE_REF>` | `<RESULT>` | `<RESULT>` | `<STATUS>` | `<RESULT>` | `<CONFIDENCE>` / `<EVIDENCE_REF>` |

Repeat actual phases only; batched commits do not prove exact phase boundaries. Do not sum overlapping phase elapsed spans as active effort.

## Activity sessions

Method: eligible relevant events sorted in UTC; consecutive gap <=45 minutes -> same session; gap >45 minutes -> new session; first/last observed event define span; add 10 minutes after each session's last event. Document event selection, deduplication, optional execution-log enrichment, concurrency, missing history and synthetic allowance past cutoff. Provide Git-only sensitivity if relevant.

| Session | Observed start | Observed end | Allowance / estimated end | Estimated duration | Phases | Relevant events/commits |
|---|---|---|---|---|---|---|
| `<SESSION_ID>` | `<TIMESTAMP_UTC>` | `<TIMESTAMP_UTC>` | 10 minutes / `<TIMESTAMP_UTC>` | `<RESULT>` | `<PHASE_ID>` | `<EVIDENCE_REF>` |

Total seconds/hours: `<RESULT>`. Session count: `<COUNT_OR_UNKNOWN>`. Average/longest: `<RESULT>`. Confidence/rationale: `<CONFIDENCE>` / `<RATIONALE>`. Excluded long gaps and unmeasurable short waiting: `<RESULT>`.

## Human and automated work

| Activity | Measured / Estimated / Not measurable from repository evidence | Duration/bounds | Evidence / confidence / overlap |
|---|---|---|---|
| Human prompting/review/approvals/environment decisions | `<RESULT>` | UNKNOWN unless independently measured | `<EVIDENCE_REF>` / `<CONFIDENCE>` |
| Builds/pulls/startup/static/browser/harness invocations | `<RESULT>` | `<RESULT>` | `<EVIDENCE_REF>` / `<CONFIDENCE>` |
| Total exclusive agent/tool elapsed | `<RESULT>` | UNKNOWN if partial/overlapping | `<EVIDENCE_REF>` / `<CONFIDENCE>` |

Nested/parallel intervals are not additive. Do not subtract selected tools from inferred activity to invent human labor; do not compare mixed wall time directly to forecast labor savings.

## Change metrics and technology transitions

| Scope | Relevant commits | Unique changed files | Additions/deletions | Method/evidence |
|---|---|---|---|---|
| Endpoint diff | `<COUNT_OR_UNKNOWN>` | `<COUNT_OR_UNKNOWN>` | `<COUNT_OR_UNKNOWN>` | Frozen baseline/head, rename/binary/generated exclusions |
| Cumulative churn | `<COUNT_OR_UNKNOWN>` | `<COUNT_OR_UNKNOWN>` | `<COUNT_OR_UNKNOWN>` | Separate from net change, no duplicate merge content |

Categorize Java, UI templates, config/build/operations and documentation/evidence with explicit mutually exclusive path rules. List actual framework/Java/platform/runtime/theme boundaries and count definition; do not preset versions or count related changes as independent projects.

## Validation and blockers

| Phase/run/environment | Build/static outcome | Maintained tests vs acceptance counts | Functional/visual/browser/deployment/rollback scope | Evidence |
|---|---|---|---|---|
| `<PHASE_ID>` | `<RESULT>` | `<COUNT_OR_UNKNOWN>` | `<RESULT>` | `<EVIDENCE_REF>` |

State selected final-run vs all-attempt denominator, temporary harness vs maintained coverage, actual browser products, residual visual/accessibility/mobile/session/production gaps and rollback status.

| Blocker | Phase | Issue/resolution/current state | Engineering/external/operational dependency | Wait-time evidence/confidence |
|---|---|---|---|---|
| `<RESULT>` | `<PHASE_ID>` | `<RESULT>` | `<RESULT>` | UNKNOWN unless directly measured |

Do not charge entire blocked calendar spans as active effort.

## Derived indicators and limitations

Report phase/boundary/check counts, pass rates, estimated hours per phase and commits per inferred hour only where supported. State every denominator and caveat; checkpoint cadence is not productivity proof. Engineering/day forecasts remain prospective, not observed activity.

| Time/derived metric | Value or UNKNOWN | Confidence | Evidence/limitations |
|---|---|---|---|
| Calendar interval | `<RESULT>` | `<CONFIDENCE>` | `<EVIDENCE_REF>` |
| Active estimate/sessions | `<RESULT>` | `<CONFIDENCE>` | `<EVIDENCE_REF>` |
| Human/automation split | `<RESULT>` | `<CONFIDENCE>` | `<EVIDENCE_REF>` |
| Derived ratios | `<RESULT>` | `<CONFIDENCE>` | `<EVIDENCE_REF>` |

Optional JSON companion fields: start/end UTC, calendar seconds, estimated active seconds, session count/list/method, phase metrics, frozen refs, commit count/list, change metrics/categories, validation counts/scope, evidence hashes and confidence. Unknown numeric values are null, not zero. Preserve source evidence without copying secrets/full transcripts.
