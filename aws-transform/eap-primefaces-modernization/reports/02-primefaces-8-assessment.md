# PrimeFaces 7.0 to 8.0 Upgrade Assessment

## Scope

Upgrade PrimeFaces from 7.0 to 8.0. This assessment covers PrimeFaces component and API changes only. JBoss/WildFly, Jakarta EE, Java version, Docker, deployment descriptors, and namespace migrations are excluded.

### Application Profile

| Metric | Value |
|--------|-------|
| XHTML pages using PrimeFaces | 6 |
| Java files importing org.primefaces | 1 |
| Total lines referencing PrimeFaces | ~420 |
| Distinct PrimeFaces components used | ~35 |
| Build system | Gradle (version catalog) |

---

## Estimate

| Metric | Low | Expected | High |
|--------|-----|----------|------|
| AWS Transform agent minutes | 15 | 25 | 40 |
| Human review effort (hours) | 0.5 | 1 | 2 |
| QA effort (hours) | 1 | 2 | 4 |
| Calendar duration (days) | 1 | 1 | 2 |

### Breakdown of Agent Work

| Task | Agent Minutes (expected) |
|------|--------------------------|
| Update dependency version in libs.versions.toml | 2 |
| Fix `p:fileUpload` listener attribute rename (`fileUploadListener` → `listener`) | 3 |
| Fix `UploadedFile` API changes in ElementsBean.java | 3 |
| Migrate `p:calendar` to `p:datePicker` | 4 |
| Update `filterBy`/`sortBy` EL expressions to field-name strings | 5 |
| Verify `p:textEditor` and `p:dataExporter` compatibility | 3 |
| Build verification and fix iteration | 5 |
| **Total** | **25** |

---

## Cost

| Item | Low | Expected | High |
|------|-----|----------|------|
| Agent minutes | 15 | 25 | 40 |
| Rate (USD/agent-min) | 0.035 | 0.035 | 0.035 |
| **AWS Transform cost** | **$0.53** | **$0.88** | **$1.40** |

---

## QA Focus

1. **File Upload** – Verify advanced-mode file upload still triggers the listener, files are received correctly, and progress bar updates.
2. **Date Picker** – Confirm date selection, calendar popup, and value binding after `p:calendar` → `p:datePicker` migration.
3. **DataTable filtering/sorting** – Exercise column filter inputs and sort headers on `elements.xhtml` and `employees.xhtml` to verify field-name-based `filterBy`/`sortBy`.
4. **Text Editor** – Confirm Quill-based editor renders and submits content without the `secure="false"` attribute causing errors.
5. **Data Export** – Export CSV from the data table and verify file contents.
6. **Regression** – Smoke-test all 6 pages for rendering errors, broken AJAX, or missing resources.

---

## Risks And Blockers

### Risks

| # | Risk | Likelihood | Impact | Mitigation |
|---|------|-----------|--------|------------|
| 1 | `p:textEditor` Quill version incompatibility causes editor rendering failure | Medium | Medium | Test editor on target app server; fall back to previous Quill CDN if needed |
| 2 | `filterBy`/`sortBy` field-name resolution fails for nested properties | Low | Medium | Validate with integration test; keep EL syntax if string form fails |
| 3 | `p:fileUpload` native mode behavioral changes beyond attribute rename | Low | High | Functional test upload with various file sizes |
| 4 | Third-party theme incompatibility with PrimeFaces 8.0 widget changes | Low | Low | Verify theme renders correctly; update theme JAR if needed |

### Blockers

None identified. All changes are straightforward API migrations with well-documented upgrade paths in the PrimeFaces 8.0 migration guide.

---

## Recommendation

**Proceed with the upgrade.** The application is small and uses PrimeFaces in a standard way with no lazy loading, no custom exporters, no Dialog Framework, and no Chart/Schedule components. The breaking changes are limited to:

- One Java file (`ElementsBean.java`) – FileUpload API
- Two XHTML files (`elements.xhtml`, `employees.xhtml`) – attribute renames and deprecation replacements

The expected AWS Transform cost is under $1.00, and the migration can be completed and verified within a single session. The primary QA focus should be on the file upload flow and date picker behavior, as these involve the most significant API changes.
