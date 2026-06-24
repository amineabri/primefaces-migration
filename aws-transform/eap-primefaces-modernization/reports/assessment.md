# EAP And PrimeFaces Modernization Assessment

## Executive Summary

This application is a small, self-contained JSF/PrimeFaces WAR with no database, REST, JPA, authentication, or messaging layers. The migration from JBoss EAP 7.3 / Java EE 8 / Java 8 / PrimeFaces 6.2.30 to JBoss EAP 8.1 / Jakarta EE 10 / Java 21 / PrimeFaces 15.0.16 is straightforward in scope but carries medium risk due to the breadth of PrimeFaces components on the Elements page (37 distinct component types) that require compatibility verification against PrimeFaces 15.

Expected effort: 15–30 AWS Transform agent-minutes plus 1–3 hours of human review and manual QA.

## Current Inventory

| Category | Count / Value |
|----------|---------------|
| Build system | Gradle 8.x WAR project with version catalog |
| Java source compatibility | Java 8 (source + target) |
| Java EE API | `javax:javaee-api:8.0` (provided) |
| PrimeFaces | `org.primefaces:primefaces:6.2.30` |
| Java source files | 11 (6 model POJOs, 5 CDI view beans) |
| Facelets XHTML pages | 6 (1 template + 5 pages) |
| XML descriptors | 3 (web.xml, beans.xml, jboss-web.xml) |
| CSS files | 1 (app.css) |
| Docker files | 2 (Dockerfile, docker-compose.yml) |
| Runtime image | `registry.redhat.io/jboss-eap-7/eap73-openjdk8-openshift-rhel7:7.3.10-2` |
| Deployment | ROOT.war at context root `/` |
| Test framework | None |

## Migration Work Breakdown

### 1. Build and Dependencies

| Item | Change Required |
|------|-----------------|
| `gradle/libs.versions.toml` | Update `javaee` to Jakarta EE 10 artifact (`jakarta.platform:jakarta.jakartaee-api:10.0.0`), update `primefaces` to `15.0.16` with Jakarta classifier |
| `build.gradle` | Change `sourceCompatibility`/`targetCompatibility` to Java 21, update dependency coordinates from `javax:javaee-api` to `jakarta.platform:jakarta.jakartaee-api`, add Jakarta classifier for PrimeFaces |
| Local JAR fallback | Verify `libs/` directory handling still works or remove if unused |

**Complexity: Low**

### 2. Java Source — Namespace Migration

| File | javax.* Imports to Migrate |
|------|----------------------------|
| DashboardBean.java | `javax.enterprise.context.ApplicationScoped`, `javax.inject.Named` |
| EmployeeBean.java | `javax.enterprise.context.ApplicationScoped`, `javax.inject.Named` |
| HomeBean.java | `javax.enterprise.context.ApplicationScoped`, `javax.inject.Named` |
| ReportsBean.java | `javax.enterprise.context.ApplicationScoped`, `javax.inject.Named` |
| ElementsBean.java | `javax.enterprise.context.SessionScoped`, `javax.inject.Named`, `javax.faces.application.FacesMessage`, `javax.faces.context.FacesContext` |
| Model classes (6 files) | No javax.* imports — no changes needed |

**Total Java files requiring changes: 5 of 11**
**Complexity: Low** — mechanical find-and-replace of `javax.` → `jakarta.` for CDI/Faces packages.

### 3. XML Descriptors

| File | Changes |
|------|---------|
| `web.xml` | Update namespace from `http://xmlns.jcp.org/xml/ns/javaee` to `https://jakarta.ee/xml/ns/jakartaee`, schema to `web-app_6_0.xsd`, version to `6.0`, rename `javax.faces.*` context-params to `jakarta.faces.*`, rename servlet class to `jakarta.faces.webapp.FacesServlet` |
| `beans.xml` | Update namespace to `https://jakarta.ee/xml/ns/jakartaee`, schema to `beans_4_0.xsd`, version to `4.0` |
| `jboss-web.xml` | Verify compatibility with EAP 8.1 schema; likely minimal or no changes needed for context-root declaration |

