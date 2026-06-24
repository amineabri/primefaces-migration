# Assessment: PrimeFaces 13.0.0 to 14.0.0

## Scope

Upgrade PrimeFaces from 13.0.0 to 14.0.0. This assessment covers only PrimeFaces library changes. JBoss, Jakarta, Java, Docker, descriptor, and namespace migrations are excluded.

### Project Inventory

| Metric | Count |
|--------|-------|
| XHTML files using PrimeFaces | 6 |
| Java files with PrimeFaces imports | 1 |
| Distinct PrimeFaces components used | ~44 |
| Configuration entries (web.xml) | 1 |

### Breaking / Deprecated Changes (13 → 14)

| Change | Affected File(s) | Severity |
|--------|-------------------|----------|
| `p:calendar` removed (deprecated since PF 13); must migrate to `p:datePicker` | `elements.xhtml` | HIGH |
| CSP (Content Security Policy) `mode` default changed; inline scripts may be blocked | all XHTML views | MEDIUM |
| `p:autoComplete` – `minQueryLength` default changed from 1 to 3 | `elements.xhtml` | LOW |
| DataTable lazy-loading and filter-meta API refinements | `employees.xhtml`, `elements.xhtml` | LOW |
| `p:textEditor` upgraded to Quill 2.x; attribute and toolbar configuration changes | `elements.xhtml` | MEDIUM |
| `p:dataExporter` – continued API hardening; deprecated overloads removed | `elements.xhtml` | LOW |
| `p:confirmDialog` – `global` attribute now required for programmatic usage | `elements.xhtml` | LOW |
| Deprecated widget APIs removed (client-side JS `PF('widgetVar')` patterns) | `elements.xhtml` | LOW |

---

## Estimate

| Scenario | AWS Transform Agent Minutes |
|----------|----------------------------|
| Low | 12 |
| Expected | 20 |
| High | 35 |

**Rationale:** The project is small (6 XHTML pages, 1 backing bean). The main mandatory change is replacing `p:calendar` with `p:datePicker` in `elements.xhtml`. Most other PF 13 components remain compatible in PF 14 without modification. The high scenario accounts for CSP-related rendering issues and potential TextEditor (Quill 2.x) regressions requiring iterative troubleshooting.

---

## Cost

| Scenario | Agent Minutes | AWS Transform Cost (USD) |
|----------|---------------|--------------------------|
| Low | 12 | $0.42 |
| Expected | 20 | $0.70 |
| High | 35 | $1.23 |

*Formula: AWS Transform cost = estimated agent minutes × $0.035*

### Human Effort

| Activity | Hours |
|----------|-------|
| Developer review & acceptance testing | 1–2 |
| QA functional validation | 1–2 |
| **Total human effort** | **2–4** |

### Calendar Duration

| Scenario | Duration |
|----------|----------|
| Expected | 1 day |
| High (with blockers) | 2 days |

---

## QA Focus

1. **Calendar → DatePicker Migration** – Verify the replacement of `p:calendar` with `p:datePicker` in `elements.xhtml` renders and functions correctly (date selection, format, locale, ajax events).
2. **TextEditor (Quill 2.x)** – Confirm the rich-text editor in `elements.xhtml` renders toolbar and content correctly after Quill upgrade; verify value binding still works.
3. **CSP Compliance** – Check that all pages render without blocked inline scripts in browser console. If CSP mode is enabled, verify no component relies on inline `onclick` or `eval()` patterns.
4. **AutoComplete** – Test that `p:autoComplete` in `elements.xhtml` still fires completion with expected minimum character threshold; adjust `minQueryLength` attribute if needed.
5. **DataTable Export** – Validate CSV/Excel export functionality after DataExporter API changes.
6. **ConfirmDialog** – Confirm programmatic confirm dialogs still trigger correctly via `p:confirm` + `p:confirmDialog`.
7. **File Upload** – Regression check that `p:fileUpload` in `elements.xhtml` and `ElementsBean.java` handler still function correctly.
8. **Theme/CSS** – Visual pass on all 6 pages to catch PrimeFaces 14 styling changes.

---

## Risks And Blockers

### Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| `p:calendar` removal causes page render failure | High | Medium | Replace with `p:datePicker`; attribute mapping is straightforward |
| Quill 2.x breaking `p:textEditor` toolbar or value binding | Medium | Medium | Test editor; review PF 14 release notes for attribute changes |
| CSP mode change blocking inline JS on existing pages | Medium | Low | Set `primefaces.CSP` context-param to `false` if needed; or fix inline scripts |
| AutoComplete behavior change surprising users | Low | Low | Explicitly set `minQueryLength="1"` to restore old behavior |
| Undocumented widget JS API removal breaking client-side scripts | Low | Low | Small project; manual check of any `PF()` calls in XHTML |

### Blockers

| Blocker | Status |
|---------|--------|
| PrimeFaces 14.0.x Maven Central availability | No blocker – artifact is published |
| Jakarta Faces compatibility (PF 14 requires Faces 4.0+) | Assumed satisfied if PF 13 migration was completed |
| Java version (PF 14 requires Java 17+) | Assumed satisfied if PF 13 step established Java 17 |

---

## Recommendation

**Proceed.** The PrimeFaces 13.0.0 → 14.0.0 upgrade is low-to-moderate risk for this project. The single mandatory breaking change (`p:calendar` → `p:datePicker`) affects one XHTML file and has a well-documented migration path. The remaining changes are behavioral defaults and deprecated-API removals that are straightforward to address. Expected agent cost is under $1.00 USD. The `p:textEditor` Quill 2.x upgrade is the primary area requiring visual verification.
