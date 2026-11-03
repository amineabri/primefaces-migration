# Mandatory Theme Compatibility and Browser Support Gates

This document preserves the pre-MIG-04 planning inventory below; current execution status is in the latest addendum and migration state. Read with the runbook and transformation plan. Traceability: ATX-FIND-006, ATX-FIND-010, ATX-FIND-013, ATX-FIND-014.

## MIG-09 actual EAP addendum — authoritative current status

Actual pinned **EAP8.1 Update8.0/Java21** replay now passes the identical54checks (18each Chromium156.0.8078.4, Firefox157.0, WebKit27.2), with page/console/HTTP/Faces-partial-response errors0, matching the preserved WildFly baseline. Actual Saga Blue resources/PrimeIcons and layout/navigation/forms/dialogs/tables/paginator/date/editor/upload/messages/responsive/custom-CSS captures were checked; representative desktop/mobile views visually inspected. **MINOR DIFFERENCES**, no confirmed new EAP visual regression, no additional styling changes.

Original Omega-baseline uncertainty, inherited spacing/colors/mobile table/calendar wrapping, fixed-dialog mobile acceptance and full accessibility/motion-suppression limits remain. **Safari product NOT TESTED**; tooling WebKit is not Safari certification or an approved stable-product/OS support matrix. IE remains unsupported. See latest [final acceptance](final-acceptance.md) for precise scope/evidence. **TECHNICALLY MIGRATED — EAP RUNTIME ACCEPTANCE INCOMPLETE** for same-container cloud restart failure/production configuration and PARTIAL rollback, not missing target browser execution.

## MIG-09 provisional addendum — historical upstream outcome

User-authorized disposable WildFly35.0.1.Final/Java21 testing is complete, **not EAP8.1 acceptance**. Actual Saga Blue resources and PrimeIcons verified; remaining app icon aliases/inversion/contrast corrected and custom stylesheet emitted last. **MINOR MIGRATION DIFFERENCES**, not full visual sign-off: representative five-page desktop/Elements1440/900/390captures inspected, but no original Omega runtime baseline; Saga/inherited CSS differences, narrow table/calendar wrapping and fixed modal mobile acceptance remain open.

Chromium156.0.8078.4, Firefox157.0 and WebKit27.2 each pass18grouped behavioral checks with final JS/HTTP/Faces errors0. Keyboard modal close/reduced-motion media interaction tested, not a comprehensive accessibility/motion-suppression audit. **Safari product NOT TESTED**; tooling engines are not an approved stable-product/OS support matrix. IE remains unsupported. Scope-specific fixes and complete evidence/limits are in the additive [final-acceptance.md](final-acceptance.md) record. All earlier phase results below remain historical. **TECHNICALLY MIGRATED — EAP RUNTIME ACCEPTANCE INCOMPLETE. EAP validation STILL REQUIRED.**

## MIG-09 initial final acceptance addendum — historical outcome

MIG-09 authorized and attempted, **BLOCKED — INFRASTRUCTURE PREREQUISITE**. No approved EAP8.1 image/server/endpoint was available. Current **Saga Blue (saga-blue)** remains explicit and bundled; Omega REPLACED, STATIC THEME/PrimeIcons PASS unchanged. **Custom CSS impact HIGH, visual NOT TESTED (DEFERRED)**. No rendered screenshot/resource HTTP/console evidence or visual sign-off exists; no speculative styling changes made.

Chromium/Firefox/Safari acceptance **NOT TESTABLE** without the target endpoint. Safari executable is present locally; Chrome/Chromium/Firefox not found at inspected standard app paths (alternate locations/remote tooling unknown). No browser was exercised, including Safari. Named modern-browser/version/OS matrix remains owner action; accepted **IE SUPPORT DROPPED WITH PRIMEFACES13** unchanged. Reduced motion/keyboard/focus/ARIA/localisation, paginator button/progress label DOM and all inherited surfaces remain open.

[final-acceptance.md](final-acceptance.md) records each required functional/visual/browser surface, evidence and unblocking actions. **TECHNICALLY MIGRATED — RUNTIME ACCEPTANCE INCOMPLETE**, not visual or production acceptance. Earlier phase statements below are historical outcomes.

## MIG-08 execution addendum — historical phase outcome

PF14 -> PF15.0.16 Jakarta is COMPLETED_CONDITIONAL. **Theme Saga -> saga-blue (Saga Blue), explicit rename YES, STATIC PASS.** Exact core Jakarta JAR supplies `META-INF/resources/primefaces-saga-blue/theme.css`; no `primefaces-themes.jar` required for this choice. Target design system PrimeOne; default/temporary saga alias are not relied upon. Saga Blue editor variables and used PrimeIcons/legacy icon classes/fonts verified; all26locally used ui CSS classes supplied. No local Omega/ThemeRoller/copied Saga/obsolete theme JAR exists to delete.

