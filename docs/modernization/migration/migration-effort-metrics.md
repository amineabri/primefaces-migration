# Migration effort metrics — assessment through OPS-03

## Executive summary

| Metric | Evidence-based result | Confidence |
|---|---|---|
| Migration | **COMPLETE** — application engineering, not production release approval | HIGH |
| Application/runtime validation | **COMPLETE for executed acceptance scope** — actual EAP deployment and critical paths pass | HIGH |
| Operational production readiness | **NOT YET COMPLETE**; OPS-03: **NOT READY — OPERATIONAL BLOCKERS REMAIN** | HIGH |
| Calendar elapsed duration | **125 days, 12 hours, 49 minutes, 22 seconds**, including earlier framework/assessment history and long inactivity | HIGH for recorded boundaries |
| **ESTIMATED ACTIVE ENGINEERING TIME** | **11 hours, 11 minutes, 4 seconds** (11.1845 hours), using commits plus retained execution events | MEDIUM; historical commit-only portion LOW |
| Engineering sessions | **4**, using gaps of at most 45 minutes and a 10-minute allowance per session | MEDIUM as an activity proxy |
| Migration phases | **10** named MIG-00–09 stages: baseline, 8 implementation stages, final acceptance; historical conditional/deferred results retained | HIGH for stage accounting |
| Major technology transitions | **14** explicitly defined boundaries across 5 technology dimensions; not 14 independent projects | HIGH for count/definition |
| Acceptance checks | **135/135** requested final-run checks; **189/189** when the additional OPS-01 replay is included | HIGH for selected successful result sets |
| Migration-related commits | **25** on the current release lineage; 6 belong to the October controlled run | HIGH |
| Files changed | **116 unique project paths**, baseline-to-handover net diff, excluding `.DS_Store` | HIGH |
| Final validated image | `ghcr.io/amineabri/primefaces-migration@sha256:63126aa490725adbcf1f02170a251f1d0b949ddaeb6b2c574712c4d864a003fe` | HIGH |

**The active engineering time is an estimate reconstructed from repository activity and is not equivalent to formal timesheet data.** It mixes interactive/agent work, tool execution, review and short inter-event gaps. It is not measured human labor, CPU time, billing time or a basis for a claimed labor-saving percentage.

The long calendar interval is not a four-month migration implementation claim. The **October controlled assessment-to-OPS-03 response interval is 11h38m29.308s**, or **11h45m24.438s through its persistence checkpoint**. Including only October sessions gives **8h53m36.153s estimated activity**. All three are distinct from the full historical scope above.

## 1. Scope, evidence and chronology

**Frozen repository snapshot:** `bc7ca9c1d9630f2a323096237e8079bdc9448670`, before this report. Worktree was clean at collection. Metrics exclude this report, its JSON companion, subsequent activity, ignored build output and session evidence file volume.

The full reachable Git history contains 36 commits. The current release descends from the June assessment/framework branch `056a3bb`, **not** from the separate June implementation branch `8987f83` through `8251130` and its integration merge `e4669eb`. Both histories were inspected. Primary effort/change totals use the current release ancestry only, so historical alternative changes and duplicate merge content are not counted as current execution.

| Milestone | Timestamp, UTC | Evidence / interpretation |
|---|---|---|
| Original application baseline |2026-06-24T11:10:33Z | `6a5f7bb`; excluded from modernization effort |
| **Migration start: earliest associated modernization work** | **2026-06-24T11:34:49Z** | `b4bccb1`, “add aws transform skills”; framework preparation |
| First historical assessment commit |2026-06-24T11:56:52Z | `dd38aa8`; assessment report, not implementation |
| Last June current-lineage framework/assessment commit |2026-06-24T13:42:17Z | `056a3bb` |
| October controlled assessment request |2026-10-27T12:38:46.562Z | Retained `events.jsonl`, user assessment request |
| Detailed assessment manifest timestamp |2026-10-27T12:52:21Z | `assessment/manifest.json:generated_at`; declared generation timestamp, not end of all assessment work |
| Controlled implementation starts at MIG-00 |2026-10-27T16:03:18.722Z | Execution request followed by build/dependency diagnosis |
| MIG-08 build/static engineering completion |2026-10-27T19:06:25.197Z | Final response; runtime deferred at this point |
| MIG-09 actual EAP acceptance response |2026-10-27T22:51:58.848Z | Actual target startup/deployment and54/54 pass; operations still incomplete |
| OPS-02 final local TLS/cutover acceptance response |2026-10-28T00:09:49.466Z | Local-topology acceptance, not live production |
| **OPS-03 handover completion response** | **2026-10-28T00:17:15.870Z** | Retained final response “OPS-03 COMPLETE” |
| **Migration engineering completion: persisted handover snapshot** | **2026-10-28T00:24:11Z** | `bc7ca9c` records completed OPS-03 artifacts; endpoint used for primary calendar/session metrics |

