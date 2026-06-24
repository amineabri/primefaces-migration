# PrimeFaces 6.2.30 → 7.0 Upgrade Assessment

## Summary

| Item | Value |
|------|-------|
| Current version | PrimeFaces 6.2.30 |
| Target version | PrimeFaces 7.0 |
| XHTML files | 6 |
| Unique PF components used | ~27 |
| PrimeFaces Extensions | Not used |
| Custom theme | None (default) |
| Build system | Gradle with version catalog |

## Estimate

| Metric | Low | Expected | High |
|--------|-----|----------|------|
| AWS Transform agent minutes | 10 | 15 | 25 |
| Human effort (hours) | 0.5 | 1 | 2 |
| QA effort (hours) | 1 | 2 | 4 |
| Calendar duration (days) | 1 | 1 | 2 |

### Rationale

PrimeFaces 7.0 is a minor major bump from 6.2.x with high backward compatibility. The project is small (6 XHTML pages, ~27 component tags) and uses only standard components with no extensions or custom themes. Key changes in PF 7.0:

- jQuery updated to 3.x (removes deprecated jQuery APIs from PF client-side code).
- Some deprecated attributes removed (e.g., `sortBy`/`filterBy` string expressions replaced with EL on certain components).
- `p:calendar` deprecated in favor of `p:datePicker` (still functional in 7.0).
- Minor CSS class name changes for the default theme.
- `primefaces.UPLOADER=native` remains supported.

Given the project's limited surface area and standard component usage, most changes are confined to bumping the dependency version and verifying behavior.

## Cost

| Metric | Low | Expected | High |
|--------|-----|----------|------|
| Agent minutes | 10 | 15 | 25 |
| AWS Transform cost (USD) | $0.35 | $0.53 | $0.88 |

```
AWS Transform cost = estimated agent minutes × $0.035/min
```

## Risks And Blockers

### Risks

| # | Risk | Likelihood | Impact | Mitigation |
|---|------|-----------|--------|------------|
| 1 | jQuery 3.x incompatibility in custom JS (if any) | Low | Medium | Grep for `$.browser`, `$.fn.live`, `$.fn.die` and other removed jQuery APIs |
| 2 | `p:calendar` behavioral change (date format, locale) | Low | Low | Verify date fields render and submit correctly |
| 3 | CSS/layout regression from theme update | Low | Low | Visual inspection of all 6 pages |
| 4 | `sortBy`/`filterBy` EL syntax change in `p:dataTable` | Medium | Low | Review dataTable columns in dashboard, employees, reports |

### Blockers

None identified. PrimeFaces 7.0 is available on Maven Central and compatible with Java EE 8 / JBoss EAP 7.3.

## QA Focus

1. **DataTable sorting and filtering** — Verify all `p:dataTable` instances in dashboard.xhtml, employees.xhtml, and reports.xhtml still sort/filter correctly.
2. **Form validation flow** — Test elements.xhtml form submission, `p:messages`/`p:growl` display, and `p:resetInput` behavior.
3. **AutoComplete** — Confirm `p:autoComplete` suggestion list renders and selection works.
4. **Calendar/Date inputs** — Verify `p:calendar` date picker opens, selects, and submits dates.
5. **Menu navigation** — Confirm `p:menubar` and `p:menuitem` links work without JS errors.
6. **AJAX interactions** — Verify `p:ajax` and `p:ajaxStatus` callbacks fire correctly (jQuery 3 migration).
7. **AccordionPanel** — Test expand/collapse in reports.xhtml.

## Recommendation

**Proceed.** This is a low-risk, low-effort upgrade. The application uses a small set of standard PrimeFaces components with no extensions or custom themes. The expected agent cost is under $1 and human review should require approximately 1 hour plus 2 hours of QA validation. No blockers exist.
