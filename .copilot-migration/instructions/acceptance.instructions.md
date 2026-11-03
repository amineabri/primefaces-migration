---
description: Layered, environment-specific acceptance with explicit tests, runtime, UI, session and rollback evidence.
---

# Acceptance instructions

Load [shared policy](../copilot-instructions.md) and selected run's approved acceptance criteria. Execution requires explicit phase/environment authorization. A report-only review must not deploy or run disruptive probes.

## Establish identity and environment

Record source revision/dirty scope, resolved dependency provenance, artifact checksum, runtime/product/JVM/patch/configuration, OS/architecture, topology, context path and endpoint. Verify the deployed artifact is the candidate. A base image name or static descriptor is not proof of actual initialized runtime versions.

Obtain permission and isolate disposable resources before startup/deployment or fault injection. Record failed starts and warnings. If target runtime/access is unavailable, mark BLOCKED; an authorized alternative runtime is provisional evidence only. Preserve identical assertions for comparisons and version the harness when corrections are necessary.

## Independent acceptance layers

| Layer | Required evidence |
|---|---|
| Build/package | Actual discovered build, bytecode/toolchain, dependency scopes/classifiers, descriptors and artifact identities |
| Maintained tests | Framework/source/result discovery; executed/pass/fail/skip counts and coverage scope; NO TESTS or missing reports explicit |
| Static compatibility | Used Java/taglib/EL/client/descriptor APIs against exact target; application vs vendor/SE findings; no duplicate container APIs |
| Deployment/init | Real deploy/start, CDI/Faces/UI initialization if used, resources/endpoint content and logs, not just open port/HTTP success |
| Functional | Actual user assertions: navigation, form submission/model persistence, AJAX processing/update/reset, validation/messages, table sort/filter/page/row identity, dialogs, dates/editor/autocomplete, upload metadata/content/limits, parsed export and polling/WebSocket **where present** |
| Visual/theme | Baseline provenance, explicit theme resources, icons/fonts/CSS, screenshots/state comparisons, approved differences, clipping/focus/contrast/responsive limitations |
| Browser | Actual product/engine/version/OS and required support matrix; untested product remains NOT TESTED; tooling engine not substitute certification |
| Session/cutover | Actual state ownership/storage/passivation/replication; observed lifecycle behavior; fresh GET/session/views and stale-form handling across incompatible boundaries |
| Rollback | Matched prior application/runtime/config/secrets references and data policy; authorized restoration, startup/user path/monitoring evidence |
| Residual risk | Finding dispositions, missing baseline/suite/runtime/visual/browser/accessibility/mobile/identity checks, owner approval and follow-up |

Derive tests from actual features and data flows; mark absent features NOT APPLICABLE with evidence. Do not invent login/logout, database or upload acceptance for an application without those features. Clearing browser cookies is not server-side logout. A listener invocation is not byte-content validation, and a CSV HTTP response is not a parsed valid export.

Treat serialized session/view compatibility as unproven across incompatible namespaces/frameworks unless demonstrated. Specify drain/invalidation/reauthentication or verified compatible state migration explicitly; clean only app-owned state. No blanket shared-store deletion. Separate current-image replacement from restoration of the approved previous production release.

## Decision and reporting

Use `templates/final-acceptance.template.md`; append attempt records and link raw evidence. Count actual assertions/check instances with denominator definition; do not hard-code a count or report only retries as an all-attempt pass rate. Maintain tests and temporary acceptance harnesses are different assets.

Classify each gate with observed status and scope. Final acceptance is ACCEPTED / ACCEPTED WITH APPROVED RISKS / INCOMPLETE / BLOCKED / REJECTED, with criteria and owner. No target-runtime ACCEPTED if required target checks are blocked/unrun; risk acceptance cannot turn them into PASS. Record application migration, target acceptance and operations separately. Update state/log and stop; no implicit promotion or production release.
