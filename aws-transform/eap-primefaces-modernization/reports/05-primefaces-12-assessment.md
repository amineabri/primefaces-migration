# PrimeFaces 11.0.0 → 12.0.0 Migration Assessment

## Overview

This assessment covers the upgrade of PrimeFaces from 11.0.0 to 12.0.0 only.

**Scope:** PrimeFaces library only. JBoss, Jakarta, Java, Docker, descriptor, and namespace migrations are excluded.

### Project Profile

| Metric | Value |
|--------|-------|
| XHTML files using PrimeFaces | 6 |
| Distinct PrimeFaces components used | ~38 |
| Java files with PrimeFaces imports | 1 |
| PrimeFaces Extensions | None |
| Custom CSS overriding PF classes | 1 file (app.css) |

---

## Estimate

| Metric | Low | Expected | High |
|--------|-----|----------|------|
| AWS Transform agent minutes | 8 | 14 | 22 |
| Human effort (hours) | 0.5 | 1 | 2 |
| QA effort (hours) | 1 | 2 | 4 |
| Calendar duration (days) | 1 | 1 | 2 |

### Rationale

PrimeFaces 11.0.0 → 12.0.0 is a moderate-impact upgrade. PF 12 is largely backward-compatible but introduces several refinements to component internals that may require adjustments. The project is small (6 XHTML pages, 1 Java bean) and uses components declaratively. Primary work items:

1. **Dependency version bump** — Update PrimeFaces dependency from 11.0.0 to 12.0.0 in `libs.versions.toml` and local JAR reference.
2. **DataExporter refactoring** — PF 12 refactored the `p:dataExporter` component internals. The CSV export in `elements.xhtml` must be verified; attribute names and behaviour may require adjustment.
3. **FileUpload internal changes** — PF 12 updated the native file upload decoder and internal model handling. The `fileUploadListener` pattern used in `ElementsBean.java` should still work but requires verification.
4. **TextEditor (Quill) update** — PF 12 bundled an updated Quill editor version. The `p:textEditor` in `elements.xhtml` should be verified for rendering and value binding.
5. **DataTable filter/sort refinements** — PF 12 improved filtering and sorting internals. The `filterBy`/`sortBy` EL expressions in `employees.xhtml` and `elements.xhtml` should be tested.
6. **jQuery / JS library updates** — PF 12 updated bundled jQuery and other client-side libraries. Browser console errors should be checked on all pages.
7. **CSS / theme class adjustments** — Minor `.ui-*` class changes in PF 12 may conflict with `app.css` overrides. Visual regression check needed.
8. **CSP (Content Security Policy) improvements** — PF 12 further enhanced nonce-based inline script handling. No action needed unless the application enforces CSP headers (this project does not).

---

## Cost

| Metric | Low | Expected | High |
|--------|-----|----------|------|
| AWS Transform agent minutes | 8 | 14 | 22 |
| AWS Transform cost (USD) | $0.28 | $0.49 | $0.77 |

**Formula:** AWS Transform cost = estimated agent minutes × $0.035

---

## QA Focus

1. **DataExporter** — Confirm CSV export from `elements.xhtml` still triggers correctly and produces valid output. PF 12 refactored exporter internals and may change default behaviour for empty columns or headers.
2. **FileUpload** — Verify file selection, upload progress, and listener callback (`handleUpload`) work correctly. PF 12 updated the native upload decoder.
3. **TextEditor** — Validate rich text editing, placeholder display, and value binding after Quill library update in PF 12.
4. **DataTable** — Confirm sorting, filtering, pagination, row expansion, and row toggler render correctly. PF 12 made internal improvements to filter matching.
5. **AutoComplete** — Verify dropdown suggestions, `forceSelection`, and AJAX `itemSelect` events function after PF 12 overlay panel refinements.
6. **Dialog / ConfirmDialog** — Confirm modal overlays, focus trapping, and `widgetVar` show/hide calls work correctly.
7. **Visual Regression** — Compare all 6 pages for CSS misalignment. PF 12 makes DOM refinements that may affect custom `app.css` overrides on panels, menubar, buttons, and data tables.
8. **MenuBar** — Confirm responsive navigation behaviour; PF 12 refined keyboard accessibility and responsive breakpoints.
9. **Poll / ProgressBar** — Verify AJAX polling and progress bar updates still function correctly.

---

## Risks And Blockers

### Risks

| # | Risk | Impact | Likelihood | Mitigation |
|---|------|--------|------------|------------|
| 1 | `p:dataExporter` API/attribute changes break CSV export | Medium | Medium | Test export immediately after upgrade; review PF 12 release notes for exporter changes |
| 2 | CSS overrides in `app.css` conflict with PF 12 DOM class changes | Low | Medium | Visual regression comparison on all 6 pages |
| 3 | Bundled Quill update causes `p:textEditor` rendering issues | Low | Low | Functional test of rich text editor on elements page |
| 4 | Updated jQuery version introduces console errors or widget conflicts | Low | Low | Browser console check on each page |
| 5 | FileUpload native decoder changes cause upload failures | Medium | Low | Test file upload with allowed file types and size limits |
| 6 | DataTable filter/sort internal changes cause incorrect results or JS errors | Low | Low | Test all sortable/filterable columns in employees and elements tables |

### Blockers

| # | Blocker | Status |
|---|---------|--------|
| 1 | None identified | N/A |

No hard blockers exist for this version move. PrimeFaces 12.0.0 maintains backward compatibility with 11.0.0 for the component set used in this project. The migration definition confirms no namespace or Java EE changes are needed. The non-Jakarta artifact (`org.primefaces:primefaces:12.0.0`) remains available for javax-based projects.

---

## Recommendation

**Proceed.** The PrimeFaces 11.0.0 → 12.0.0 upgrade is a low-to-moderate risk version move. There are no forced API migrations for the components used in this project. The primary work is a version bump with verification of the DataExporter and FileUpload components, which received the most significant internal changes. The transform agent can complete this in a single pass. QA effort is the primary cost driver, focused on verifying data export, file upload, and visual regression due to custom CSS overrides. The slightly higher estimate compared to the 10→11 move reflects the DataExporter refactoring risk.