The final checkpoint is **6m55.130s after the OPS-03 response**. This report does not pretend the checkpoint is a deployment or exact final keystroke. It is the latest dated persistence evidence for completed handover work, used consistently as the primary endpoint. Actual response completion is reported separately. June Git times originally use `+01:00`; all dates here are normalized to UTC. The carried-forward `/init` transcript has an October start without a timezone; it is not substituted for an exact assessment timestamp.

### Evidence inventory

- Full Git history, refs/ancestry, author/committer timestamps, messages and per-commit/baseline diff statistics. All 36 observed commits have matching author and committer timestamps; this does not prove wall-clock accuracy beyond recorded Git metadata.
- `migration-state.json`, `transformation-log.md`, `final-acceptance.md`, `../transformation-report.md`, `../assessment/{manifest,assessment}.json` and assessment reports/plans.
- `../operations/production-readiness.md`, `production-acceptance.md`, `go-live-runbook.md`, `go-live-readiness.md`.
- Retained generated evidence under `/Users/amineabri/.copilot/session-state/b576bbf4-7254-42d8-992a-9e42c392510e/`: `events.jsonl`; `files/mig08*-build*.log`; MIG-09 manifests/build/browser results; `files/ops01/` and `files/ops02/`.
- Calculation artifacts: `files/metrics-git.json`, `metrics-activity.json` and `calculate-migration-effort.py`. The [JSON companion](migration-effort-metrics.json) preserves scoped totals, commit timestamps, sessions, phase details and evidence hashes without copying private keys, credentials or full transcripts.

Generated session evidence is local, **not all committed repository content**. Preserve/promote it to controlled handover storage for independent re-audit. File mtimes were not used as execution timestamps. If retained execution events were unavailable, Git alone would support a materially weaker activity estimate below.

## 2. Phase timeline

Times are observed request-to-final-response boundaries for the October controlled phases, not exact labor intervals. Assessment/framework includes earlier June work and later interleaved planning. OPS-03 additionally includes the persistence checkpoint. **Do not sum phase spans**: long gaps, interleaved planning and checkpoint capture are included.

Checkpoint association means “snapshot containing phase work,” not one phase per commit. `b254429` captures MIG-00–06 together; `de1def5` captures MIG-07/08 and provisional MIG-09; `bc7ca9c` captures actual EAP/OPS work. Independent phase commit timestamps are **UNKNOWN** where Git batches phases.

Dates below are 2026-10-27 unless another date is shown; all UTC.