**Custom CSS impact HIGH** inherited potential risk, with concrete PF15 regression surfaces: paginator actions now buttons and may match app `.ui-button`/focus styling, ProgressBar label moved inside value div. No speculative custom CSS changes made. **PrimeIcons PASS; visual validation DEFERRED.** Modern-browser runtime checks, keyboard/focus, locale/ARIA, reduced motion and resource HTTP resolution remain mandatory. Accepted IE decision unchanged; no compatibility reintroduction.

All6XHTML Faces namespaces are Jakarta, PF namespace unchanged. UploadedFile/listener/editor150px/calendar/dateSelect/ui:repeat/table identity/single sort/dialog controls revalidated. Removed upload allowTypes/sizeLimit moved unchanged to validateFile and dragDropSupport renamed dragDrop. Java21 compile and Jakarta WAR static gates passed; EAP8.1/Faces4 actual runtime unavailable. Deployment guarded pending provisioned image per user decision. **MIG-09 has NOT started.**

## MIG-07 execution addendum — historical phase outcome

PF13 -> PF14 is COMPLETED_CONDITIONAL. **Current/target Saga, theme change NO, static compatibility PASS, PrimeIcons PASS.** Exact core JAR bundles `META-INF/resources/primefaces-saga/theme.css` at the same location, no extra dependency; default saga unchanged but explicit configuration remains authoritative. Editor CSS variables, all used pi/legacy icon classes/font resources and 26 locally referenced ui-* classes are supplied. App CSS/XHTML/descriptors are byte-identical to PF13. **Custom CSS impact HIGH** inherited potential risk, **RUNTIME VISUAL VALIDATION DEFERRED**; lexical class coverage is not DOM/cascade/visual evidence.

Accepted MIG-06 IE decision remains in force and is not reopened. PF14 browser assumptions pass static review; **modern-browser compatibility RUNTIME VALIDATION REQUIRED**. Client-side localisation now defaults true (AutoComplete and paginator/ARIA labels, file errors); effective locale and actual resource delivery need checking. Reduced-motion preference disables PF animations; current confirmation fade effect has no functional timing dependency, and no override was added. Tooltip default delay becomes 400ms. Verify focus/keyboard, reduced-motion on/off, messages, resource URLs, all interactions and named browser/version/OS matrix at runtime.

PF14 minimum Java11 is addressed by source/target/release11 and same EAP7.3.10 OpenJDK11/RHEL8 image configuration. Stock EAP7.3 documents Mojarra JSF2.3; actual server/module selection and Faces SearchExpression handling remain DEFERRED, not a runtime pass. All inherited checks preserved, no theme/IE cleanup, no Jakarta conversion. MIG-08 has NOT started.

## MIG-06 execution addendum — historical phase outcome

PF12 -> PF13 is COMPLETED_CONDITIONAL. Before dependency edits the user explicitly chose **"IE is not required — accept dropping IE support with PF13 and continue MIG-06 only."** IE business requirement NO, support decision ACCEPTED: **IE SUPPORT DROPPED WITH PRIMEFACES 13**. No IE-only application code found; no code removed and no unsupported IE hacks added. Modern Grid/flex/gap retained for other browsers. IE impact LOW / MEDIUM confidence; supported-user analytics and actual modern-browser evidence remain unavailable. Third-party legacy IE strings in the packaged library are not an official support guarantee.

Current/target Saga, theme change NO, Omega remains REPLACED in MIG-04. Exact PF13 JAR still bundles `primefaces-saga/theme.css` with no relocation/new dependency, editor variables and used PrimeIcons/legacy icon classes verified. Explicit saga configuration/CSS unchanged; framework default saga unchanged, no fallback relied upon. STATIC THEME COMPATIBILITY PASS; **custom CSS risk HIGH inherited**, **RUNTIME VISUAL VALIDATION DEFERRED**.

PF13 removes p:repeat: replaced sole occurrence by ui:repeat. Editor CSS String height changed to 150px, secure=false retained. Existing grid layouts remain supported; radio's responsive DOM path and CSV exporter registry need modern-browser runtime checks. All original 13 interactions and MIG-03 through MIG-05 additional checks remain visible. MIG-07 has NOT started or been authorized.

## MIG-05 execution addendum — historical phase outcome

PF11 -> PF12 is COMPLETED_CONDITIONAL. **Current/target theme Saga, no theme change.** Unchanged `primefaces.THEME=saga` is backed by `META-INF/resources/primefaces-saga/theme.css` in the exact PF12 WAR dependency. No new theme artifact is required; framework default remains saga but is not relied on as fallback. Used PrimeIcons/legacy icon classes and font assets remain supplied. PF12's theme-aware editor consumes `--surface-a` and `--text-color`; Saga defines both, so no speculative CSS variables were added.

