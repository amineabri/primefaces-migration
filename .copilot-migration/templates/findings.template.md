# Findings and known risks: `<PROJECT_NAME>`

Snapshot/recorded time: `<CHECKPOINT_REF>` / `<TIMESTAMP_UTC>` or UNKNOWN. IDs are generated for this run and remain stable across revisions.

| Finding ID | Module/location | Evidence and observation | Compatibility/support impact | Severity / complexity / confidence | Required action / owner | Phase/gates | Disposition |
|---|---|---|---|---|---|---|---|
| `<FINDING_ID>` | `<MODULE_ID>` / `<MODULE_PATH>` | `<EVIDENCE_REF>` / `<RESULT>` | `<RESULT>` | `<RESULT>` / `<CONFIDENCE>` with rationale | `<ACTION>` / `<OWNER>` | `<PHASE_ID>` / `<GATE_ID>` | OPEN until evidenced otherwise |

Severity is impact, complexity is implementation difficulty, confidence is evidence quality; do not conflate them. Findings include unsupported/deprecated packages, API/namespace, theme/browser, baseline/runtime access, OS/data/identity/configuration and test/acceptance gaps as actually detected.

## Finding detail: `<FINDING_ID>` (repeat)

- Fact vs inference, exact version/support evidence and affected behavior: `<RESULT>`.
- Source/target compatibility and alternatives: `<RESULT>`.
- Proposed minimal remediation and excluded changes: `<ACTION>`.
- Validation required to resolve, environment and evidence retention: `<GATE_ID>` / `<RESULT>`.
- Blocking dependency / responsible owner / next decision: `<RESULT>`.
- Residual risk if deferred and follow-up gate: `<RESULT>`.

## Risk and deferral register

| Risk ID / finding | Scope and impact | Disposition | Authorized owner / acceptance record / time | Follow-up gate / due condition | Residual risk |
|---|---|---|---|---|---|
| `<RISK_ID>` / `<FINDING_ID>` | `<RESULT>` | OPEN unless explicitly accepted | `<OWNER>` / `<EVIDENCE_REF>` / UNKNOWN if absent | `<GATE_ID>` / `<ACTION>` | `<RESULT>` |

Allowed finding dispositions: OPEN / MITIGATED / RESOLVED / ACCEPTED_RISK / NOT_APPLICABLE, each with evidence. A deferred check remains DEFERRED, not PASS; a textual edit alone does not resolve a finding. Do not copy previous-project IDs, counts or accepted risks.