| Phase | First observed | Last observed | Associated commits | Main files/surfaces changed | Build/test activity; key outcome | Observed span |
|---|---|---|---|---|---|---|
| Assessment / migration framework | Jun 24 11:34:49 | Oct 27 17:20:37.913 | 19 June prep/assessment commits; `03d08b9`, `83b075f`, later gate work in `b254429` | Workflow/skills/Makefile; assessment outputs; GitHub agent/instructions/prompt; runbook/state/theme-browser gates | Inventory/plans/gates produced; no app modernization in assessment |125d5h45m48.913s, **not continuous work** |
| MIG-00 |16:03:18.722 |16:47:48.423 | `84b34d4` initial diagnosis; later reconstruction in `b254429` | Dependency/build/library metadata; state/log | Original6.2.30 build/test fail resolution; approved public6.2 reconstruction builds, runtime deferred |44m29.701s |
| MIG-01 |16:47:48.423 |16:50:29.474 | `b254429` shared | Version catalog, build/library docs, state/log | PF7 build PASS; test NO-SOURCE |2m41.051s |
| MIG-02 |16:52:45.655 |16:55:05.250 | `b254429` shared | Above + `ElementsBean.java`, `elements.xhtml` | PF8 build PASS; upload API/listener migration; test NO-SOURCE |2m19.595s |
| MIG-03 |16:56:33.651 |17:01:46.774 | `b254429` shared | Dependency/build metadata; Elements/Employees tables; state/log | PF10 build PASS; sorting compatibility; test NO-SOURCE |5m13.123s |
| MIG-04 |17:31:26.778 |17:43:37.645 | `b254429` shared | Elements/template/web.xml; theme/icon and table/dialog controls; gates/docs | PF11 initial/final build PASS; owner-approved Saga; visuals deferred |12m10.867s |
| MIG-05 |17:57:44.142 |18:02:11.949 | `b254429` shared | Dependency/build/library metadata and phase gates | PF12 build PASS; exact API/resource checks; test NO-SOURCE |4m27.807s |
| MIG-06 |18:04:16.697 |18:25:36.042 | `b254429` shared | Elements `ui:repeat`/editor height, dependency metadata, IE decision/gates | PF13 build PASS; IE drop explicitly accepted; test NO-SOURCE |21m19.345s |
| MIG-07 |18:29:28.158 |18:47:00.093 | `de1def5` shared | PF14/Java11 build and configured runtime references; gate docs | Build PASS, 11 classes major 55; actual intermediate runtime deferred |17m31.935s |
| MIG-08 |18:48:15.791 |19:06:25.197 | `de1def5` shared | 5 beans' imports; descriptors/Facelets; PF15 Jakarta/EE10/Java21 build/tooling, explicit Saga Blue | A: 2 diagnostic failures; B–F PASS; 11 classes major 65; test NO-SOURCE |18m9.406s |
| MIG-09 |19:07:56.628 |22:51:58.848 | `de1def5` provisional; `bc7ca9c` actual EAP | Scoped upload/list/table/view/form/export/icon/CSS fixes, Docker provisioning, acceptance records | Build/static PASS; blocked attempts retained; WildFly 54/54 then actual EAP 54/54; restart failure handed to OPS |3h44m2.220s |
| OPS-01 |23:02:32.412 |23:25:38.095 | `bc7ca9c` shared | Docker/Compose/channel pin; EAP CLI/health/replacement scripts; readiness report | No WAR rebuild; standalone image builds PASS; 54/54 diagnostic HTTP replay; secure-default lifecycle/cookie probes PASS |23m5.683s |
| OPS-02 |23:35:35.882 |Oct 28 00:09:49.466 | `bc7ca9c` shared | Local Nginx/TLS Compose/supervisor; acceptance report | Exact image promoted, no rebuild; 27/27 focused HTTPS PASS; local cutover/replacement PASS; rollback BLOCKED |34m13.584s |
| OPS-03 |Oct 28 00:11:52.541 |Oct 28 00:24:11 | `bc7ca9c` | Go-live runbook/readiness and current-status pointer | Documentation/remote image availability; no build/deployment; rollback unavailable, go-live NOT READY |12m18.459s through checkpoint; response at 00:17:15.870 |

MIG-00 completion approval at 16:47:48.423 is also the authorization to begin MIG-01; it is a shared boundary, not double-counted activity. Later phases do not imply the old phase-specific runtime deferrals were tested on every intermediate version.

### Historical alternative implementation: not the controlled phases above

The other June branch contains 8 PrimeFaces upgrade commits plus 1 manual-fix commit, 2026-06-24T18:30:33Z–19:48:40Z, followed by merge `e4669eb` on Jun 25 at 11:29:01Z. Those commit subjects report builds, but are **not independent acceptance evidence** for the October release. Current logs explicitly compare/reject some historical assumptions. These 9 non-merge commits and the merge were inspected but excluded from primary effort/change totals; the merge tree duplicates its second parent and must not inflate churn.