STATIC THEME COMPATIBILITY: PASS. **Custom CSS risk HIGH**, inherited from approved Omega-to-Saga transition; **RUNTIME VISUAL VALIDATION DEFERRED**. Application XHTML/CSS/descriptors/resources remain byte-identical to PF11 baseline. Legacy `panelGrid layout=grid` still uses bundled ui-g/ui-md CSS; no PrimeFlex conversion needed. Newly deprecated but supported p:repeat is retained; actual Faces/runtime validation required before changing its behavior.

Browser compatibility PASS for scoped static PF11-to-PF12 transition; IE-only application code NO, incremental IE impact LOW / MEDIUM confidence. PF12 retains framework IE detection/polyfills; application IE compatibility is not proven. Product decision required now NO: business requirement remains UNKNOWN, mandatory decision before MIG-06 remains unchanged. No IE cleanup. MIG-06 has NOT started or been authorized.

## MIG-04 execution addendum — historical phase outcome

The user explicitly approved **Saga replacement with existing custom CSS**, after the missing Omega supply was explained, and authorized MIG-04 only. Current source now configures `primefaces.THEME=saga` in `web.xml`; the PF11 WAR supplies `primefaces-saga/theme.css`. **Current configured theme: Saga; previous user-declared baseline: Omega.** This is an approved concrete choice, not implicit fallback or proof the original deployment used Saga.

The technically required Omega replacement boundary remains MIG-03/PF10; corrective implementation occurred in MIG-04 after the explicit decision, closing the static prerequisite. Omega is **REMOVED / REPLACED**. STATIC THEME COMPATIBILITY: PASS. Four legacy icon names with no CSS definitions in PF10/PF11 were mapped at five menu usages to bundled PrimeIcons: signal-diag -> pi-chart-line, person -> pi-user, document -> pi-file, refresh -> pi-refresh. All remaining/updated icon classes are defined in PF11. Custom CSS is unchanged, with HIGH potential visual impact. RUNTIME VISUAL VALIDATION: DEFERRED under user acceptance; historical Omega provenance and visual equivalence remain unverified. No IE-only code was removed.

For MIG-05 through MIG-07 the planned target is unchanged Saga, subject to exact version/resource/DOM revalidation. For MIG-08 the planned concrete name is `saga-blue`, subject to exact PF15.0.16 Jakarta artifact verification. Those phases have NOT started. Historical UNDECIDED/pause statements in the inventory/matrix below describe the planning checkpoint, not a remaining theme-choice blocker.

PF11 still contains IE detection/polyfills; no new IE-support removal boundary was established and no application IE-only code was found. Scoped MIG-04 browser compatibility: PASS (static), incremental IE impact LOW / MEDIUM confidence; business/browser requirements still UNKNOWN and full browser validation DEFERRED. The mandatory MIG-06 product decision remains blocking at PF13, regardless of this static result.

## Omega current-state inventory

**Current theme: Omega (user-declared visual baseline).** Do not substitute Saga as that baseline. Repository evidence does not establish how the deployed application selects Omega; distinguish intended/current user experience from the source checkout's resolvable theme.

| Surface | Evidence | Conclusion |
|---|---|---|
| Context parameters | `src/main/webapp/WEB-INF/web.xml:9-22` declares Faces settings and native uploader, but no `primefaces.THEME`. | No explicit theme configured in tracked descriptor. External deployment override remains UNKNOWN. |
| Shared template | `src/main/webapp/WEB-INF/templates/main.xhtml:7-11` loads only `resources/css/app.css`; lines 25-30 use PF menubar and legacy icon names. | No explicit Omega stylesheet/library, layout template or theme selector. |
| Local resources | All application resources reside in the single 412-line `src/main/webapp/resources/css/app.css`. No tracked images, fonts, JavaScript files or Omega layout/template directories. | No copied Omega distribution or separate application template found. Custom styling exists, but is not identified as Omega-derived. |
| Dependencies | `gradle/libs.versions.toml:3,7`, `build.gradle:15-23`, `libs/README.md`. Current WAR has only `WEB-INF/lib/primefaces-10.0.0.jar`; `libs/` has no theme JAR. | No separate theme dependency or local override. |
| Historical bundled resources | Local public PF6.2 and PF8 JARs contain `META-INF/resources/primefaces-omega/theme.css`, `fonts/` and `images/`: 30 ZIP entries including directories per artifact. | Omega was available bundled inside the PrimeFaces dependency, not necessarily selected at runtime. |
| Historical Omega fonts | `fonts/lato-{regular,bold}-webfont.{eot,svg,ttf,woff,woff2}` under that library. | Ten bundled font files; application CSS overrides text with Arial/Helvetica. No separate font dependency. |
| Historical Omega images | `images/icons_16.png`, slider handles (normal/@2x), `ui-bg_*` backgrounds and `ui-icons_*` sprites. | Theme image resources supplied by the old JAR, not copied locally. |
| Current PF10 binary | No `META-INF/resources/primefaces-omega/` resources; no Omega resources outside dependency in current WAR. | Bundled Omega REMOVED at PF8 to PF10 (MIG-03). Existing checkout cannot prove Omega resolves. |
| Historical theme configuration | Available history search found no tracked introduction of `primefaces.THEME`. | No evidence of an internal/custom Omega artifact or verified deployed selection. Obtain runtime config, resource URLs and screenshots. |
| Non-application match | `gradlew.bat:92` is the batch label `:omega`. | Not a theme resource or dependency; do not modify it. |

