# API and namespace compatibility: `<PROJECT_NAME>`

Snapshot/source and target constraint evidence: `<CHECKPOINT_REF>` / `<EVIDENCE_REF>`.

| Finding / module | Used source API/tag/attribute/descriptor | Exact target evidence | Location/usage | Required change or retain rationale | Complexity/risk/confidence | Static gate / runtime assertion |
|---|---|---|---|---|---|---|
| `<FINDING_ID>` / `<MODULE_ID>` | `<RESULT>` | `<EVIDENCE_REF>` | `<MODULE_PATH>` / `<RESULT>` | `<ACTION>` | `<RESULT>` / `<CONFIDENCE>` | `<GATE_ID>` / `<RESULT>` |

## Review surfaces

- Java enterprise API imports, reflection, service providers, binary linkage and dependency-supplied types; distinguish Java SE namespaces and vendor metadata from removed enterprise APIs.
- Descriptors/schemas/context parameters, annotations/injection/discovery, converters/validators/listeners, EL and view namespaces.
- Used UI tag/attribute/event/widget/search-expression APIs and actual lifecycle semantics; check exact target release rather than speculative component replacement.
- Upload limits/client-vs-server validation/content consumers; parsed exports; table sort/filter/row identity; form/model/AJAX/messages/editor/date behavior where used.
- Theme/client resources/CSS/icons/DOM and browser-support boundary.
- Session/view ownership, mutable state, serialized signatures, passivation/replication and mixed-version cutover assumptions.
- Runtime-specific APIs/configuration and native/OS coupling.

## Classification and validation

Classify each item SUPPORTED / DEPRECATED_SUPPORTED / CHANGE_REQUIRED / REMOVED / UNKNOWN with exact evidence. Do not remove supported APIs merely to match a prior plan. Static scans/compilation are separate from deployed rendering, lifecycle and browser assertions.

Residual vendor strings or serialization risks: `<RESULT>` / `<EVIDENCE_REF>` / `<ACTION>`. No blanket prefix replacement or undocumented vendor-JAR patch.

Non-findings: state searched scope, tool/method and limits; "not found" is not proof that an external runtime/configuration cannot use an API.
