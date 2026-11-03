# Project / Module Analysis

## Project Summary

| Project/module | Path | Role | Current Java | Target Java | Framework/version | PrimeFaces | JSF implementation/version | EE level | Server dependency | Build | LOC indicators | Complexity | Readiness | Automation confidence | Effort (expected) |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `primefaces-homeoffice` | repository root; `src/main` | Single web application and deployable WAR | 8 | 21 | CDI + JSF/Facelets; implementation server-provided | 6.2.30 → 15.0.16 Jakarta | Not separately declared; assumed supplied by EAP; target Jakarta Faces 4.0 via EE 10 | Java EE 8 → Jakarta EE 10 | EAP 7.3.10 → EAP 8.1 | Gradle 8.4, `java`/`war` | Java 11 files / 571 lines; web 6 XHTML + 3 XML + 1 CSS / 951 lines | Low-medium overall; medium final stage | Moderate | Medium | 38.5 engineering hours / 5.1 days |

Only one project/module exists; therefore project counts and aggregate project estimates are both one. Physical LOC include blank/comment lines. Java source LOC is 571; webapp XHTML/XML/CSS LOC is 951; combined application surface is 1,522. Repo-wide tracked line count is approximately 4,612 but includes documentation, wrappers, staged assessment/migration recipes, and reports.

## `primefaces-homeoffice`

**Path:** root `build.gradle`, `gradle/`, `src/main/java`, `src/main/webapp`; Docker deployment at root.

**Role and structure:** Gradle `java`+`war` project producing `primefaces-homeoffice.war`. Six model/value classes provide serializable data; five CDI beans supply the five application pages. Six XHTML files consist of Home, Dashboard, Employees, Reports, Elements, and shared `WEB-INF/templates/main.xhtml`. The Elements page is the component/API demonstration page. Three descriptors configure Faces/web, CDI discovery, and JBoss context root.

**Current / target technology:** Java 8→21; Java EE 8→Jakarta EE 10; PrimeFaces 6.2.30→15.0.16 Jakarta; EAP 7.3.10/OpenJDK 8→EAP 8.1/Java 21. JSF implementation is not declared as an application dependency and is presumed server-provided. Target Jakarta Faces 4.0 is implied by Jakarta EE 10 and the repository target.

**Major dependencies:** `javax:javaee-api:8.0` in provided scope; `org.primefaces:primefaces:6.2.30` in implementation scope with optional local JAR override. Maven Central and `mavenLocal()` are configured. No external framework, persistence, security, logging, or test library is declared.

**Application size / complexity:** 571 Java lines; 951 webapp lines. Largest concentrated upgrade surface is `ElementsBean.java` (221 lines) and `elements.xhtml` (253 lines), plus CSS (412 lines). Complexity is low for the current app topology and medium for the final platform cutover.

**Migration readiness:** Moderate. The target and staged sequence are documented; baseline build and target image availability remain unverified. There is no automated behavioral test suite.

**Automation confidence:** Medium. Version bumps, namespace replacements, and many descriptor changes are automatable. Component semantics, uploaded file behavior, CSS/theme rendering, CDI resolution, and EAP deployment need human validation.

**Blockers / gates:** Confirm EAP 8.1 image and registry access; confirm PF 15.0.16 Jakarta artifact/local JAR provenance; establish baseline and Java 21 build; provide QA gates; verify container architecture.

**Estimated migration effort:** Best 25.5 h / 3.4 days; most likely 38.5 h / 5.1 days; high risk 59 h / 7.9 days. Confidence medium-low overall, based on the eight repository stage reports and product-delivery estimate, not observed work. One working day is 7.5 hours.

**Recommended path:** Baseline → PF 7 → 8 → 10 → 11 → 12 → 13 → 14 on current platform, QA after each → PF 15 Jakarta with EE 10, Java 21 and EAP 8.1 → final deployment and UI acceptance. Do not start migration as part of this assessment.

## Dependency Graph

```text
primefaces-homeoffice (single Gradle WAR)
  ├─ Java EE API 8.0, provided
  │    └─ runtime classes supplied by JBoss EAP 7.3
  └─ PrimeFaces 6.2.30, packaged (or optional local file)
       └─ WAR → ROOT.war → EAP 7.3/OpenJDK 8 container (linux/amd64)
```

There are no module-to-module edges. Target dependency relationship changes to provided Jakarta EE 10 APIs from EAP 8.1/Java 21 plus PrimeFaces 15 Jakarta packaged in the WAR.

## Counts and Evidence

| Count | Value | Evidence |
|---|---:|---|
| Gradle projects | 1 | `settings.gradle` sets a single root name; no `include` |
| Java sources | 11 | `src/main/java` inventory |
| Java source physical LOC | 571 | `wc -l` of `src/main/java/**/*.java` |
| XHTML files | 6 | `src/main/webapp/**/*.xhtml` |
| XML descriptors | 3 | `WEB-INF/web.xml`, `beans.xml`, `jboss-web.xml` |
| CSS files | 1 | `resources/css/app.css` |
| Webapp physical LOC | 951 | XHTML/XML/CSS source total |
| App physical LOC | 1,522 | Java + webapp totals above |