**Discrepancy:** The user-declared Omega baseline and the repository's lack of explicit theme configuration/resource supply must be reconciled before further version changes. PF10's framework default is not proof of the application's actual deployed theme. If an unconfigured deployment uses that default, classify the transition as **UNCONTROLLED VISUAL CHANGE**, not successful migration. Explicit Omega with missing resources may instead produce missing CSS/404s; do not assume fallback.

Exact historical PF8 file manifest (27 files beneath `META-INF/resources/primefaces-omega/`, verified from the preserved pre-MIG-03 WAR dependency):

```text
theme.css
fonts/lato-bold-webfont.eot
fonts/lato-bold-webfont.svg
fonts/lato-bold-webfont.ttf
fonts/lato-bold-webfont.woff
fonts/lato-bold-webfont.woff2
fonts/lato-regular-webfont.eot
fonts/lato-regular-webfont.svg
fonts/lato-regular-webfont.ttf
fonts/lato-regular-webfont.woff
fonts/lato-regular-webfont.woff2
images/icons_16.png
images/slider_handles.png
images/slider_handles@2x.png
images/ui-bg_flat_0_aaaaaa_40x100.png
images/ui-bg_flat_75_ffffff_40x100.png
images/ui-bg_glass_55_fbf9ee_1x400.png
images/ui-bg_glass_65_ffffff_1x400.png
images/ui-bg_glass_75_dadada_1x400.png
images/ui-bg_glass_75_e6e6e6_1x400.png
images/ui-bg_glass_95_fef1ec_1x400.png
images/ui-bg_highlight-soft_75_cccccc_1x100.png
images/ui-icons_222222_256x240.png
images/ui-icons_2e83ff_256x240.png
images/ui-icons_454545_256x240.png
images/ui-icons_cd0a0a_256x240.png
images/ui-icons_ffffff_256x240.png
```

These are historical dependency contents, not files to copy into the application or evidence that Omega was configured. Current PF10 WAR supplies none of them.

## Replacement decision and timing

```text
OMEGA CURRENT STATE (user-declared; deployment provenance unresolved)
 -> COMPATIBILITY ACROSS EACH PF VERSION
 -> EXPLICIT REPLACEMENT PHASE: MIG-03 boundary (Omega removed in PF10)
 -> MODERN SUPPORTED CONCRETE THEME (UNDECIDED, owner approval required)
 -> CUSTOM CSS REMEDIATION (only evidenced changes)
 -> RUNTIME VISUAL VALIDATION
```

The technically required bundled-Omega replacement boundary was **MIG-03**, not MIG-08. It is now a **pre-MIG-04 corrective theme gate owned by MIG-03**. Do not silently rewrite past build results or claim the theme work was already done. Do not start MIG-04 until provenance is resolved and an explicit, approved theme strategy is implemented under separate authorization. A verified externally supplied Omega build may change this decision only with exact target-version compatibility evidence and owner approval; old CSS availability alone is not support.

- Current theme: **Omega**.
- Target design system: **PrimeOne-based modern PrimeFaces theming**.
- Target concrete theme: **UNDECIDED**.
- Candidate for comparison, not approval: a supported light/blue concrete theme with a neutral surface to retain the application's black header, blue links, green/red actions, yellow focus, Arial typography and square borders. Verify the exact resource/artifact name at each version; do not turn a framework default into an implicit decision.
- PrimeOne is a design system, **never** a literal theme coordinate/name.
- Require approval of concrete theme, any required theme artifact, visual references and supported browser requirements before implementation. Do not add a commercial layout/template dependency without explicit approval.

## Version-specific theme migration matrix

The following is a plan, not evidence that a replacement is installed. **Approved theme** means the concrete replacement selected at the corrective gate; it remains UNDECIDED today. Omega's status below refers to this repository's formerly bundled setup, not every hypothetical external stylesheet.