## 3. ESTIMATED ACTIVE ENGINEERING TIME

### Method

1. Select the 25 current-lineage modernization commits, excluding original app creation and the alternative implementation/merge.
2. Add retained relevant activity within the scope: 24 top-level user requests, 1,056 tool starts, 1,056 tool completions and 27 final assistant messages. Parent/subagent tool activity is allowed when it is real relevant work; duplicate research user prompts, permissions/hooks/model bookkeeping and metrics-generation activity are excluded.
3. Sort by UTC timestamp. Consecutive events with a gap **<=45 minutes** belong to one session; a gap **>45 minutes** starts another.
4. Session start/end are the first/last observed relevant event. Add **10 minutes after each final event** as the requested review/interaction allowance.
5. Sum session spans plus allowances, not calendar intervals between sessions. Concurrent tools do not add person-hours: this is a wall-clock activity proxy, not the sum of tool runtimes.

The final synthetic 10-minute allowance extends beyond the historical cutoff to 00:34:11; this is **model allowance only**, not observed extra work or inclusion of this metrics task.

| Session | Start UTC | Last observed event UTC | Estimated end including allowance | Estimated duration | Associated phases | Relevant commits/events |
|---|---|---|---|---|---|---|
| S01 |Jun 24 11:34:49 |Jun 24 13:42:17 |Jun 24 13:52:17 | **2h17m28s** | Framework/assessment | 19 June commits `b4bccb1`–`056a3bb`; sparse commit evidence, LOW effort confidence |
| S02 |Oct 27 12:38:46.562 |Oct 27 13:09:04.453 |Oct 27 13:19:04.453 | **40m17.891s** | Controlled assessment | 210 execution/request/final events, no commit during interval; outputs later captured by `03d08b9` |
| S03 |Oct 27 15:39:23 |Oct 27 21:11:37.722 |Oct 27 21:21:37.722 | **5h42m14.722s** | Framework/gates, MIG-00–09 | 1,510 events including `03d08b9`, `83b075f`, `84b34d4`, `b254429`; builds, decisions, provisional runtime work |
| S04 |Oct 27 22:03:07.460 |Oct 28 00:24:11 |Oct 28 00:34:11 | **2h31m3.540s** | MIG-09, OPS-01–03 | 449 events including `de1def5`, `bc7ca9c`; target EAP, operations, promotion/TLS, handover |

**Total:** 40,264.153 estimated seconds = **11h11m4.153s**. **Sessions:** 4. **Average:** 2h47m46.038s. **Longest:** S03, 5h42m14.722s. These are **MEDIUM-confidence estimates**, not measured effort; S01 is LOW confidence because only commits survive.

The model excludes the multi-month gap, the October 13:09–15:39 gap and the 21:11–22:03 gap from session spans. It adds only the prescribed terminal allowances. Gap reasons are **UNKNOWN**; no external-wait invoice or claim of continuous investigation is inferred. Short pauses/waits inside a <=45-minute cluster cannot be separated from real activity and can inflate this estimate; missing unrecorded human work can understate it.

**Git-only sensitivity:** applying the same rule to the 25 commits alone produces **5 sessions**, 2h42m26s observed spans + 50 minutes allowance = **3h32m26s estimated** (LOW confidence). The difference from 11h11m4s is why commit density alone is not reliable labor tracking: most October phase work occurs between only 6 checkpoint commits. The event-enriched estimate is primary because generated execution evidence exists.

**All-history sensitivity:** if “spent” includes the separate, unshipped June implementation and its integration merge, add its commit-only session (18:30:33–19:48:40Z, **1h28m7s including allowance**) and the next-day singleton merge's **10-minute allowance**. That gives **12h49m11.153s across 6 sessions** for all observed modernization history, LOW confidence for the added effort. This is not additional work on the October release and is not included in its primary total. The merge contributes an activity event, not duplicate change churn.

## 4. Human/interactive versus automation

