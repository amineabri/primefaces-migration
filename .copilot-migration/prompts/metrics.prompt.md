---
description: Reconstruct calendar, activity, change and validation metrics from scoped repository and retained run evidence.
---

# Migration metrics

Load [README](../README.md), [shared policy](../copilot-instructions.md) and [metrics template](../templates/migration-effort-metrics.template.md). Resolve `<RUN_ROOT>` and the requested start/end scope; do not assume the previous project's duration, branch, stage count or outcomes.

Do not change source, build, deployment, state or prior evidence. Write only a new/versioned `<RUN_ROOT>/metrics/migration-effort-metrics.md` and optionally a matching JSON companion. Freeze the analyzed head, baseline and dirty-state inventory before generating this report; exclude reporting's own churn.

## Evidence and timeline

Inspect full available Git history/refs, timestamps/messages/ancestry, assessment records, plan revisions, state, transformation log, acceptance, operational/handover reports and retained generated logs/results. No external timesheet/session access is implied. Report shallow/missing history, timezone uncertainty and unavailable evidence explicitly.

Identify earliest supported effort event and latest supported scope completion. Distinguish original app history, framework preparation, actual transformation and persisted completion checkpoints. Separate alternate branches/duplicate merge content, resumed runs and historical assessments; state inclusion rules and give sensitivity totals if meaningful. Do not infer timestamps from file mtimes, date-only headings or a report's existence.

Produce a dynamic per-phase table: first/last observation, associated commits, changed files, build/test activity, outcome, observed span and confidence. Batched checkpoints do not create exact phase times; missing values are UNKNOWN. Phase elapsed spans are not active labor and may overlap.

## ESTIMATED ACTIVE ENGINEERING TIME

Use selected relevant commit events, optionally enriched by timestamped retained run activity; disclose both sources and selection/deduplication. Sort chronologically in UTC. Consecutive gaps **<=45 minutes** remain in one session; a gap **>45 minutes** starts another. First/last event define observed session start/end; add a **10-minute allowance after the final event** of each session.

List session ID, observed start/end, allowance/estimated end, duration, associated phases and commits/events. Calculate total, count, average and longest. Label the allowance synthetic (including any extension past scope cutoff); exclude metrics-task events. Do not sum concurrent command spans as additional person-hours. Explain short waits may inflate and unrecorded work may understate the proxy. Provide Git-only sensitivity if enriched activity materially changes the result. No usable timestamps means UNKNOWN, not invented sessions.

Explicitly state: **The active engineering time is an estimate reconstructed from repository activity and is not equivalent to formal timesheet data.**

## Changes, validation and blockers

Calculate relevant commits, unique endpoint-diff files, additions/deletions, Java/UI/config/build/documentation categories and cumulative churn separately. Specify baseline/head, rename/binary/generated-file policy and module scope; do not count the same merge changes twice.

Derive actual framework/Java/platform/runtime/theme transitions; define each counted boundary. Summarize builds/failures by phase, maintained tests, runtime/deployment/functional/visual/browser/operations evidence, assertion counts, selected runs vs all attempts, residual gaps and rollback disposition. Do not hard-code counts or conflate grouped checks with unique features/tests. A selected successful rerun pass rate is not the all-attempt rate.

Identify blockers, phase, issue, resolution/current state and engineering vs external/operational dependency. Do not assign blocked calendar spans as active work. Waiting duration is UNKNOWN unless directly evidenced.

Separate human/interactive, automation/tool invocation and agent elapsed where evidence supports it: Measured / Estimated / Not measurable from repository evidence. No exact split without bounded timestamps; nested/parallel intervals are not additive. Do not subtract selected automation durations from session spans to invent human labor or compare inferred mixed activity directly to forecast labor savings.

Useful derived ratios (hours/phase, commits/hour, check pass rates) require explicit denominator/scope/caveats; omit or mark UNKNOWN when unsupported. Every time metric gets HIGH / MEDIUM / LOW confidence and evidence rationale. Separate retrospective metrics from prospective assessment estimates.

Report current application/runtime/operations status from evidence, not assumed completion. Validate arithmetic, timestamp scope, session grouping and file scope; stop after the metrics report.