| Migration Phase | PrimeFaces Version | Theme Before | Theme Compatibility | Theme After | Action Required | Validation |
|---|---|---|---|---|---|---|
| Corrective MIG-03 gate, before MIG-04 | 8 -> 10.0.0 (already built) | Omega, user-declared | REMOVED / REQUIRES REPLACEMENT; bundled setup no longer supplied | UNDECIDED, approved modern concrete theme required | Reconcile provenance; select and explicitly configure replacement under separate authorization; inspect resource/WAR supply and CSS | Static resources/configuration; browser visual comparison DEFERRED |
| MIG-04 | 10 -> 11 | Approved theme from corrective gate; currently unresolved Omega | Omega REMOVED; selected theme must be verified against PF11, not presumed compatible | Approved concrete theme, unchanged unless incompatibility proved | Check theme resource behavior, CSS/DOM and icons; prohibit implicit default | Exact PF11 artifact/tag evidence plus browser/resource/visual checks |
| MIG-05 | 11 -> 12 | Approved concrete theme | Omega REMOVED; reassess concrete theme/custom CSS | Same approved theme if supported | Check theme resources, styles and browser-transition requirements | Static target resources and CSS; browser visuals |
| MIG-06 | 12 -> 13 | Approved concrete theme | Omega REMOVED; reassess selected theme | Same approved theme if supported | Check theme/DOM; mandatory IE-removal product decision | Static resources plus approved non-IE browser/visual matrix |
| MIG-07 | 13 -> 14 | Approved concrete theme | Omega REMOVED; reassess selected theme | Same approved theme if supported | Validate CSS/DOM and post-IE assumptions | Static compatibility plus browser visual regression |
| MIG-08 | 14 -> 15 Jakarta | Approved concrete theme | Omega REMOVED; legacy theme compatibility cannot be assumed; PF15 artifact/name changes | Explicit supported PF15 name; concrete choice still UNDECIDED | Verify renamed theme/library, additional artifact if needed, Jakarta resource serving; no unresolved Omega | Exact 15.0.16 Jakarta WAR/resource evidence and final visual/browser regression |

Supported candidates to **evaluate**, not silently choose: `saga`, `arya`, `vela` in PF10-14; their PF15 names are `saga-blue`, `arya-blue`, `vela-blue`. Evaluate a light candidate first against Omega reference screenshots and the application's palette/layout; dark variants are not automatically equivalent. Selection must minimize CSS rework while preserving focus/contrast, spacing and interaction intent. Bundled availability does not itself constitute visual acceptance.

### Framework default versus application configuration

| Target | Framework default | Default change at this boundary | Application explicitly configured theme | Fallback / potential visual change |
|---|---|---|---|---|
| Current PF10 | `saga` [S1] | PF10 removes Omega; no verified pre-migration rendered baseline | None tracked; declared baseline Omega, external config UNKNOWN | Default selection possible if unconfigured; actual runtime UNKNOWN. Unapproved change is UNCONTROLLED VISUAL CHANGE |
| MIG-04 PF11 | `saga` [S2] | No default-name change from PF10 | Must explicitly name approved concrete theme before execution | Not executed; detect resource failure/default selection and block unapproved fallback |
| MIG-05 PF12 | `saga` [S3] | No default-name change | Same explicit configuration requirement | Not executed; no fallback authorized |
| MIG-06 PF13 | `saga` [S4] | No default-name change | Same explicit configuration requirement | Not executed; no fallback authorized |
| MIG-07 PF14 | `saga` [S5] | No default-name change | Same explicit configuration requirement | Not executed; no fallback authorized |
| MIG-08 PF15 | `saga-blue` [S6] | Default concrete name changes; themes move/rename | Explicit PF15-supported concrete name required | Not executed; aliases do not waive explicit review; no fallback authorized |

PF15 initially bundles only `saga-blue`; other listed themes require `org.primefaces:primefaces-themes` [S6, S8]. At 15.0.0, `saga`, `arya`, `vela` are compatibility aliases for their `-blue` names, documented for future removal [S7]. Use the supported concrete name, not a deprecated alias. Verify compatible artifact version, resource library, classifier needs and actual packaged files against the **exact 15.0.16 target**, rather than assuming release-line documentation proves patch packaging.

PF10's warning that legacy ThemeRoller themes are not really supported does not establish a supported external Omega route. PF15 expressly says legacy ThemeRoller themes are unsupported and will not render correctly [S1, S7]. Do not conflate all old themes with a proven Omega artifact: no supported separate Omega coordinate was established by this investigation.

## Custom CSS dependency register

All line references in this table are to `src/main/webapp/resources/css/app.css`. Classifications are additive; visual risk is not a request to rewrite.

