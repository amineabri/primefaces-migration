# Assessment: PrimeFaces 12.0.0 to 13.0.0

## Scope

Upgrade PrimeFaces from 12.0.0 to 13.0.0. This assessment covers only PrimeFaces library changes. JBoss, Jakarta, Java, Docker, descriptor, and namespace migrations are excluded.

### Project Inventory

| Metric | Count |
|--------|-------|
| XHTML files using PrimeFaces | 6 |
| Java files with PrimeFaces imports | 1 |
| Distinct PrimeFaces components used | ~44 |
| Configuration entries (web.xml) | 1 |

### Breaking / Deprecated Changes (12 → 13)

| Change | Affected File(s) | Severity |
|--------|-------------------|----------|
| `org.primefaces.model.UploadedFile` → `org.primefaces.model.file.UploadedFile` | `ElementsBean.java` | HIGH |
| `org.primefaces.event.FileUploadEvent` package restructuring | `ElementsBean.java` | HIGH |
| `p:calendar` deprecated in favor of `p:datePicker` | `elements.xhtml` | MEDIUM |
| `primefaces.UPLOADER` context-param removed (native is default) | `web.xml` | LOW |
| DataExporter API continued refactoring | `elements.xhtml` | MEDIUM |
| DataTable `filterBy`/`sortBy` attribute refinements | `employees.xhtml`, `elements.xhtml` | LOW |
| `p:textEditor` attribute changes | `elements.xhtml` | LOW |

---

## Estimate

| Scenario | AWS Transform Agent Minutes |
|----------|----------------------------|
| Low | 15 |
| Expected | 25 |
| High | 40 |

**Rationale:** The project is small (6 XHTML pages, 1 backing bean). The primary code change is the file-upload API migration in `ElementsBean.java`. Component-level XHTML changes are minimal since most PF 12 components remain compatible in PF 13. The high scenario accounts for unexpected DataTable filter/export regressions requiring iterative fixes.

---

## Cost

| Scenario | Agent Minutes | AWS Transform Cost (USD) |
|----------|---------------|--------------------------|
| Low | 15 | $0.53 |
| Expected | 25 | $0.88 |
| High | 40 | $1.40 |

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

1. **File Upload** – Verify advanced file upload still functions (`p:fileUpload` in `elements.xhtml`, `ElementsBean.java` handler). Confirm uploaded file content and metadata are accessible through the new API.
2. **DataTable Export** – Test CSV/Excel export from `elements.xhtml` DataTable after DataExporter API changes.
3. **DataTable Filtering & Sorting** – Validate filter-by and sort-by behavior in `employees.xhtml` and `elements.xhtml`.
4. **Calendar/DatePicker** – Confirm `p:calendar` still renders and functions (deprecated but not removed in PF 13). Plan future migration to `p:datePicker`.
5. **TextEditor** – Verify rich-text editor in `elements.xhtml` renders correctly with updated Quill integration.
6. **Ajax & Dialog** – Confirm `p:dialog`, `p:confirmDialog`, `p:growl`, and `p:ajaxStatus` behavior unchanged.
7. **Theme Compatibility** – Verify current theme renders correctly with PF 13 component markup changes.

---

## Risks And Blockers

### Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| FileUpload API incompatibility causes compile failure | High | Medium | Straightforward import/type rename; well-documented in PF migration guide |
| DataExporter behavioral change breaks CSV output | Medium | Medium | Manual QA of export output; compare pre/post upgrade |
| Undocumented component attribute removal | Low | Low | Small component surface; quick to identify via build errors |
| Theme/CSS regressions | Low | Low | Visual QA pass on all 6 pages |

### Blockers

| Blocker | Status |
|---------|--------|
| PrimeFaces 13.0.x Maven Central availability | No blocker – artifact is published |
| JSF version compatibility (PF 13 requires JSF 2.3+) | Verify current JSF version meets requirement |
| Java version (PF 13 requires Java 11+) | Verify current runtime meets requirement |

---

## Recommendation

**Proceed.** The PrimeFaces 12.0.0 → 13.0.0 upgrade is low-risk for this project. The codebase is small, component usage is standard, and breaking changes are well-documented with clear migration paths. The most impactful change (file-upload API) affects a single Java file and requires a straightforward package/type rename. Expected agent cost is under $1.00 USD.
