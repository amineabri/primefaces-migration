# PrimeFaces 8.0 → 10.0.0 Migration Assessment

## Overview

This assessment covers the upgrade of PrimeFaces from 8.0 to 10.0.0 only. PrimeFaces does not have a normal public 9.x major release in this migration path; the version line moves directly from 8.x to 10.0.0.

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
| AWS Transform agent minutes | 15 | 25 | 40 |
| Human effort (hours) | 1 | 2 | 4 |
| QA effort (hours) | 2 | 3 | 5 |
| Calendar duration (days) | 1 | 1 | 2 |

### Rationale

The project is small (6 XHTML pages, 1 Java bean). The 8.0→10.0.0 jump involves known, well-documented API changes. Primary work items:

1. **`p:calendar` → `p:datePicker`** — attribute mapping required (1 occurrence in `elements.xhtml`).
2. **`UploadedFile` import path** — `org.primefaces.model.UploadedFile` moved to `org.primefaces.model.file.UploadedFile` in PF 8.0; if already on 8.0 this is resolved, but method signatures changed between 8.x and 10.0 (`getContents()` → `getContent()`, `getInputstream()` → `getInputStream()`).
3. **`primefaces.UPLOADER` context-param** — remove from `web.xml` (native is the only mode since PF 8.0).
4. **`p:autoComplete`** — `completeMethod` signature unchanged, but `itemLabel`/`itemValue` defaults shifted; review needed.
5. **`p:dataExporter`** — internal refactoring; if only used declaratively in XHTML (as here), no code change needed.
6. **CSS theme class changes** — PF 10 refines some `.ui-*` class structures; visual regression testing required for `app.css` overrides.

---

## Cost

| Metric | Low | Expected | High |
|--------|-----|----------|------|
| AWS Transform agent minutes | 15 | 25 | 40 |
| AWS Transform cost (USD) | $0.53 | $0.88 | $1.40 |

**Formula:** AWS Transform cost = estimated agent minutes × $0.035

---

## QA Focus

1. **File Upload** — Verify `p:fileUpload` functions correctly after `UploadedFile` API changes. Test upload, progress bar, and error handling.
2. **Date Picker** — If `p:calendar` is migrated to `p:datePicker`, validate date selection, locale formatting, min/max constraints, and Ajax events.
3. **DataTable** — Confirm sorting, filtering, pagination, and `p:dataExporter` (PDF/Excel export) work unchanged.
4. **AutoComplete** — Verify suggestion list renders and selection populates the field correctly.
5. **Visual Regression** — Compare all 6 pages side-by-side for CSS misalignment due to PrimeFaces 10 DOM/class changes against `app.css` overrides (menubar, panels, dialogs, buttons).
6. **TextEditor** — PF 10 upgraded the internal Quill.js version; verify rich text editing still works.
7. **Dialog / ConfirmDialog** — Confirm modal overlays, button actions, and Ajax callbacks.

---

## Risks And Blockers

### Risks

| # | Risk | Impact | Likelihood | Mitigation |
|---|------|--------|------------|------------|
| 1 | CSS overrides in `app.css` break with PF 10 DOM changes | Medium | Medium | Visual regression testing on all pages |
| 2 | `p:textEditor` Quill.js upgrade introduces JS errors | Low | Low | Functional test of editor operations |
| 3 | Undocumented behaviour changes in `p:dataExporter` | Low | Low | Export test for each format |
| 4 | `p:fileUpload` servlet-level changes conflict with container config | Medium | Low | Integration test with actual file uploads |

### Blockers

| # | Blocker | Status |
|---|---------|--------|
| 1 | None identified | N/A |

No hard blockers exist for this version move. All breaking changes are well-documented and mechanical.

---

## Recommendation

**Proceed.** The PrimeFaces 8.0 → 10.0.0 upgrade for this project is low-risk and low-effort. The codebase is small, uses PrimeFaces components declaratively with minimal Java-side API coupling (1 bean), and has no PrimeFaces Extensions. The breaking changes are mechanical (import path, deprecated component swap, config removal) and can be completed by an automated transform agent with brief human review. Visual QA is the primary effort driver due to custom CSS overrides.
