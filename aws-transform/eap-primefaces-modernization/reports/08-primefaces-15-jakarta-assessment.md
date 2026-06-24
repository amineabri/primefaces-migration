# PrimeFaces 14.0.0 to 15.0.16 Jakarta + EAP 8.1 / Jakarta EE 10 / Java 21 Assessment

## Scope

Upgrade PrimeFaces from **14.0.0** to **15.0.16** (Jakarta classifier) and cut over the runtime from **JBoss EAP 7.3 / Java EE 8 / Java 8** to **JBoss EAP 8.1 / Jakarta EE 10 / Java 21**. This is the final migration stage and encompasses all runtime, namespace, container, and descriptor changes.

### Project Inventory

| Metric | Value |
|--------|-------|
| Java source files | 11 |
| XHTML template/pages | 6 |
| XML descriptors (web.xml, beans.xml, jboss-web.xml) | 3 |
| Dockerfile + docker-compose.yml | 2 |
| Build files (build.gradle, settings.gradle, libs.versions.toml) | 3 |
| Java files with `javax.*` imports | 5 (12 import statements) |
| Java files with PrimeFaces imports | 1 (`FileUploadEvent`, `UploadedFile`) |
| PrimeFaces UI components in use | ~32 |

### Migration Work Items

| Work Area | Changes Required |
|-----------|-----------------|
| **Java namespace** | Replace 12 `javax.*` imports → `jakarta.*` across 5 files (`javax.enterprise.context` → `jakarta.enterprise.context`, `javax.inject` → `jakarta.inject`, `javax.faces` → `jakarta.faces`) |
| **web.xml** | Update namespace to `https://jakarta.ee/xml/ns/jakartaee`, schema to `web-app_6_0.xsd`, version to `6.0`; rename `javax.faces.*` context-params to `jakarta.faces.*`; servlet-class → `jakarta.faces.webapp.FacesServlet` |
| **beans.xml** | Update namespace to `https://jakarta.ee/xml/ns/jakartaee`, schema to `beans_4_0.xsd`, version to `4.0` |
| **jboss-web.xml** | Update schema/namespace for EAP 8.1 compatibility |
| **build.gradle** | Java sourceCompatibility → 21; replace `javax:javaee-api:8.0` → `jakarta.platform:jakarta.jakartaee-api:10.0.0` (provided); PrimeFaces → `org.primefaces:primefaces:15.0.16:jakarta` |
| **libs.versions.toml** | New version entries for Jakarta EE 10 and PrimeFaces 15.0.16 |
| **Dockerfile** | Base image → EAP 8.1 JDK 21 image (e.g., `registry.redhat.io/jboss-eap-8/eap8-openjdk21-builder-openshift-rhel9`) |
| **docker-compose.yml** | Update image reference / platform if needed |
| **PrimeFaces 14→15** | `UploadedFile` relocated to `org.primefaces.model.file.UploadedFile`; `FileUploadEvent` API stable; verify component deprecations; `p:datePicker` attribute changes |
| **Gradle wrapper** | May need Gradle 8.x+ for Java 21 toolchain support |

---

## Estimate

### PrimeFaces 14 → 15 (Jakarta) Breaking Changes Relevant to This Project

| Change Area | Impact | Files Affected |
|-------------|--------|----------------|
| `UploadedFile` package move to `org.primefaces.model.file` | Medium — import change + possible API method rename | 1 (ElementsBean.java) |
| `FileUploadEvent` package stable but verify | Low | 1 (ElementsBean.java) |
| Jakarta classifier artifact coordinates | Low — build config only | 1 (libs.versions.toml) |
| Component attribute deprecations (datePicker, dataTable) | Low — verify existing attributes | 2–4 XHTML files |
| Client-side widget changes | Low — no custom JS in project | 0 |
| CSP/AJAX token changes in PF 15 | Low — no custom security headers | 0 |

### Jakarta EE 10 / EAP 8.1 / Java 21 Changes

| Change Area | Impact | Files Affected |
|-------------|--------|----------------|
| `javax.*` → `jakarta.*` namespace in Java sources | Medium — mechanical but touches all beans | 5 Java files |
| XML descriptor namespace/schema updates | Medium — must be precise | 3 XML files |
| Java 21 source/target compatibility | Low — no Java 8-specific features in codebase | 1 (build.gradle) |
| Dockerfile base image replacement | Medium — must identify correct EAP 8.1 image | 1 (Dockerfile) |
| Gradle version upgrade for Java 21 support | Low–Medium — may require wrapper update | gradle-wrapper.properties |
| CDI 4.0 behavior changes (annotated mode) | Low — project already uses `bean-discovery-mode="annotated"` | 0 |
| JSF 4.0 (Faces 4.0) — removed JSP support, facelets only | Low — project is pure facelets | 0 |

### Agent Minutes Estimate

| Scenario | Agent Minutes | Rationale |
|----------|--------------|-----------|
| Low | 35 | Clean namespace swap, PF version bump compiles first try, Dockerfile image swap straightforward |
| Expected | 55 | Iterative fixes for PF 15 API changes (`UploadedFile` relocation), Gradle toolchain config, descriptor schema validation, one or two XHTML component fixes |
| High | 85 | Gradle upgrade complications, EAP 8.1 image availability issues requiring workarounds, multiple PF 15 component behavior regressions, CDI or Faces 4.0 edge cases |

---

## Cost

| Scenario | Agent Minutes | AWS Transform Cost (USD) |
|----------|--------------|--------------------------|
| Low | 35 | $1.23 |
| Expected | 55 | $1.93 |
| High | 85 | $2.98 |

> **Formula**: AWS Transform cost = estimated agent minutes × $0.035

### Human Effort

