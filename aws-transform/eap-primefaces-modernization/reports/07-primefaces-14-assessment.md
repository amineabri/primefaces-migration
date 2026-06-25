# PrimeFaces 13.0.0 to 14.0.0 Upgrade Assessment

## Scope

Upgrade PrimeFaces from **13.0.0** to **14.0.0** only. This assessment covers PrimeFaces library changes exclusively — no JBoss, Jakarta, Java, Docker, descriptor, or namespace migration is in scope.

### Project Inventory

| Metric | Value |
|--------|-------|
| XHTML files with PrimeFaces components | 6 |
| Unique PrimeFaces UI components used | ~32 |
| Java files with PrimeFaces API imports | 1 |
| PrimeFaces Java imports | 2 (`FileUploadEvent`, `UploadedFile`) |

### Components in Use

`p:menubar`, `p:menuitem`, `p:panel`, `p:dataTable`, `p:column`, `p:growl`, `p:autoUpdate`, `p:messages`, `p:ajaxStatus`, `p:defaultCommand`, `p:panelGrid`, `p:outputLabel`, `p:inputText`, `p:message`, `p:outputPanel`, `p:selectOneMenu`, `p:ajax`, `p:selectBooleanCheckbox`, `p:calendar`, `p:selectOneRadio`, `p:selectManyMenu`, `p:autoComplete`, `p:inputTextarea`, `p:commandButton`, `p:resetInput`, `p:menu`, `p:submenu`, `p:link`, `p:button`, `p:commandLink`, `p:confirm`, `p:accordionPanel`, `p:tab`.

---

## Estimate

### PrimeFaces 13 → 14 Breaking Changes Relevant to This Project

| Change Area | Impact | Files Affected |
|-------------|--------|----------------|
| `p:calendar` deprecated in favor of `p:datePicker` | Low — still functional in 14, but migration recommended | 1 (elements.xhtml) |
| `p:growl` removed/deprecated — use `p:messages` | Low — project already uses `p:messages` alongside; remove `p:growl` | 1 (elements.xhtml) |
| DataTable `sortBy`/`filterBy` attribute changes | Low — verify existing expressions still compile | 4 files |
| Client-side API / widget var changes | Low — no custom JS detected | 0 |
| Theme/CSS updates (PrimeFlex 4, new default theme) | Low — cosmetic only, no functional breakage | N/A |
| `UploadedFile` package relocation | Low — verify import path still valid | 1 (ElementsBean.java) |
| Removed deprecated APIs (PF legacy event classes) | Low — only `FileUploadEvent` used | 1 |

### Agent Minutes Estimate

| Scenario | Agent Minutes | Rationale |
|----------|--------------|-----------|
| Low | 15 | No deprecation removals hit; version bump + smoke test only |
| Expected | 25 | Replace `p:growl`, migrate `p:calendar` → `p:datePicker`, verify `UploadedFile` import, update version, fix any dataTable attribute changes |
| High | 40 | Unexpected component behavior regressions requiring iterative fixes, theme adjustments, or additional deprecated API removals |

---

## Cost

| Scenario | Agent Minutes | AWS Transform Cost (USD) |
|----------|--------------|--------------------------|
| Low | 15 | $0.53 |
| Expected | 25 | $0.88 |
| High | 40 | $1.40 |

> **Formula**: AWS Transform cost = estimated agent minutes × $0.035

### Human Effort

| Activity | Estimated Effort |
|----------|-----------------|
| Developer review of automated changes | 0.5–1 hour |
| Manual UI smoke testing | 1–2 hours |
| Theme/CSS visual review | 0.5–1 hour |
| **Total human effort** | **2–4 hours** |

### QA Effort

| Activity | Estimated Effort |
|----------|-----------------|
| Functional regression testing (forms, tables, menus) | 2–3 hours |
| Cross-browser visual check | 1 hour |
| **Total QA effort** | **3–4 hours** |

### Calendar Duration

| Phase | Duration |
|-------|----------|
| Automated migration (AWS Transform) | < 1 day |
| Developer review + manual fixes | < 1 day |
| QA regression cycle | 1 day |
| **Total elapsed** | **1–2 business days** |

---

## QA Focus

1. **Data Tables** — Verify sorting, filtering, pagination, and lazy loading still function across `dashboard.xhtml`, `elements.xhtml`, `employees.xhtml`, and `reports.xhtml`.
2. **Form Components** — Test `p:calendar` (or `p:datePicker` post-migration), `p:autoComplete`, `p:selectOneMenu`, file upload, and form submission in `elements.xhtml` and `home.xhtml`.
3. **AJAX Behavior** — Confirm `p:ajax`, `p:commandButton`, `p:commandLink`, and `p:ajaxStatus` interactions work without JS console errors.
4. **Messages/Growl** — Validate `p:messages` displays validation errors and success feedback after `p:growl` removal.
5. **Menu Navigation** — Confirm `p:menubar` and `p:menu` render and navigate correctly in `main.xhtml`.
6. **Theme Rendering** — Visual inspection for CSS regressions (panel borders, button styles, accordion panels).
7. **File Upload** — End-to-end test of file upload if functional in the deployed environment.

---

## Risks And Blockers

### Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| `p:calendar` removal in PF 14 forces immediate migration to `p:datePicker` | Medium | Low | Replace with `p:datePicker` (same attributes, minimal effort) |
| Theme visual regressions due to PrimeFlex 4 / new default theme | Medium | Low | Pin to previous theme or adjust CSS |
| `UploadedFile` API class relocation | Low | Medium | Update import if package changed; verify at compile time |
| Undocumented behavior changes in DataTable | Low | Medium | Covered by QA regression testing |

### Blockers

| Blocker | Status |
|---------|--------|
| None identified | — |

No hard blockers exist for this version move. All identified changes are well-documented in PrimeFaces release notes and migration guides.

---

## Recommendation

**Proceed with the upgrade.** The PrimeFaces 13.0.0 → 14.0.0 migration is low-risk for this project due to:

- Small footprint (6 XHTML files, 1 Java file with PF imports)
- No custom PrimeFaces extensions or JavaScript widget overrides
- Components used are core/stable (dataTable, panel, menu, form controls)
- Estimated AWS Transform cost is under $1.40 even in the worst case

The primary work items are:
1. Bump PrimeFaces version from 13.0.0 to 14.0.0 in `libs.versions.toml`
2. Replace `p:growl` with `p:messages` (if not already equivalent)
3. Migrate `p:calendar` to `p:datePicker`
4. Verify `UploadedFile` / `FileUploadEvent` imports compile correctly
5. Run build and fix any compilation errors
6. QA visual and functional regression pass
