# Modernization Transformation Plan

**Target:** PrimeFaces 15.0.16 Jakarta, Jakarta EE 10, JBoss EAP 8.1, and Java 21; retain Gradle WAR packaging, existing pages/sample behavior, and root context `/`.

**Status:** Assessment and planning only. Do not execute migration transformations until this plan and the estimates are approved.

## Guardrails and entry criteria

- Run one version step at a time. Complete the matching functional QA checkpoint before starting the next step.
- Keep the project as a single Gradle WAR. Do not add a database, ORM, authentication, REST API, messaging, monitoring, CI/CD, Kubernetes, or new business behavior as part of this migration.
- Preserve `ROOT.war` and the `/` context root.
- Use the matching recipe under `aws-transform/eap-primefaces-modernization/migration/` and inspect its paired assessment before running it.
- Before stage 1, record a clean baseline build result and capture a manual smoke-test baseline across all five pages. Confirm artifact resolution, including whether the optional private PrimeFaces JAR is present.
- Confirm registry access and the exact supported EAP 8.1 Java 21 runtime image before the final stage. The current container definition is `linux/amd64`.
- If an AWS Transform run or local tooling is unavailable, stop at that stage and report the blocker; do not silently skip a QA gate.

## Recommended migration sequence

| Order | Stage | Main transformation | Gate before next stage |
|---:|---|---|---|
| 0 | Baseline and prerequisites | Build current WAR; record baseline UI and toolchain; confirm access to repositories and eventual EAP target image | Baseline WAR builds and current app smoke test is recorded |
| 1 | PrimeFaces 6.2.30 → 7.0 | Update artifact and address any changed component syntax | Build; test all pages and shared navigation, including date/upload basics |
| 2 | PrimeFaces 7.0 → 8.0 | Apply stage-specific API/tag changes, especially file upload and component attributes | Build; test upload, date control, tables, exporter and editor |
| 3 | PrimeFaces 8.0 → 10.0.0 | Apply known API updates and obsolete uploader configuration changes | Build; verify table filters/sort, upload and visual/theme rendering |
| 4 | PrimeFaces 10.0.0 → 11.0.0 | Upgrade library and address any version-specific component changes | Build; smoke test all pages and client-side behavior |
| 5 | PrimeFaces 11.0.0 → 12.0.0 | Verify exporter, upload, editor, data table and bundled client-library behavior | Build; export data, submit editor, test upload and browser console |
| 6 | PrimeFaces 12.0.0 → 13.0.0 | Apply stage migration and file-upload API checks | Build; exercise upload listener and affected controls |
| 7 | PrimeFaces 13.0.0 → 14.0.0 | Remove/replace deprecated components where required; review table expressions and styles | Build; date selection, messages, table behavior and visual comparison |
| 8 | PrimeFaces 14.0.0 → 15.0.16 Jakarta + EAP 8.1 / Jakarta EE 10 / Java 21 | Make coordinated namespace, dependency, descriptor, build, and container cutover | Build WAR, deploy/start target image, verify namespace integrity and full smoke test |
| 9 | Final acceptance | Review changes and evidence, repeat all-page and operational checks on target | QA sign-off and approved deployment/release decision |

The staged path intentionally jumps from PrimeFaces 8 to 10; the repository's migration skill states there is no normal public 9.x stage in this path.

## Detailed transformation work

### 0. Baseline

1. Run the existing Gradle build using the declared supported JDK and preserve its result.
2. Record current dependency resolution and check whether `libs/primefaces-6.2.30.jar` is present; if so, identify its provenance and make sure later stage artifacts are available through the same intended source.
3. Smoke test Home, Dashboard, Employees, Reports, and Elements. Capture the core Elements behaviors: validation/messages, AJAX controls, date picker/calendar, tables and filtering, CSV export, text editor, file upload, dialogs, and progress/polling.
4. Confirm access to the target Red Hat registry/image and target architecture before investing in the final cutover.

### 1–7. PrimeFaces-only stages