| Work type | What evidence establishes | Time classification / confidence |
|---|---|---|
| Human/interactive | User approvals for baseline reconstruction, Saga/IE decisions, provisional runtime, pinned-image provisioning, single-instance architecture, registry destination and local TLS; results reviewed through gated turns | **Not measurable from repository evidence**, LOW for a duration/split |
| Credential/environment setup | Registry unauthorized earlier, later pulls/push succeed; user supplies digests/destination. Secure setup itself is not recorded as timed labor | **Not measurable**, LOW; do not infer a login/setup duration |
| Agent-led engineering/review | Phase investigations, patches, documentation, decisions and command orchestration visible in execution events | **Estimated mixed activity sessions**, MEDIUM; cannot isolate a human share |
| Individual automated commands/logged stages | Timestamp pairs and emitted duration fields support selected bounded measurements below | **Measured**, HIGH for the stated command/stage, not total automation |
| Total automation/CPU time and elapsed agent execution | Missing starts/ends for some long-running/background work; parallel probes and review overlap | **Not measurable as one exact total**, LOW; do not subtract selected commands from activity to invent human time |

Selected **measured** durations:

| Activity | Observed duration | Evidence / limitation |
|---|---|---|
| MIG-08A builds |1s then2s, both FAILED | `mig08a-build.log`, `mig08a-build-retry.log`; Gradle-emitted durations |
| MIG-08B/C/D/E/F final builds |971ms /631ms /1s /605ms /1s, PASS | Corresponding `mig08*-build.log`; reported Gradle engine time, not complete phase effort |
| MIG-09 initial/final corrected build |772ms /514ms, PASS | `mig09-build.log`, `mig09-provisional-final-build.log` |
| EAP Galleon assembly build step |383.4s | `mig09-eap-pinned-build.log`, step#8; **not whole Docker build time** |
| EAP 54-check invocation with identity comparison |98.291s | Tool interval 22:38:50.280–22:40:28.571Z; includes `cmp`/shell overhead |
| OPS-01 cached final Docker build invocation |8.056s |23:14:46.607–23:14:54.663Z; cached build, not clean-build benchmark |
| OPS-01 harness invocation/copy |104.526s |23:15:56.331–23:17:40.857Z; HTTP-only diagnostic cookie override documented |
| OPS-02 tag/push invocation |8.074s |23:43:31.166–23:43:39.240Z; layers already present; not general registry throughput |
| OPS-02 focused HTTPS smoke invocation |45.190s |23:55:38.769–23:56:23.959Z |
| OPS-02 final local lifecycle probe invocation |113.253s |Oct28 00:05:49.824–00:07:43.077Z; several fault/recovery checks |
| Local planned cutover through smoke |59.60s | `ops02/local-operations-results.json`; includes intentional15s pause; nested in preceding invocation, **do not add twice** |

These intervals are not an exhaustive automation ledger and must not be summed into human savings. Earlier assessment forecasts (25.5/38.5/59 engineering hours and 121/196/312 agent minutes) were prospective estimates for a different scope/uncertainty state, not measured actuals. No “forecast minus agent wall time” labor-saving percentage is defensible.

## 5. Change metrics

**Comparison:** original pre-modernization application `6a5f7bb` to frozen handover `bc7ca9c`. Git text numstat, rename detection 50%, excluded tracked `.DS_Store`; retained legitimate wrapper/tooling. Ignored build output/session logs/images/archives are not repository files. This report's own files are excluded.

| Scope | Commits | Unique changed paths | Additions | Deletions |
|---|---:|---:|---:|---:|
| **Primary baseline-to-handover net diff** |25 current-lineage modernization commits | **116** | **9,878** | **124** |
| Primary cumulative commit churn |25 |128 touched path names / 205 file-change events |10,982 |1,228 |
| October-only net diff, `056a3bb` to handover |6 |64 |7,597 |134 |
| October-only cumulative churn |6 |64 / 102 file-change events |7,793 |330 |
| Separate June alternative implementation/manual fixes, not primary |9 non-merge |21 |132 |119 |

Net additions/deletions compare endpoint contents; cumulative churn counts subsequent editing/deletion of the same lines again. The 128 historically touched path names include renamed/deleted files; this is not 116 semantic net-changed files. Current project inventory of 128 files versus 34 at baseline is a different metric.

