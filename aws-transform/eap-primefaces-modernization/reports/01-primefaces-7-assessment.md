# PrimeFaces 6.2.30 → 7.0 Assessment

## Scope

Upgrade PrimeFaces dependency from **6.2.30** to **7.0** only. No changes to JBoss EAP, Java version, Jakarta namespace, Docker, or deployment descriptors.

### Project Profile

| Metric | Value |
|--------|-------|
| XHTML pages | 6 |
| Distinct PrimeFaces components used | ~40+ |
| Java files importing org.primefaces | 1 (`ElementsBean.java`) |
| CSS files targeting PF widget classes | 1 (`app.css`) |
| PrimeFaces config in web.xml | 1 (`primefaces.UPLOADER=native`) |
| Build system | Gradle (version catalog) |

---

## Breaking Changes (6.2 → 7.0)

| Area | Impact | Files Affected |
|------|--------|----------------|
| **Theme default change** (Aristo → Nova) | CSS overrides in `app.css` may need adjustment for new Nova theme class structure | `app.css` |
| **Deprecated components removed** | Verify no use of `p:editor` (replaced by `p:textEditor` already in use) | None expected |
| **FileUpload API** | `org.primefaces.model.UploadedFile` and `org.primefaces.event.FileUploadEvent` remain stable in 7.0; native uploader is default | `ElementsBean.java` — no change needed |
| **DataTable lazy loading** | `LazyDataModel.setRowCount()` deprecation warning; project does not use lazy loading | None |
| **Calendar → DatePicker** | `p:calendar` deprecated in favor of `p:datePicker` in 7.0; `p:calendar` still functional | `elements.xhtml` — optional migration |
| **Client-side API renames** | Some widget vars renamed (PF → PrimeFaces); verify inline JS | No inline JS in project |
| **Context param changes** | `primefaces.UPLOADER=native` is now the default; param can be removed but is harmless | `web.xml` — optional cleanup |

---

## Estimate

| Metric | Low | Expected | High |
|--------|-----|----------|------|
| AWS Transform agent minutes | 10 | 15 | 25 |
| Human review/intervention (minutes) | 5 | 10 | 20 |
| QA effort (minutes) | 15 | 30 | 45 |
| Calendar duration | < 1 hour | 1–2 hours | half day |

**Rationale**: This is a small project (6 pages, 1 Java import, single module). PrimeFaces 6.2 → 7.0 is a minor-major bump with high backward compatibility. The main work is: (1) bump version in `libs.versions.toml`, (2) verify build compiles, (3) visual regression check on CSS overrides against Nova theme.

---

## Cost

| Item | Low | Expected | High |
|------|-----|----------|------|
| Agent minutes | 10 | 15 | 25 |
| AWS Transform cost (USD 0.035/min) | $0.35 | $0.53 | $0.88 |

---

## QA Focus

1. **Visual regression** — The custom GOV.UK-style CSS in `app.css` overrides PrimeFaces widget classes (`.ui-widget`, `.ui-panel`, `.ui-datatable`, `.ui-menubar`, `.ui-dialog`, etc.). Theme structural changes in PF 7.0 (Nova) may alter rendered HTML class names or nesting. Verify all 6 pages render correctly.
2. **File upload** — Test file upload on `elements.xhtml`; confirm `FileUploadEvent` and `UploadedFile` still function with native uploader.
3. **Calendar component** — `p:calendar` on `elements.xhtml` is deprecated in 7.0 but should still work. Confirm date selection functions.
4. **DataTable features** — Sorting, filtering, row expansion, and data export on `employees.xhtml`, `dashboard.xhtml`, `reports.xhtml`, and `elements.xhtml`.
5. **Dialog and ConfirmDialog** — Verify `p:dialog` and `p:confirmDialog` open/close correctly with the new JS widget namespace.
6. **TextEditor** — `p:textEditor` on `elements.xhtml` uses Quill internally; confirm it initializes without errors.

---

## Risks And Blockers

### Risks

| # | Risk | Likelihood | Impact | Mitigation |
|---|------|-----------|--------|------------|
| 1 | CSS overrides break under Nova theme restructuring | Medium | Medium | Compare PF 6.2 vs 7.0 rendered HTML; adjust `.ui-*` selectors in `app.css` |
| 2 | `p:calendar` deprecation warnings in logs | High | Low | Functional in 7.0; migrate to `p:datePicker` in a follow-up step |
| 3 | PrimeFaces 7.0 JAR not in configured Gradle repositories | Low | Low | Available on Maven Central; no action needed |

### Blockers

None identified. PrimeFaces 7.0 is fully compatible with Java 8 and JavaEE 8 (Servlet 3.1+, JSF 2.2+), which matches the current runtime.

---

## Recommendation

**Proceed.** This is a low-risk, low-effort upgrade. The project is small, uses no deprecated-and-removed APIs, and the single Java import (`UploadedFile`, `FileUploadEvent`) is stable across both versions. The primary verification effort is visual QA of CSS overrides against the new default theme. The `p:calendar` → `p:datePicker` migration is optional and can be deferred.

Suggested execution order:
1. Update `primefaces` version in `gradle/libs.versions.toml` from `6.2.30` to `7.0`.
2. Run `./gradlew clean build` — expect clean compilation.
3. Deploy to JBoss EAP and perform visual QA on all 6 pages.
4. Adjust CSS selectors in `app.css` if Nova theme introduces structural changes.
