# EAP And PrimeFaces Modernization Assessment

## Executive Summary

This application is a small, self-contained JSF/PrimeFaces WAR with 11 Java source files, 6 Facelets pages, and 3 XML descriptors running on JBoss EAP 7.3.10 with Java 8. The migration to EAP 8.1 / Jakarta EE 10 / Java 21 / PrimeFaces 15 is straightforward in scope but involves namespace changes across every source and page file, a PrimeFaces major version jump (6 → 15) that may deprecate or rename components, and a Docker base image swap. Overall risk is **medium** due to PrimeFaces component compatibility uncertainty.

## Current Inventory

| Category | Detail |
|---|---|
| Build system | Gradle 8.x, WAR plugin, version catalog (`gradle/libs.versions.toml`) |
| Java version | Source/target 1.8 |
| Java EE API | `javax:javaee-api:8.0` (provided) |
| PrimeFaces | `org.primefaces:primefaces:6.2.30` (implementation) |
| Application server | JBoss EAP 7.3.10.GA (Docker image `registry.redhat.io/jboss-eap-7/eap73-openjdk8-openshift-rhel7:7.3.10-2`) |
| Java source files | 11 (5 view beans with `javax.*` imports, 6 model POJOs with no EE imports) |
| Facelets pages | 6 (all use `xmlns.jcp.org` Java EE namespaces) |
| XML descriptors | 3 (`web.xml` Servlet 4.0, `beans.xml` CDI 1.1, `jboss-web.xml`) |
| PrimeFaces components | 37+ unique components on `elements.xhtml` |
| Docker files | `Dockerfile` + `docker-compose.yml` |
| Tests | None (no test sources) |
| Context root | `/` (deployed as `ROOT.war`) |

## Migration Work Breakdown

### 1. Build & Dependencies

| Change | Files | Complexity |
|---|---|---|
| Java source/target 1.8 → 21 | `build.gradle` | Low |
| `javax:javaee-api:8.0` → `jakarta.platform:jakarta.jakartaee-api:10.0.0` | `gradle/libs.versions.toml`, `build.gradle` | Low |
| `org.primefaces:primefaces:6.2.30` → `org.primefaces:primefaces:15.0.16:jakarta` (classifier) | `gradle/libs.versions.toml`, `build.gradle` | Low |
| Remove local JAR fallback logic (if no longer needed) | `build.gradle` | Low |

### 2. Java Namespace Migration (`javax.*` → `jakarta.*`)

| Import | Occurrences | Files |
|---|---|---|
| `javax.enterprise.context.ApplicationScoped` | 4 | DashboardBean, EmployeeBean, HomeBean, ReportsBean |
| `javax.enterprise.context.SessionScoped` | 1 | ElementsBean |
| `javax.inject.Named` | 5 | All 5 view beans |
| `javax.faces.application.FacesMessage` | 1 | ElementsBean |
| `javax.faces.context.FacesContext` | 1 | ElementsBean |

**Total: 5 files, ~12 import lines to change.**

### 3. XML Descriptors

| File | Change | Complexity |
|---|---|---|
| `web.xml` | Namespace `xmlns.jcp.org/xml/ns/javaee` → `jakarta.ee/xml/ns/jakartaee`, schema version 4.0 → 6.0 | Medium |
| `beans.xml` | Namespace update, CDI version 1.1 → 4.0 | Medium |
| `jboss-web.xml` | Verify compatibility with EAP 8.1 (likely unchanged) | Low |

### 4. Facelets Namespace Migration

| Namespace | Replacement | Files affected |
|---|---|---|
| `http://xmlns.jcp.org/jsf/html` | `jakarta.faces.html` | 3 |
| `http://xmlns.jcp.org/jsf/core` | `jakarta.faces.core` | 2 |
| `http://xmlns.jcp.org/jsf/facelets` | `jakarta.faces.facelets` | 6 |

**Total: 6 XHTML files.**

### 5. PrimeFaces Component Compatibility (6 → 15)

The `elements.xhtml` page uses 37+ PrimeFaces components. Key risks:

| Component | Risk | Notes |
|---|---|---|
| `p:calendar` | High | Deprecated in PF 11+; replaced by `p:datePicker` |
| `p:textEditor` | Medium | API changes between major versions |
| `p:fileUpload` | Medium | Servlet API and configuration changes in Jakarta EE 10 |
| `p:dataExporter` | Medium | API signature changes in PF 12+ |
| `p:defaultCommand` | Low-Medium | Behavior changes in newer versions |
| `p:selectManyMenu` | Medium | Deprecated/removed in PF 14; may need `p:selectManyCheckbox` or custom |
| Other components | Low | Most standard components carry forward |

### 6. Docker & Runtime

| Change | Complexity |
|---|---|
| Base image → EAP 8.1 on JDK 21 (e.g., `registry.redhat.io/jboss-eap-8/eap8-openjdk21-builder-openshift-rhel9`) | Medium |
| Platform may change from `linux/amd64` only to multi-arch | Low |
| Deployment path may change (`/opt/eap/` → `/opt/server/`) | Medium |
| `docker-compose.yml` image tag and args update | Low |