| Rules / lines | Classification | Theme migration action |
|---|---|---|
| `html`, `body` (1-13) | THEME-INDEPENDENT; RUNTIME VISUAL VALIDATION REQUIRED | Preserve white background, dark text, Arial/Helvetica, size/line height; check cascade against theme fonts. |
| `.ui-widget` (15-17) | LEGACY PRIMEFACES DOM DEPENDENCY; RUNTIME VISUAL VALIDATION REQUIRED | Verify font inheritance and selector survives target widget markup. |
| Links and focus groups (19-40) | THEME-INDEPENDENT for native elements; LEGACY PRIMEFACES DOM DEPENDENCY for ui classes; RUNTIME VISUAL VALIDATION REQUIRED | Preserve blue links/yellow focus and keyboard visibility; verify theme specificity/shadow. |
| `.app-shell`, header, branding (42-82) | THEME-INDEPENDENT; RUNTIME VISUAL VALIDATION REQUIRED | Preserve header/border, flex alignment, spacing, typography. |
| `.top-navigation.ui-menubar`, menu links/hover (84-102) | LEGACY PRIMEFACES DOM DEPENDENCY; LIKELY REQUIRES MIGRATION; RUNTIME VISUAL VALIDATION REQUIRED | Check menu markup, states, contrast and focus against selected theme. |
| `.top-navigation ... .ui-icon` (104-106) | LEGACY PRIMEFACES DOM DEPENDENCY; LIKELY REQUIRES MIGRATION | Sprite/icon filtering assumes legacy icon rendering; test new icon assets before changing. |
| Content/headings (108-129) | THEME-INDEPENDENT; RUNTIME VISUAL VALIDATION REQUIRED | Preserve max widths, text hierarchy and spacing. |
| Panel wrappers/content/title bars (131-152) | LEGACY PRIMEFACES DOM DEPENDENCY; LIKELY REQUIRES MIGRATION; RUNTIME VISUAL VALIDATION REQUIRED | Square borders, header background, content padding depend on generated structure. |
| Card/summary grids and labels (154-189) | THEME-INDEPENDENT; RUNTIME VISUAL VALIDATION REQUIRED | Check CSS Grid/gap, widths and responsive cards. |
| `.panel-grid`, `.form-preview` (191-197) | THEME-INDEPENDENT | Preserve sizing/spacing; enclosing PF layout still needs inspection. |
| `.form-preview .ui-panelgrid-cell`, `.form-grid ...` (199-201,312-314) | LEGACY PRIMEFACES DOM DEPENDENCY; LIKELY REQUIRES MIGRATION | Grid cell markup/padding and deprecated PF grid layout need checking. |
| Input/select/calendar/autocomplete/textarea (203-221) | LEGACY PRIMEFACES DOM DEPENDENCY; LIKELY REQUIRES MIGRATION; RUNTIME VISUAL VALIDATION REQUIRED | Preserve borders and focus; calendar-to-datePicker later requires selector review, not early conversion. |
| Buttons, secondary/warning variants and hover (223-265) | LEGACY PRIMEFACES DOM DEPENDENCY; LIKELY REQUIRES MIGRATION; RUNTIME VISUAL VALIDATION REQUIRED | Preserve action colors, shadows, geometry and states under target specificity. |
| Table wrapper, `thead th`, `tbody td` (267-280) | LEGACY PRIMEFACES DOM DEPENDENCY; LIKELY REQUIRES MIGRATION | Verify headers, sort/filter icons, cells, pagination and expansion; lexical class presence is insufficient. |
| Status pills/two-column/report/elements layout (282-310) | THEME-INDEPENDENT; RUNTIME VISUAL VALIDATION REQUIRED | Preserve labels, borders, CSS Grid and widths. |
| Selection summary/action row (316-329) | THEME-INDEPENDENT; RUNTIME VISUAL VALIDATION REQUIRED | Preserve blue indicator, flex wrapping and gaps. |
| `.side-menu.ui-menu` (331-335) | LEGACY PRIMEFACES DOM DEPENDENCY; LIKELY REQUIRES MIGRATION | Check menu sizing/borders and interactive states. |
| Links/expanded row/hidden export/tag/progress/status (337-377) | THEME-INDEPENDENT; RUNTIME VISUAL VALIDATION REQUIRED | Keep hidden export table hidden and AJAX status visible without overlap; check expansion/polling behavior. |
| `.ui-dialog`, title bar (379-387) | LEGACY PRIMEFACES DOM DEPENDENCY; LIKELY REQUIRES MIGRATION | Verify overlay, title/button contrast, sizing, positioning, keyboard focus. |
| Growl/message status selectors (389-394) | LEGACY PRIMEFACES DOM DEPENDENCY; RUNTIME VISUAL VALIDATION REQUIRED | Check all severities, placement and duplication. |
| `@media (max-width:900px)` (396-412) | THEME-INDEPENDENT for grids/brand; LEGACY PRIMEFACES DOM DEPENDENCY for menubar; RUNTIME VISUAL VALIDATION REQUIRED | Compare below/above breakpoint, narrow mobile width, overflow and keyboard interaction. |

**OMEGA-SPECIFIC:** No proven Omega-named local selector/rule. Do not label every ui class Omega-specific: these are legacy component/DOM dependencies across themes. The custom stylesheet's colors/layout overrides embody the intended visual design, not proof of an Omega template.

Additional XHTML coupling:
- `WEB-INF/templates/main.xhtml:25-30`: menubar and five `ui-icon-*` navigation icons.
- `elements.xhtml`: menu icons, confirmation `ui-icon-alert`, `ui-confirmdialog-yes/no` button classes, PF panelGrid/grid layout, date/editor/upload/table/dialog/progress surfaces.
- `home.xhtml`, `reports.xhtml`: grid-layout panels; `employees.xhtml`, `dashboard.xhtml`, `reports.xhtml`: custom table/panel classes.
- No custom paginator selector was found, but rendered paginator buttons/icons/states remain mandatory visual checks.