**Complexity: Medium** — schema URIs and parameter names must be precise.

### 4. Facelets / XHTML Pages

| File | Changes |
|------|---------|
| main.xhtml (template) | Update `xmlns:h`, `xmlns:ui` from `http://xmlns.jcp.org/jsf/*` to `jakarta.faces.` equivalents |
| home.xhtml | Same namespace updates |
| dashboard.xhtml | Same namespace updates |
| employees.xhtml | Same namespace updates |
| reports.xhtml | Same namespace updates |
| elements.xhtml | Same namespace updates + PrimeFaces component compatibility review |

**Namespace changes:**
- `http://xmlns.jcp.org/jsf/html` → `jakarta.faces.html`
- `http://xmlns.jcp.org/jsf/core` → `jakarta.faces.core`
- `http://xmlns.jcp.org/jsf/facelets` → `jakarta.faces.facelets`
- `http://primefaces.org/ui` → remains unchanged (PrimeFaces namespace is version-independent)

**Complexity: Low-Medium**

### 5. PrimeFaces 6.2.30 → 15.0.16 Component Compatibility

The `elements.xhtml` page uses 37 distinct PrimeFaces component types. Key migration concerns:

| Component | Risk | Notes |
|-----------|------|-------|
| `p:textEditor` | Medium | Underlying Quill.js integration changed significantly between PF 6 and PF 15 |
| `p:fileUpload` | Medium | API changed: `UploadedFile` moved to different package, `mode="advanced"` behavior updated |
| `p:dataExporter` | Medium | API and attribute changes in newer versions |
| `p:calendar` | High | Deprecated in PF 11+; replaced by `p:datePicker`. May still work but is legacy |
| `p:autoComplete` | Low | Largely backward-compatible |
| `p:dataTable` (sort/filter/paginate) | Low | Core functionality preserved; some attribute renames possible |
| `p:poll` | Low | Stable across versions |
| `p:confirmDialog` + `p:confirm` | Medium | Global confirm mechanism changed in PF 10+ |
| All other components | Low | Generally backward-compatible |

**ElementsBean.java additionally imports:**
- `org.primefaces.event.FileUploadEvent` — package path may change in Jakarta classifier
- `org.primefaces.model.UploadedFile` — renamed to `org.primefaces.model.file.UploadedFile` in PF 8+

**Complexity: Medium-High** — requires careful testing of the Elements page.

### 6. Docker

| File | Changes |
|------|---------|
| Dockerfile | Change base image from EAP 7.3 OpenJDK 8 to EAP 8.1 OpenJDK 21 image; update deployment path if needed |
| docker-compose.yml | Update image reference and tag |

**Target image (example):** `registry.redhat.io/jboss-eap-8/eap8-openjdk21-builder-openshift-rhel9` (exact tag depends on Red Hat registry availability)

**Complexity: Low-Medium** — depends on Red Hat registry access and available EAP 8.1 images.

### 7. Documentation

| File | Changes |
|------|---------|
| README.md | Update version references, build instructions, and technology descriptions |

**Complexity: Low**

## Estimate

| Metric | Low | Expected | High |
|--------|-----|----------|------|
| AWS Transform agent-minutes | 10 | 20 | 35 |
| Human engineering review (hours) | 0.5 | 1.5 | 3 |
| Manual QA — functional verification (hours) | 0.5 | 1 | 2 |
| Calendar duration (days) | 1 | 1 | 2 |

### Rationale