For each stage, update only the dependency and source/UI changes required by that stage's transformation definition. Build immediately after transformation, inspect the diff, and run the matching QA gate. Do not batch stages or use the aggregate `staged-run` target when the QA checkpoint between stages cannot be honored.

Focus regression checks on `elements.xhtml` and `ElementsBean.java`, since this is the component/API showcase and sole PrimeFaces Java API consumer. Also check `employees.xhtml` and table filter/sort expressions, `app.css` overrides, and shared navigation. Validate date entry, messages, upload, editor, export, and AJAX behaviors rather than treating compilation as sufficient.

### 8. Jakarta/EAP/Java cutover

1. Validate the target image reference and Gradle/Java 21 build plan. Upgrade Gradle wrapper/toolchain only as necessary to build on Java 21.
2. Replace the provided Java EE API with Jakarta EE 10 and update PrimeFaces to the 15.0.16 Jakarta artifact. Keep catalog/version management in `gradle/libs.versions.toml` and preserve the local-JAR fallback only if a corresponding verified target artifact is provided.
3. Convert Java imports in the CDI beans from `javax.*` to `jakarta.*`; update Faces context parameter names and servlet class in `web.xml`.
4. Update `web.xml`, `beans.xml`, and `jboss-web.xml` namespaces/schema/version for the target server. Check that CDI annotated discovery and root context behavior remain intact.
5. Update the `UploadedFile` import to `org.primefaces.model.file.UploadedFile` and verify the exact PF 15 method signatures. Validate each PrimeFaces tag/attribute in use against the target tag library, including date, table, messages, upload, exporter, and editor.
6. Change Docker image/build arguments and Compose metadata to the agreed EAP 8.1 Java 21 image. Review `platform: linux/amd64`; retain it only if the chosen image requires or supports that target.
7. Build the WAR, run the repository's modernization validator, validate Compose configuration, build/start the container, and inspect startup/deployment logs.
8. Test root URL routing, CDI bean resolution, all five pages, upload limits/handling, date/AJAX behavior, table interactions, CSV download, editor submission, and browser console output.
9. Inspect source, descriptors, and packaged WAR for unintended `javax.*` leakage. Do not reject unrelated JDK package names such as `javax.crypto` without checking whether they are part of the Java SE API.

### 9. Final acceptance

- Build succeeds with the target JDK and intended dependency source.
- Application deploys successfully on the selected EAP 8.1 image and remains available at `/`.
- All pages and representative component behaviors pass the regression checklist.
- No mixed Java EE/Jakarta EE APIs remain in application-managed code/configuration.
- QA approves the result and deployment artifacts are reproducible.

## QA checklist at every stage

- Application root and shared navigation work; all five pages load.
- CDI-backed content renders without server errors.
- Forms, validation feedback, AJAX updates, command buttons/links, and messages behave correctly.
- Date input opens, selects, submits, and displays the expected format.
- Data tables render and their sort/filter/pagination/expansion behaviors remain valid where configured.
- CSV exporter downloads valid output.
- Text editor renders and submits its value.
- File upload reaches the listener and reports correct metadata/content; enforce configured upload size behavior.
- Dialog, menu, progress bar, poll, autocomplete, and browser console are checked on Elements.
- Compare the UI against the baseline, especially CSS/theme classes.
- For the final stage, additionally confirm container startup, server deployment logs, Jakarta descriptors, and Java 21 runtime.

## Stop conditions and risk controls

- Stop if the target PrimeFaces artifact or EAP image cannot be resolved from approved sources.
- Stop if a stage fails its build or functional gate; diagnose and repeat that stage rather than advancing.
- Treat any upload API, descriptor-schema, CDI resolution, or resource-loading error as a release blocker.
- Do not infer ARM support from the amd64 container configuration.
- Keep transformation output and test evidence stage-specific so a regression can be traced to one version move.
- Given the lack of automated behavioral tests, budget for manual QA and repeat it after any post-gate fixes.