| Category, mutually exclusive | Baseline-to-handover paths | Net additions/deletions | Definition |
|---|---:|---:|---|
| Java files modified | **5** |17/17 | `*.java` |
| XHTML files modified | **6** |66/56 | `*.xhtml` |
| Configuration/build/operations files | **35** |869/30 | Remaining build/runtime/XML/YAML/TOML/Gradle/scripts/CLI/Docker/Makefile/ignore paths |
| Documentation/evidence/guidance | **69** |8,921/20 | Markdown/JSON/CSV and report `.gitkeep`; includes workflow/agent guidance, not just reports |
| CSS asset | **1** |5/1 | Stylesheet |
| **Total** | **116** | **9,878/124** | No generated-session artifact count added |

Full-history accounting: 36 reachable commits = original baseline + 25 current-lineage modernization commits + 9 alternative implementation commits + 1 merge. Across all refs there are 34 unique non-merge modernization commits, **not 34 current-release commits**. Merge content is excluded from cumulative primary statistics. Some commits are automatic checkpoints, not distinct engineering deliverables.

### Current-run checkpoint association

All 6 October checkpoint messages are “chore: checkpoint worktree changes”; subjects alone do not identify their phases.

| Commit | UTC timestamp | Contents/phase association | Commit additions/deletions |
|---|---|---|---:|
| `03d08b9` |Oct27 15:39:23 |19assessment documents |2,132/0 |
| `83b075f` |Oct27 15:45:49 | Gated agent/instructions/prompt/runbook/state/log |754/0 |
| `84b34d4` |Oct27 16:14:21 | Initial MIG-00 gate evidence |70/24 |
| `b254429` |Oct27 18:28:09 | Consolidated baseline through PF13, theme/browser gates |1,689/54 |
| `de1def5` |Oct27 22:17:42 | PF14/Java11 then Jakarta/PF15/Java21 and provisional runtime records |1,738/230 |
| `bc7ca9c` |Oct28 00:24:11 | Actual EAP acceptance, Docker/OPS-01–03 and go-live records |1,410/22 |

## 6. Technology and validation metrics

### Boundaries

| Dimension | Evidence-backed transition | Boundary count |
|---|---|---:|
| PrimeFaces | Public reconstructed6.2 →7 →8 →10 →11 →12 →13 →14 →15.0.16 Jakarta; private6.2.30 equivalence **not proven** |8 |
| Java target |8 →11 →21; Gradle 8.4 itself remained on JDK11 with Java21 compiler/toolchain |2 |
| Platform | Java EE8 / javax → Jakarta EE10 / jakarta, Faces4 |1 |
| Actual runtime validation | WildFly35.0.1.Final provisional → JBoss EAP8.1 Update8.0 target; **not an EAP release upgrade count** |1 |
| Theme | Omega → approved Saga → explicit Saga Blue |2 |
| **Total defined boundaries** |5 dimensions; related/overlapping changes, not independent workload units | **14** |

The configured runtime target also changed EAP7.3→8.1, but the prior EAP7 production runtime was not executed in this controlled acceptance. It is not counted again as a second actual runtime-validation boundary.

### Build/test and acceptance results

| Stage | Build/static result | Behavioral-test interpretation |
|---|---|---|
| Assessment/framework | Historical commit subjects claim baseline builds; controlled work produces inventories/plans/gates | No measured behavioral coverage inferred from messages |
| MIG-00 | Initial dependency-resolution FAIL; reconstructed public6.2 final build PASS | Initial test command fails dependency resolution; later test NO-SOURCE |
| MIG-01–07 | Each phase final build/static/WAR PASS | Independent test commands succeed with NO-SOURCE; not passing application tests |
| MIG-08 | A has 2 diagnostic failures; B–F build PASS; final namespace/descriptor/bytecode/WAR checks PASS | Test NO-SOURCE; deferred runtime remains historical |
| MIG-09 | Clean build/static PASS; scoped remediation builds PASS; actual WildFly and EAP deployment PASS | Final selected browser result sets below; original failed runs retained |
| OPS-01 | Operational Docker profile builds PASS; unchanged WAR; local session/cookie/health/replacement checks PASS | Additional54/54 external harness replay, HTTP diagnostic override only |
| OPS-02 | No application rebuild; image promotion exact digest; local TLS/proxy/cutover/replacement PASS |27/27focused HTTPS; production-default cookies; no live-production certification |
| OPS-03 | Documentation/remote-image inspection only; no build/deployment required | Handover NOT READY; rollback package still unavailable |

