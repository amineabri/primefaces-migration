# Dependency compatibility: `<PROJECT_NAME>`

Snapshot: `<CHECKPOINT_REF>`. Dependency collection/resolution method and command permission: `<METHOD>`. Target constraints/approval: `<EVIDENCE_REF>`.

| Module/dependency/plugin | Declared source / resolved artifact | Proposed target/classifier/scope | Compatibility | Support/deprecation status | Required replacement/action | Complexity / confidence | Evidence/source date |
|---|---|---|---|---|---|---|---|
| `<MODULE_ID>` / `<DEPENDENCY>` | `<RESULT>` | `<RESULT>` | UNKNOWN until checked | UNKNOWN until checked | `<ACTION>` | `<RESULT>` / `<CONFIDENCE>` | `<EVIDENCE_REF>` |

Compatibility: COMPATIBLE / UPGRADE_REQUIRED / REPLACEMENT_REQUIRED / INCOMPATIBLE / UNKNOWN. Record PRIVATE_INTERNAL provenance/access separately; it is not proof of incompatibility.

## Coverage

Include direct/transitive/runtime/provided/test dependencies, build plugins/wrappers, UI/theme/icon assets and relevant server modules. Distinguish absent declaration from container-provided implementation. Check duplicate API/implementation packaging, namespace/classifier family, Java bytecode and runtime support.

For private/local/vendor artifacts record approved origin, integrity, override precedence and recoverability. Never install a different binary under the expected coordinates. Missing access stays BLOCKED/UNKNOWN.

## Support and replacements

| Dependency | Exact unsupported/deprecated evidence | Replacement / compatibility constraints | Gate / owner |
|---|---|---|---|
| `<DEPENDENCY>` | `<EVIDENCE_REF>` or UNKNOWN | `<RESULT>` | `<GATE_ID>` / `<OWNER>` |

Observed build compatibility does not certify vendor support/security/lifecycle. Age alone is not an unsupported finding. No required replacement is presumed from this template.
