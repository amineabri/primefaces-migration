# PrimeFaces 6.2.30 to 7.0 Assessment

## Scope

Upgrade PrimeFaces from 6.2.30 to 7.0 in the `primefaces-homeoffice` WAR project. This assessment covers only the PrimeFaces library version change. JBoss EAP, Jakarta/Java EE namespace, Java version, Docker, and descriptor migrations are out of scope.

### Project Profile

| Metric | Value |
|--------|-------|
| XHTML views | 6 |
| Java files importing PrimeFaces | 1 (`ElementsBean.java`) |
| PrimeFaces components in use | 35+ distinct tags |
| CSS override rules targeting PF classes | ~120 selectors |
| Configuration references | 1 (`web.xml`: `primefaces.UPLOADER`) |
| Build system | Gradle (version catalog `libs.versions.toml`) |

---

## Estimate

| Metric | Low | Expected | High |
|--------|-----|----------|------|
| AWS Transform agent minutes | 8 | 12 | 20 |
| Human review effort (hours) | 0.25 | 0.5 | 1 |
| QA effort (hours) | 0.5 | 1 | 2 |
| Calendar duration (days) | < 1 | < 1 | 1 |

### Rationale

- The version bump is a single-line change in `gradle/libs.versions.toml`.
- PrimeFaces 7.0 is backwards-compatible with 6.2 for all components used in this project.
- `org.primefaces.model.UploadedFile` and `org.primefaces.event.FileUploadEvent` retain the same package/class names in 7.0.
- `p:calendar` is deprecated in 7.0 (replaced by `p:datePicker`) but continues to function without code changes.
- The `primefaces.UPLOADER=native` context param becomes redundant (native is the default in 7.0) but causes no conflict if left in place.
- CSS class names (`.ui-widget`, `.ui-panel`, `.ui-datatable`, etc.) remain unchanged in PF 7.0.

---

## Cost

| Item | Low | Expected | High |
|------|-----|----------|------|
| Agent minutes | 8 | 12 | 20 |
| AWS Transform cost (USD 0.035/min) | $0.28 | $0.42 | $0.70 |

---

## QA Focus

1. **File Upload** – Verify `p:fileUpload` on `elements.xhtml` works correctly; PF 7.0 refactored the native upload internals.
2. **DataTable** – Confirm sorting, filtering, pagination, and row expansion on `employees.xhtml` and `elements.xhtml`.
3. **TextEditor** – Validate rich-text editor rendering (`elements.xhtml`); PF 7.0 upgraded the underlying Quill version.
4. **Calendar/DatePicker** – Confirm `p:calendar` still renders and accepts dates without errors (deprecated but functional).
5. **Theme/CSS** – Visual regression check on all 6 pages; confirm custom `.ui-*` overrides in `app.css` still apply.
6. **AutoComplete** – Test typeahead behavior on `elements.xhtml`.
7. **Dialog & Growl** – Ensure modal dialogs and notification messages display correctly.

---

## Risks And Blockers

### Risks

| # | Risk | Likelihood | Impact | Mitigation |
|---|------|-----------|--------|------------|
| 1 | CSS visual regressions from minor PF 7.0 style changes | Low | Low | Visual comparison of all 6 pages |
| 2 | `p:fileUpload` behavioral change with native uploader refactor | Low | Medium | Functional test of upload flow |
| 3 | TextEditor Quill version bump introduces JS incompatibility | Low | Low | Test rich-text save/load |
| 4 | Deprecated `p:calendar` warnings in logs | Expected | None | Cosmetic; no functional impact |

### Blockers

None identified. PrimeFaces 7.0 is available on Maven Central and fully compatible with JSF 2.3 / Java EE 8 on JBoss EAP 7.3.

---

## Recommendation

**Proceed.** This is a low-risk, minimal-effort upgrade. The project uses no removed or renamed APIs between PrimeFaces 6.2 and 7.0. The change consists of a single version bump in the Gradle version catalog followed by a build verification and functional QA pass across the 6 XHTML views.