| Final successful result set | Passed / executed | Scope and evidence |
|---|---:|---|
| Provisional WildFly | **54/54** | `files/mig09-provisional-browser-results.json`, 18 per engine |
| Actual EAP8.1 | **54/54** | `files/mig09-eap-pinned/mig09-provisional-browser-results.json`, 18 per engine; byte-identical harness |
| OPS-02 focused HTTPS | **27/27** | `files/ops02/local-smoke-results.json`, 9 per engine |
| **Requested final-run subtotal** | **135/135 =100%** | Repeated assertions across environments, **not 135 unique scenarios** |
| Additional OPS-01 profile replay | **54/54** | `files/ops01/mig09-provisional-browser-results.json`; explicit HTTP diagnostic scope |
| **Selected successful-run total** | **189/189 =100%** | Includes replay; excludes exploratory failures and uncounted supplemental probes |
| Maintained repository behavioral tests | **0** | Gradle test NO-SOURCE; retained external harnesses are not a maintained suite |

Browsers: Chromium156.0.8078.4, Firefox157.0 and WebKit27.2 in these runs. **Safari product NOT TESTED**; tooling WebKit is not Safari certification. Final run error arrays are empty for recorded page/HTTP/Faces-partial-response checks; no full-history zero-error claim.

Deployment succeeds on actual target EAP. Saga Blue is **MINOR DIFFERENCES** / earlier **MINOR MIGRATION DIFFERENCES**, not original Omega visual equivalence. Accessibility is **PARTIAL / NOT FORMALLY ACCEPTED**; mobile/responsive limitations and owner acceptance remain open. No app login/logout integration exists; local fresh-session checks do not prove authentication/logout.

**Rollback: BLOCKED.** OPS-03 explicitly confirms no approved previous-production artifact/runtime/configuration package. Local same-image replacement/session invalidation is not previous-production rollback. Production readiness is still incomplete despite successful application migration.

**Important pass-rate limitation:**100% describes these selected final successful result files only. Initial browser failures, deployment/configuration diagnostic failures, harness corrections and reruns exist. A complete all-attempt check denominator and global first-pass success rate are **UNKNOWN**; do not report100% for all work performed.

## 7. Blocker and waiting analysis

No separate blocker wait durations were recorded. The interval between “blocked” and “resolved” can contain engineering, unrelated pauses and user work; it is **not assigned wholesale to active effort**.

| Phase | Blocker | Resolution / current disposition | Work/dependency classification |
|---|---|---|---|
| MIG-00 | Private PF6.2.30 unavailable | Explicitly approved public6.2 reconstructed baseline; original equivalence remains unproven | External artifact dependency + engineering diagnosis/approval |
| MIG-00–08 | Compatible prior/target runtime absent | Intermediate runtime gates conditionally deferred; later MIG-09 tests actual target paths | External/operational dependency; static/build work is evidenced, waiting duration UNKNOWN |
| MIG-09 | Red Hat registry unauthorized/entitlement setup | Earlier exact responses preserved; later authenticated pinned pulls succeed | External authentication/access dependency; credential setup time unmeasured |
| MIG-09 | Bare runtime image has no provisioned server | User-authorized multistage Galleon assembly with exact base images | Engineering/configuration remediation |
| MIG-09 | Initial absence of actual EAP acceptance | Authorized provisional WildFly first, then actual EAP54/54 | Runtime/operational dependency + measured acceptance work; WildFly never represented as EAP |
| MIG-09 / OPS-01 | Cloud startup re-adds KUBE_PING on reused writable config | Single-instance decision, no-cluster finalized profile, immutable replacement; diagnostics and historical failures retained | Operational architecture/configuration engineering |
| OPS-01 / OPS-02 | Immutable application registry destination missing | User supplies GHCR; exact validated image promoted, digest matches | Operational input/access dependency + tool execution |
| OPS-02 | No listener/real hostname/TLS proxy | User authorizes local-only Nginx/development TLS;27/27 and local controls PASS | Operational/environment engineering; **not live production acceptance** |
| OPS-01–03 | Approved previous-production rollback package absent | **UNRESOLVED; user confirms BLOCKED** | External operational/release dependency |
| OPS-03 | Real hostname/CA/DNS/platform, assigned monitoring and risk owners missing | Handover runbook produced; go-live **NOT READY** | External operational/business prerequisites |