- **Build/dependency changes** are mechanical and well-defined (~3–5 agent-minutes).
- **Java namespace migration** across 5 files is trivial (~2–3 agent-minutes).
- **XML descriptor updates** require precise schema knowledge (~3–5 agent-minutes).
- **Facelets namespace updates** across 6 files (~2–3 agent-minutes).
- **PrimeFaces component compatibility** is the largest uncertainty. The Elements page exercises 37 component types, some with known breaking changes (calendar → datePicker, fileUpload API, confirmDialog). This may require iterative fixes (~5–15 agent-minutes).
- **Docker image update** depends on available EAP 8.1 images (~2–3 agent-minutes).
- **Human review** is needed to visually verify PrimeFaces component rendering and behavior.

## Cost

**Formula:**

```
Estimated AWS Transform cost = agent-minutes × current AWS Transform agent-minute price
```

Using the expected estimate of 20 agent-minutes:

```
Estimated cost = 20 × [current agent-minute price from AWS pricing]
```

> **Note:** The current AWS Transform custom transformation agent-minute price must be checked at execution time from the [AWS Pricing Calculator](https://calculator.aws) or the AWS Transform pricing page, as pricing is subject to change.

## Risks And Blockers

| Risk | Severity | Mitigation |
|------|----------|------------|
| `p:calendar` deprecated in PF 11+ | Medium | Replace with `p:datePicker`; requires attribute mapping and potential bean changes |
| `org.primefaces.model.UploadedFile` package relocation | Medium | Update import to `org.primefaces.model.file.UploadedFile` |
| `p:confirmDialog` global confirm API changes | Medium | Update to PF 10+ global confirm pattern |
| `p:textEditor` Quill integration changes | Medium | Verify editor still renders; may need attribute updates |
| Red Hat EAP 8.1 container image availability | Low-Medium | Verify image exists and is accessible; may need registry authentication |
| No test suite exists | Medium | All verification must be manual; no automated regression safety net |
| PrimeFaces 15 Jakarta classifier artifact availability | Low | Verify Maven Central has `org.primefaces:primefaces:15.0.16:jakarta` |
| `p:dataExporter` attribute changes | Low | Verify CSV export still functions |

### Blockers

- **None identified** — all risks have known mitigations. The migration can proceed to Phase 2.

## Migration Phase Inputs

### Assumptions for Phase 2

1. Target PrimeFaces artifact: `org.primefaces:primefaces:15.0.16:jakarta`
2. Target Jakarta EE API: `jakarta.platform:jakarta.jakartaee-api:10.0.0` (provided scope)
3. Target Java version: 21 (source and target compatibility)
4. Target EAP image: Red Hat EAP 8.1 with OpenJDK 21 (exact registry path TBD at migration time)
5. `p:calendar` should be replaced with `p:datePicker`
6. `org.primefaces.model.UploadedFile` → `org.primefaces.model.file.UploadedFile`
7. `org.primefaces.event.FileUploadEvent` — verify package path in PF 15 Jakarta
8. All `javax.*` imports in Java → corresponding `jakarta.*` equivalents
9. All `http://xmlns.jcp.org/jsf/*` namespaces → `jakarta.faces.*` equivalents
10. web.xml and beans.xml schemas → Jakarta EE 10 equivalents
11. Context root `/` preserved via jboss-web.xml
12. WAR file name `primefaces-homeoffice.war` deployed as `ROOT.war` in container

### Recommended Migration Order

1. Build system (Gradle + version catalog)
2. Java source namespace migration
3. XML descriptors
4. Facelets namespace migration
5. PrimeFaces component compatibility fixes
6. Docker image update
7. Documentation update
8. Build verification + manual smoke test

## Go / No-Go

**Recommendation: GO**

**Prerequisites before starting Phase 2:**
- [ ] Confirm access to Red Hat container registry for EAP 8.1 images
- [ ] Confirm PrimeFaces 15.0.16 Jakarta classifier is available on Maven Central
- [ ] Acknowledge that no automated test suite exists; manual QA is required
- [ ] Accept medium risk on PrimeFaces Elements page — some components may need rework

**Overall risk rating: MEDIUM** — the application is small and well-structured, but the breadth of PrimeFaces components and lack of automated tests increase verification effort.