## Mandatory execution and state contract

For **every MIG-04 through MIG-08**, before dependency/source edits:

1. Reconcile current declared theme, actual explicit configuration, resource requests and artifact origin; inspect exact source/target JAR, theme JAR/classifier and WAR. Record whether external runtime configuration is unknown.
2. Record framework default separately from application theme. Detect missing CSS/fonts/icons and any implicit fallback. **UNCONTROLLED VISUAL CHANGE blocks progression** until explicit supported configuration is approved and applied; never silently accept Saga or another default.
3. Determine Omega status and selected concrete-theme compatibility. No undefined theme choice may be carried past its replacement gate.
4. Classify each affected custom rule and icon/layout dependency. Apply only stage-required approved changes; retain visual references and rollback artifact.
5. Evaluate browser gate and business IE requirements separately from code inventory. Missing IE-specific code does not prove IE is not required.
6. Build/test, inspect packaged resources, then evaluate runtime/browser visuals separately. Static success never implies resource resolution, visual equivalence or browser support.
7. Update `themeState`, `browserSupportState` and the matching `remainingPhaseGates` entry with evidence and report all fields below. Do not mark a stage complete with unassessed fields.

Mandatory stage report:

| Field | Allowed values / meaning |
|---|---|
| Theme compatibility | PASS / LEGACY / CHANGES REQUIRED / REPLACEMENT REQUIRED / RUNTIME VALIDATION REQUIRED |
| Current theme / target theme | Concrete names or explicitly UNDECIDED; never PrimeOne as theme |
| Omega status | SUPPORTED / LEGACY / INCOMPATIBLE / REPLACED; detailed status may state REMOVED or REQUIRES REPLACEMENT |
| Custom CSS impact | NONE / LOW / MEDIUM / HIGH |
| Visual validation | PASS / PARTIAL / DEFERRED |
| Browser compatibility | PASS / CHANGES REQUIRED / PRODUCT DECISION REQUIRED |
| IE-specific code detected | YES / NO (scan scope and evidence required) |
| IE support impact | NONE / LOW / MEDIUM / HIGH / CRITICAL; if business requirement unknown use provisional impact plus decision blocker |

Static gate PASS requires an approved explicit target theme and verified resolvable resources/dependencies. If no runtime, record **RUNTIME VISUAL VALIDATION DEFERRED** and use conditional completion only with explicit stage-specific user risk acceptance. Theme selection, unresolved static incompatibility and browser product decisions cannot be waived by a build-only pass. Final MIG-09 acceptance requires real visual/browser evidence; Omega must not remain unresolved.

## Browser dependency inventory and decisions

Application-wide scan of Java/XHTML/XML/CSS and resource inventory found **no application-owned** documentMode, navigator.userAgent, ActiveX, ms-prefixed JS APIs, -ms- CSS, IE conditional comments, compatibility-mode meta tags, legacy polyfills, IE-specific stylesheets or browser-specific workaround scripts. There are no standalone application JS files. Only direct dialog show/hide inline handlers are present. Framework-bundled compatibility code is not application code and must not be edited.

- `gradlew` Cygwin/MSYS handling and `gradlew.bat` are OS build-wrapper support, not Internet Explorer dependencies.
- CSS Grid, flexbox, gap and icon filtering are modern-browser compatibility surfaces, **not IE-only workarounds**. No support guarantee for the existing application on IE follows from a framework support table.
- **IERequired: UNKNOWN.** No tracked business/browser support policy or user analytics establishes it.
- Removal decisions: no application IE-only code currently identified to REMOVE. Retain Grid/flex/gap for other browsers. Future discoveries require individual REMOVE / RETAIN FOR OTHER BROWSERS / REPLACE / UNKNOWN — MANUAL REVIEW dispositions; no speculative cleanup now.
- Browser acceptance must specify named browser/version/OS combinations approved by product, including Chromium/Firefox/WebKit-based clients as relevant, responsive widths, keyboard/focus behavior and all component interactions. Do not invent a contractual support matrix from generic "modern browsers".

```text
CURRENT BROWSER SUPPORT (business matrix UNKNOWN)
 -> VERSION-SPECIFIC FRAMEWORK SUPPORT EVIDENCE
 -> IE SUPPORT REMOVAL GATE
 -> IE-SPECIFIC CODE REVIEW AND PRODUCT DECISION
 -> MODERN BROWSER VALIDATION
```

Before entering the first non-IE-supported target, require a recorded product decision. If IE remains mandatory, mark **MANUAL PRODUCT DECISION REQUIRED** and stop; do not add polyfills or claim unofficial IE compatibility. An unknown IE requirement also blocks that decision gate. Conditional runtime deferral does not waive it.

### Browser support matrix