Measured build/harness/rehearsal execution is activity, not pure waiting. The 45-minute clustering rule can still include unmeasured short waits inside a session; no evidence supports surgically assigning or subtracting those minutes. Multi-month and observed long idle gaps are not charged to the estimate.

## 8. Productivity indicators and confidence

| Derived metric | Value | Confidence / appropriate interpretation |
|---|---|---|
| Named migration stages accounted for |10, MIG-00–09; 8 implementation transitions | HIGH; historical conditional gates retained, no production-readiness inference |
| Operational stages documented |3, OPS-01–03 | HIGH; completion of a report/rehearsal is not production acceptance |
| Defined technology boundaries |14 across 5 dimensions | HIGH for definition; LOW as effort-normalized “complexity” metric |
| Selected final acceptance executions |135 requested / 189 including OPS-01 replay | HIGH for counted result files; not total attempts |
| Selected final-run pass rate |100% | HIGH for selected sets only; all-attempt pass rate UNKNOWN |
| Estimated active hours per named MIG phase | **1.1184h** (about 1h7m6s): 11.1845h /10 | LOW as productivity; numerator includes assessment and OPS, not measured per-phase allocation |
| October-only activity per named MIG phase |0.8893h:8.8934h /10 | LOW; same scope caveat |
| Commits per estimated activity hour | **2.2352**:25 /11.1845 | LOW as productivity; checkpoint batching and historical density dominate |
| Calendar elapsed |125d12h49m22s | HIGH for Git-recorded boundaries; not labor duration |
| Active estimate/sessions |11h11m4s /4 | MEDIUM overall; LOW historical/session granularity; not timesheet data |
| Human versus automation share | **Not measurable** | LOW; no defensible hours split, staffing allocation or savings calculation |
| Total agent/tool execution duration | **Not measurable as one total** | LOW; selected command intervals measured HIGH but partial and overlapping |

The source assessment estimates, fast cached Gradle invocations, number of commits and LOC churn are not independent units of delivered value. Documentation dominates the diff, and strict gates/rework/operations produced value not proportional to code lines. No percentage of “automation savings,” human-equivalent full-time days or total labor cost is asserted.

## 9. Reproduction and limits

The machine-readable companion records the baseline/head, scope, 25 current-lineage commit events, phase spans/change surfaces, session policy/results, selected measured invocations, exact validation counts, change categories and confidence levels. The selected-event hash covers the normalized, cutoff-filtered events, not later appends to the live event log.

To reproduce: enumerate full reachable Git history and ancestry; exclude original app/alternative branch/merge from primary; diff `6a5f7bb..bc7ca9c` with rename detection; categorize paths as above; select timestamped execution events through OPS-03, merge eligible commit events, apply gap 2700s / allowance 600s; verify the four final browser-result files. Do not copy ignored generated artifacts into Git change counts or infer phase timestamps from file mtimes.

Missing/unobserved activity is **UNKNOWN**, not zero. Git timestamps record checkpoints, not starts; agent messages record response completion, not human sign-off duration. The final 10-minute allowance is synthetic and can include no real work. The snapshot after OPS-03 captures earlier uncommitted phase work, not new implementation at its commit time.

**Outcome:** migration and executed application/runtime acceptance complete; operational go-live still **NOT READY — OPERATIONAL BLOCKERS REMAIN**. This metrics exercise changes no application source, validated WAR, image or operational configuration.