| Activity | Estimated Effort |
|----------|-----------------|
| Developer review of namespace + build changes | 1–2 hours |
| Verify EAP 8.1 deployment configuration | 1–2 hours |
| Manual UI smoke testing on EAP 8.1 | 1–2 hours |
| Java 21 compatibility review | 0.5–1 hour |
| **Total human effort** | **3.5–7 hours** |

### QA Effort

| Activity | Estimated Effort |
|----------|-----------------|
| Full functional regression (forms, tables, menus, file upload) | 3–4 hours |
| Jakarta namespace verification (no `javax` leakage) | 1 hour |
| Cross-browser visual check on new runtime | 1–2 hours |
| EAP 8.1 deployment/startup verification | 1 hour |
| **Total QA effort** | **6–8 hours** |

### Calendar Duration

| Phase | Duration |
|-------|----------|
| Automated migration (AWS Transform) | < 1 day |
| Developer review + manual fixes | 1 day |
| EAP 8.1 deployment testing | 0.5–1 day |
| QA regression cycle | 1–2 days |
| **Total elapsed** | **3–5 business days** |

---

## QA Focus

1. **Jakarta Namespace Integrity** — Verify zero `javax.*` references remain in compiled WAR (classes, descriptors). Scan with `grep -r "javax\."` on exploded WAR.
2. **EAP 8.1 Deployment** — Confirm WAR deploys cleanly to EAP 8.1 without classloading errors, missing module warnings, or startup exceptions.
3. **CDI Bean Resolution** — All `@Named` beans must resolve correctly under CDI 4.0. Test every page loads without `javax.enterprise.inject.UnsatisfiedResolutionException` (now `jakarta.*`).
4. **Faces Servlet Routing** — Confirm `*.xhtml` URL pattern serves pages correctly via `jakarta.faces.webapp.FacesServlet`.
5. **PrimeFaces Component Rendering** — Verify all 32 PF components render and function: `p:dataTable` (sort/filter/paginate), `p:datePicker`, `p:autoComplete`, `p:selectOneMenu`, `p:commandButton`, `p:menubar`.
6. **File Upload** — End-to-end test: `FileUploadEvent` / `UploadedFile` API works with PF 15 Jakarta on EAP 8.1 multipart handling.
7. **AJAX Operations** — All `p:ajax`, `p:commandButton`, `p:commandLink` interactions produce correct partial updates without JS errors.
8. **Java 21 Runtime** — No illegal reflective access warnings; no removed JDK API usage at runtime.
9. **Docker Build** — `docker build` succeeds with new EAP 8.1 base image; container starts and serves traffic on port 8080.

---

## Risks And Blockers

### Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| `UploadedFile` API breaking change in PF 15 (method renames/removals) | Medium | Medium | Check PF 15 migration guide; adapt `getContents()` → `getContent()` or similar |
| EAP 8.1 container image not available in target registry | Medium | High | Use `quay.io/wildfly/wildfly:31.0.0.Final-jdk21` as fallback or Red Hat certified image |
| Gradle wrapper incompatible with Java 21 (requires Gradle 8.5+) | Medium | Medium | Upgrade wrapper via `./gradlew wrapper --gradle-version=8.10` |
| CDI 4.0 empty beans.xml semantics change | Low | Medium | Explicitly set `bean-discovery-mode="annotated"` (already done) |
| JSF/Faces 4.0 removes deprecated view handlers | Low | Low | Project uses no custom view handlers |
| PrimeFaces theme incompatibility on EAP 8.1 resource serving | Low | Low | Verify PF resource servlet registers correctly |
| Java 21 sealed classes / module system conflicts with EAP classloading | Low | Medium | EAP 8.1 is designed for Java 21; unlikely but test at startup |

### Blockers

| Blocker | Status | Mitigation |
|---------|--------|------------|
| Red Hat EAP 8.1 container image requires active subscription | Potential | Use WildFly 31+ community image for dev/test; procure subscription for production |
| PrimeFaces 15.0.16 Jakarta classifier must exist on Maven Central | Verify | Confirm artifact `org.primefaces:primefaces:15.0.16:jakarta` is published |
| Gradle version must support Java 21 toolchain | Likely | Current project likely needs Gradle wrapper upgrade to 8.5+ |

---

## Recommendation

**Proceed with the upgrade.** This is the most complex single stage in the migration chain due to the simultaneous runtime, namespace, and library version change, but the project's small size (11 Java files, 6 XHTML pages, 3 descriptors) keeps the blast radius manageable.

**Key factors supporting proceeding:**

- All `javax` → `jakarta` changes are mechanical and well-tooled
- The project has no custom JSF extensions, phase listeners, or EAP-specific modules
- PrimeFaces 15.0.16 Jakarta is a stable release with documented migration path from 14
- EAP 8.1 is a certified Jakarta EE 10 runtime with known deployment model
- No database, JMS, or EJB dependencies — purely a CDI + JSF + PrimeFaces web tier
- Expected cost under $2.00 with AWS Transform

**Recommended execution order:**

1. Upgrade Gradle wrapper to 8.5+ (Java 21 toolchain support)
2. Update `build.gradle` — Java 21, Jakarta EE 10 API dependency
3. Update `libs.versions.toml` — PrimeFaces 15.0.16 Jakarta coordinates
4. Run `javax` → `jakarta` namespace replacement across Java sources
5. Update XML descriptors (web.xml, beans.xml, jboss-web.xml)
6. Fix PrimeFaces API changes (`UploadedFile` package relocation)
7. Verify build compiles: `./gradlew clean build`
8. Update Dockerfile to EAP 8.1 / Java 21 base image
9. Docker build + deployment smoke test
10. QA regression pass