### 7. Documentation

| Change | Complexity |
|---|---|
| `README.md` version references and instructions | Low |

## Estimate

| Scenario | Phase 2 AWS Transform agent minutes | Human engineering review | Manual QA |
|---|---:|---:|---:|
| Low | 45 | 30 min | 30 min |
| Expected | 90 | 60 min | 60 min |
| High | 150 | 120 min | 120 min |

**Rationale:**
- The codebase is small (11 Java files, 6 pages, 3 descriptors).
- Namespace migration is mechanical and fast.
- PrimeFaces 6 → 15 component verification is the main variable: deprecated components (`p:calendar`, `p:selectManyMenu`) may require iterative fixes.
- Docker image availability and deployment path verification add minor uncertainty.

## Cost

| Scenario | Estimated Phase 2 agent minutes | Estimated AWS Transform cost |
|---|---:|---:|
| Low | 45 | $1.58 |
| Expected | 90 | $3.15 |
| High | 150 | $5.25 |

**Formula:** Estimated AWS Transform cost = Estimated Phase 2 migration agent minutes × USD 0.035 per agent minute.

**Pricing reference:** USD 0.035 per agent minute as of 2026-06-24, per https://aws.amazon.com/transform/pricing/.

> **Note:** The current price must be verified at execution time from the AWS pricing page, as pricing can change. Local builds, local file reads, and user idle time are not charged as agent minutes.

### Human Engineering Review Cost Estimate

| Scenario | Review + QA hours | Estimated cost (at $150/hr blended rate) |
|---|---:|---:|
| Low | 1.0 | $150 |
| Expected | 2.0 | $300 |
| High | 4.0 | $600 |

## Risks And Blockers

| Risk | Severity | Mitigation |
|---|---|---|
| PrimeFaces `p:calendar` removed in PF 11+ | High | Replace with `p:datePicker`; verify attributes map correctly |
| PrimeFaces `p:selectManyMenu` deprecated/removed in PF 14+ | Medium | Replace with equivalent component or verify PF 15 status |
| `p:fileUpload` servlet changes under Jakarta EE 10 | Medium | Test upload functionality; may need config in `web.xml` |
| EAP 8.1 Docker image availability and registry access | Medium | Verify Red Hat registry credentials and image existence |
| EAP 8.1 deployment directory structure differs from 7.3 | Medium | Verify correct WAR deployment path |
| No existing tests to catch regressions | High | Manual QA required for all 5 pages post-migration |
| PrimeFaces 15 may have breaking JS/CSS changes | Low | Visual inspection of elements.xhtml page |

### Blockers

1. **Red Hat registry access** — EAP 8.1 images require an active Red Hat subscription. Verify credentials before Phase 2.
2. **PrimeFaces 15.0.16 Jakarta classifier availability** — Confirm the artifact `org.primefaces:primefaces:15.0.16:jakarta` is published on Maven Central.

## Migration Phase Inputs

The following assumptions and instructions should guide Phase 2 execution:

1. **Java version:** Upgrade source/target compatibility to Java 21.
2. **Jakarta EE API:** Replace `javax:javaee-api:8.0` with `jakarta.platform:jakarta.jakartaee-api:10.0.0`.
3. **PrimeFaces:** Replace with `org.primefaces:primefaces:15.0.16` using the `jakarta` classifier.
4. **Java sources:** Mechanically replace all `javax.enterprise.*` → `jakarta.enterprise.*`, `javax.inject.*` → `jakarta.inject.*`, `javax.faces.*` → `jakarta.faces.*`.
5. **Facelets:** Replace `xmlns.jcp.org/jsf/*` namespaces with Jakarta Faces equivalents.
6. **Descriptors:** Update `web.xml` to Servlet 6.0 / Jakarta EE 10 schema; update `beans.xml` to CDI 4.0 schema.
7. **PrimeFaces components:** Replace `p:calendar` with `p:datePicker`; verify `p:selectManyMenu` status; test all 37 components.
8. **Docker:** Switch to EAP 8.1 JDK 21 image; update deployment path if needed.
9. **Context root:** Maintain `/` via `jboss-web.xml` or EAP 8.1 equivalent mechanism.
10. **WAR name:** Keep `primefaces-homeoffice.war` deployed as `ROOT.war`.
11. **No authentication/database/JPA/REST** — no additional migration needed for those layers.

## Go / No-Go

### Recommendation: **GO**

This is a small, well-scoped application with no external integrations, no database, and no tests to break. The migration is primarily mechanical namespace changes plus PrimeFaces component updates.

### Prerequisites before Phase 2:

- [ ] Confirm Red Hat registry credentials for EAP 8.1 image pull.
- [ ] Confirm `org.primefaces:primefaces:15.0.16:jakarta` is available on Maven Central.
- [ ] Confirm target EAP 8.1 Docker image name and tag.
- [ ] Decide on Gradle version (current wrapper should support Java 21; verify).
- [ ] Accept that manual QA of all 5 pages is required post-migration (no automated tests exist).
