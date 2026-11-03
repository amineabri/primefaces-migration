# Migration Readiness Assessment

## Overall Readiness

**MODERATE — conditional go after prerequisites.** The app is small, target versions and stage sequence are explicitly documented, and migration/assessment definitions and validators exist. The primary limitations are no recorded baseline build, no application behavior tests, no target EAP image/access confirmation, and unverified Java 21 / Jakarta artifact resolution.

| Dimension | Readiness | Evidence |
|---|---|---|
| Scope clarity | READY | Target stack and out-of-scope additions documented in `.aws/atx/.../SKILL.md` |
| Topology | READY | One Gradle WAR, no module graph complexity |
| Source migration | READY WITH VALIDATION | Twelve `javax.*` imports in five files, plus descriptors; finite known surface |
| PrimeFaces path | READY WITH VALIDATION | Eight staged recipe/report pairs; actual component behavior still untested |
| Build | NOT VERIFIED | Gradle 8.4; no build run in this assessment |
| EAP target | BLOCKED PENDING PREREQUISITE | EAP 8.1 image entitlement/access and architecture unknown |
| Test readiness | LIMITED | No automated functional tests or CI found |
| Linux | PARTIAL | Current amd64-only container path; target image not verified |

## Project-Level Readiness

| Project | Status | Entry condition |
|---|---|---|
| `primefaces-homeoffice` | MODERATE | Establish baseline WAR build and smoke test; confirm Maven/local PrimeFaces artifact source; confirm target image and provide manual QA checkpoints |

## Technology-Level Readiness

| Technology | Status | Remaining work |
|---|---|---|
| Java 8 → 21 | CONDITIONAL | Validate Gradle 8.4/build on selected JDK; update wrapper only if necessary |
| Java EE 8 → Jakarta EE 10 | NOT READY FOR CUTOVER | Coordinate API dependency, imports, three descriptors, and server |
| PrimeFaces 6.2.30 → 15.0.16 Jakarta | MODERATE | Execute staged path and verify actual target artifact/APIs |
| EAP 7.3 → EAP 8.1 | PREREQUISITE REQUIRED | Confirm registry access, target image, architecture, filesystem and startup |
| Gradle WAR model | READY WITH CHECK | Preserve one WAR and root deployment; prove build under Java 21 |
| Database/authentication | NOT APPLICABLE | None detected or planned |
| Testing | LIMITED | Manual functional test evidence required at each stage |

## Known Blockers and Prerequisites

1. Confirm EAP 8.1 image registry entitlement and approved immutable tag/digest.
2. Verify target image supports intended architecture and current deployment conventions.
3. Verify PrimeFaces 15.0.16 Jakarta artifact availability/coordinate and local JAR provenance.
4. Record baseline `./gradlew clean build` and current UI smoke test.
5. Confirm Java 21 build tooling and test wrapper 8.4; make any wrapper change evidence-based.
6. Reserve QA capacity to execute the stage gates. No behavioral suite currently automates these checks.

## Manual Decisions Required

- Retain optional private/local PrimeFaces JAR support or use repository artifact only.
- Confirm exact EAP 8.1 image tag/digest and architecture.
- Approve any change to `linux/amd64` after image manifest/host requirements are known.
- Approve whether to add automated tests; current effort excludes introducing a test framework.
- Confirm target descriptor schema forms against EAP 8.1 documentation/runtime.

## Safe for Automated Transformation

- Update version catalog entries and dependency coordinates once exact target versions are approved.
- Replace known Java EE imports in the five bean files.
- Rename known Faces context parameters and servlet class.
- Update descriptor namespace/schema templates and container image string.
- Run scripted scans and validators.

Automation does not decide API method behavior, module classloading, image availability, CSS appearance, or successful server deployment.

## Requires Human Validation

- PrimeFaces file-upload API and end-to-end multipart behavior.
- Component tag/attribute compatibility for date, messages, tables, exporter, editor and autocomplete.
- CDI bean resolution and Faces servlet/Facelets routing.
- Descriptor support and EAP startup logs.
- Java 21 build/runtime and container architecture.
- UI/visual/browser-console regression on all pages.
- Final QA and deployment acceptance.

## Readiness Gate Recommendation

Do not begin migration until baseline evidence, target image access, artifact resolution, and QA availability are recorded. After that, proceed with one version transition at a time and require a passing build and functional gate at every stage. Keep the final Jakarta/EAP/Java 21 cutover as a distinct final gate.
