# PrimeFaces 10.0.0 → 11.0.0 Migration Assessment

## Overview

This assessment covers the upgrade of PrimeFaces from 10.0.0 to 11.0.0 only.

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
| AWS Transform agent minutes | 8 | 12 | 20 |
| Human effort (hours) | 0.5 | 1 | 2 |
| QA effort (hours) | 1 | 2 | 3 |
| Calendar duration (days) | 1 | 1 | 1 |

### Rationale

PrimeFaces 10.0.0 → 11.0.0 is a minor-impact upgrade. PF 11 is largely backward-compatible with PF 10, with no major component removals or API-breaking changes. The project is small (6 XHTML pages, 1 Java bean) and uses components declaratively. Primary work items:

1. **Dependency version bump** — Update PrimeFaces dependency from 10.0.0 to 11.0.0 in `libs.versions.toml`.
2. **`p:datePicker` attribute refinements** — PF 11 tightened some attribute defaults (e.g., `showIcon` default changed); verify existing usage still renders correctly.
3. **`p:dataTable` virtual scrolling** — Internal improvements to virtual scrolling; no API change but behaviour may subtly shift for large datasets. This project uses basic pagination so impact is negligible.
4. **CSP (Content Security Policy) mode** — PF 11 improved CSP support with nonce-based inline script handling. No action needed unless the application enforces CSP headers (this project does not).
5. **Client-side validation** — PF 11 updated CSV (Client-Side Validation) internals. Review `p:commandButton` with `validateClient="true"` if present.
6. **CSS/theme refinements** — Minor `.ui-*` class adjustments in PF 11; visual check needed against `app.css` overrides.

---

## Cost

| Metric | Low | Expected | High |
|--------|-----|----------|------|
| AWS Transform agent minutes | 8 | 12 | 20 |
| AWS Transform cost (USD) | $0.28 | $0.42 | $0.70 |

**Formula:** AWS Transform cost = estimated agent minutes × $0.035

---

## QA Focus

1. **DataTable** — Confirm sorting, filtering, and pagination render correctly after PF 11 DataTable internals update. Verify column toggler and export if used.
2. **DatePicker** — Validate date selection, popup positioning, and icon display. PF 11 refined `showIcon` and overlay behaviour.
3. **AutoComplete** — Verify dropdown suggestions, selection events, and AJAX callbacks still function. PF 11 refined overlay panel positioning.
4. **Dialog / ConfirmDialog** — Confirm modal overlays and focus trapping work correctly after PF 11 dialog improvements.
5. **Visual Regression** — Compare all 6 pages for CSS misalignment. PF 11 makes subtle DOM refinements that may affect custom `app.css` overrides on panels, menubar, and buttons.
6. **FileUpload** — Verify upload functionality. PF 11 made internal improvements to chunked upload handling.
7. **MenuBar** — Confirm responsive menu behaviour; PF 11 refined responsive breakpoint handling.

---

## Risks And Blockers

### Risks

| # | Risk | Impact | Likelihood | Mitigation |
|---|------|--------|------------|------------|
| 1 | CSS overrides in `app.css` conflict with subtle PF 11 DOM class changes | Low | Medium | Visual regression comparison on all 6 pages |
| 2 | `p:datePicker` overlay positioning changes cause popup misalignment | Low | Low | Functional test of date selection in each browser |
| 3 | Client-side validation JS changes cause form submission issues | Low | Low | Test all command buttons and form submissions |
| 4 | Third-party JS library updates bundled in PF 11 (jQuery, Quill) introduce console errors | Low | Low | Browser console check on each page |

### Blockers

| # | Blocker | Status |
|---|---------|--------|
| 1 | None identified | N/A |

No hard blockers exist for this version move. PrimeFaces 11.0.0 maintains strong backward compatibility with 10.0.0, and the changelog contains no forced migration steps for the components used in this project.

---

## Recommendation

**Proceed.** The PrimeFaces 10.0.0 → 11.0.0 upgrade is the lowest-risk version move in the overall modernization path. There are no breaking API changes affecting this project's component usage. The work is limited to a version bump and visual/functional verification. The transform agent can complete this in a single pass with minimal human review. QA effort is the primary cost driver, focused on visual regression due to custom CSS overrides.