| Phase / target | Version-specific IE evidence | Required application/product gate | Impact and validation |
|---|---|---|---|
| MIG-04 / PF11 | Before documented complete removal; no removal at this boundary established | Reconfirm browser requirements and exact target policy; inventory remains no IE-only application code | Provisional MEDIUM / LOW confidence because users/requirements unknown; runtime DEFERRED |
| MIG-05 / PF12 | Last major line before complete removal; PF12 retains IE detection/polyfills [S10] | Establish named browser matrix and IE requirement before PF13 | Framework code is not proof this app supports IE; runtime DEFERRED |
| MIG-06 / PF13 | **Internet Explorer support completely removed** [S9] | Recorded business decision mandatory; UNKNOWN or still required -> MANUAL PRODUCT DECISION REQUIRED, STOP | No proven application IE cleanup currently; supported-user impact remains unknown, provisional MEDIUM; assess before proceeding |
| MIG-07 / PF14 | Post-removal; no IE compatibility preservation assumed | Reconfirm decision, review any newly found workarounds individually | Validate approved modern browsers, keyboard/focus and responsive widths |
| MIG-08 / PF15 Jakarta | Post-removal | Reconfirm product matrix and final browser acceptance | Validate UI/resources on target runtime; no claim of IE support or visual equivalence from build |

The removal boundary is **MIG-06 (PF12 -> PF13)**, high-confidence upstream evidence. This does not constitute a comprehensive vendor browser/version certification for PF11/PF12 or imply IE works with this application's Grid/gap styling. There is no approved business support matrix yet. NO IMPACT cannot be concluded from a negative code scan.

## Required visual acceptance surfaces

For the corrective replacement and every subsequent target, compare reference and target screenshots plus interactions across overall page layout, header/navigation, menus, forms/input fields, buttons, dialogs, tables, sorting/filtering, pagination, row expansion, calendar/date controls, autocomplete, editor, upload, growl/messages, progress/polling, icons, fonts, spacing and responsive behavior. Exercise all five pages; test focus/keyboard, overlays, widths around 900px and narrower mobile widths. Inspect network/console for missing CSS/fonts/images and resource errors. Record browser/version/OS, viewport and evidence locations.

No reference runtime/screenshots are available now: visual equivalence is **NOT ESTABLISHED**. All inherited 13 runtime checks remain deferred independently of the new static theme gate. No resource rewrite, IE cleanup or replacement selection occurs in this planning task.

## Public release-tag evidence

All sources below are upstream public release tags; exact target binaries must still be inspected at execution. Confidence is HIGH for Omega removal, framework defaults and IE-removal boundary; LOW for deployed theme provenance, visual equivalence and business browser impact until runtime/product evidence exists.

- **S1:** [PF10 themes](https://github.com/primefaces/primefaces/blob/10.0.0/docs/10_0_0/core/themes.md#L18-L55); [PF10 migration guide: Omega removed](https://github.com/primefaces/primefaces/blob/10.0.0/docs/migrationguide/10_0_0.md#L21-L24).
- **S2:** [PF11 theme list/default](https://github.com/primefaces/primefaces/blob/11.0.0/docs/11_0_0/core/themes.md#L18-L31).
- **S3:** [PF12 theme list/default](https://github.com/primefaces/primefaces/blob/12.0.0/docs/12_0_0/core/themes.md#L18-L31).
- **S4:** [PF13 theme list/default](https://github.com/primefaces/primefaces/blob/13.0.0/docs/13_0_0/core/themes.md#L18-L31).
- **S5:** [PF14 theme list/default](https://github.com/primefaces/primefaces/blob/14.0.0/docs/14_0_0/core/themes.md#L18-L31).
- **S6:** [PF15 theme list/default/artifact](https://github.com/primefaces/primefaces/blob/15.0.0/docs/15_0_0/core/themes.md#L18-L27).
- **S7:** [PF15 legacy support and theme migration](https://github.com/primefaces/primefaces/blob/15.0.0/docs/migrationguide/15_0_0.md#L3-L28); [renderer aliases/default](https://github.com/primefaces/primefaces/blob/15.0.0/primefaces/src/main/java/org/primefaces/renderkit/HeadRenderer.java#L78-L120).
- **S8:** [PF15 additional themes artifact](https://github.com/primefaces/primefaces/blob/15.0.0/primefaces-themes/pom.xml#L4-L12).
- **S9:** [PF13 migration guide: IE removed](https://github.com/primefaces/primefaces/blob/13.0.0/docs/migrationguide/13_0_0.md#L1-L7).
- **S10:** [PF12 IE detection](https://github.com/primefaces/primefaces/blob/12.0.0/primefaces/src/main/resources/META-INF/resources/primefaces/core/core.env.js#L52-L72); [PF12 compatibility polyfills](https://github.com/primefaces/primefaces/blob/12.0.0/primefaces/src/main/resources/META-INF/resources/primefaces/core/core.polyfills.js#L1-L15).
