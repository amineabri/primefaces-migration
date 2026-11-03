# Jakarta EE Migration Report

## Scope and Platform Boundary

**MIG-08 current execution addendum:** Completed conditionally through ordered A-F build/static gates. JavaEE8 -> JakartaEE10 provided API (Faces4.0.1/CDI4/Servlet6), PF15.0.16 **jakarta** classifier, twelve imports in five beans, web6/CDI4 descriptors, Jakarta Faces namespaces across six XHTML files and explicit saga-blue. `UploadedFile` package was already correct from MIG-02; no new API relocation required. Vendor context-root-only jboss-web7.2 retained rather than rewriting its namespace. Java21 toolchain/source/target/release builds via Gradle8.4 daemon on JDK11. User explicitly selected runtime/image provisioning deferral and deployment guard; no EAP8.1 deployment claimed. Earlier “current” inventory below is assessment history.

Application source/build config/packaged classes contain **zero javax references**. Exact PF15Jakarta dependency retains **60 literal occurrences**:24valid JavaSE references (imageio/XML),32embedded Maven source/transformer metadata,4old signature strings across3classes used in serialized-lambda deserialization checks. javap/jdeps distinguish strings from actual legacy EE type links. No unexplained or missed application migration remains; vendor deserialization/passivation behavior is a recorded risk, not silently patched or called harmless. All inherited runtime checks remain, MIG-09 NOT started.

Current application platform is Java EE 8 with `javax.*` APIs and EAP 7.3.10/OpenJDK 8. Target is Jakarta EE 10, EAP 8.1, Java 21, and PrimeFaces 15.0.16 Jakarta. This transition requires coordinated platform dependencies, imports, descriptors, and runtime; changing only the PrimeFaces classifier is insufficient.

## Namespace Inventory

| Surface | Current usage | Count / files | Target action | Automation / review |
|---|---|---|---|---|
| CDI scope imports | `javax.enterprise.context.ApplicationScoped` (4) and `SessionScoped` (1) | 5 across DashboardBean, EmployeeBean, HomeBean, ReportsBean, ElementsBean | Replace with `jakarta.enterprise.context.*` | Mechanical replace; compile and verify CDI |
| Injection | `javax.inject.Named` | 5 across all view beans | Replace with `jakarta.inject.Named` | Mechanical replace; verify EL names resolve |
| Faces message/context | `javax.faces.application.FacesMessage`, `javax.faces.context.FacesContext` | 2 in ElementsBean | Replace with `jakarta.faces.*` | Mechanical replace; exercise message action |
| Faces context params | `javax.faces.PROJECT_STAGE`, `javax.faces.FACELETS_SKIP_COMMENTS` | 2 in web.xml | Rename to Jakarta Faces parameter names | Mechanical literal update; validate server behavior |
| Faces servlet | `javax.faces.webapp.FacesServlet` | 1 in web.xml | `jakarta.faces.webapp.FacesServlet` | Mechanical literal update; deploy/test routes |
| Build API coordinate | `javax:javaee-api:8.0` | version catalog + dependency alias | Jakarta EE 10 API, provided | Coordinate with EAP version and compile |
| PrimeFaces API | `org.primefaces.model.UploadedFile` | ElementsBean | `org.primefaces.model.file.UploadedFile` per repository skill | Import update; inspect methods and test upload |

No `jakarta.*` imports currently appear in Java sources. Counts exclude Java SE APIs.

## XML Descriptor Conversion

| Descriptor | Current | Target treatment | Validation |
|---|---|---|---|
| `WEB-INF/web.xml` | JCP namespace; web-app 4.0; Java EE schema; `javax.faces` parameters and servlet class | Jakarta EE web descriptor appropriate for Jakarta EE 10/Servlet 6.0 | XML/schema acceptance on EAP 8.1; Faces servlet routes; preserve multipart caps and `*.xhtml` mapping |
| `WEB-INF/beans.xml` | Java EE beans 1.1 schema/version, annotated discovery | Jakarta CDI descriptor schema/version for target; preserve `bean-discovery-mode="annotated"` | CDI startup and all named bean references resolve |
| `WEB-INF/jboss-web.xml` | JBoss web 7.2 schema, context root `/` | Use schema accepted by EAP 8.1; retain root context | Deployment log and URL `/` |
| `faces-config.xml` | Not found | No migration unless additional file is discovered | Repository scan |
| `persistence.xml` | Not found | No persistence descriptor conversion | Repository scan |
| Tag library descriptors | None found | None to migrate | Repository scan |

## CDI, JPA, Servlet, Validation, and JSF

- **CDI:** five named beans use `ApplicationScoped` or `SessionScoped`; beans descriptor currently explicitly selects annotated discovery. Namespace conversion is mechanical, while CDI behavior and serializability/passivation should be verified on target.
- **JPA:** no dependency, imports, entities, datasource, or `persistence.xml`; no JPA conversion.
- **Servlet:** application uses only the Faces servlet declared in `web.xml`; no user-written servlet/filter/listener imports were found. Servlet API is server-provided.
- **Validation:** no validation API imports or dependency found.
- **JSF/Faces:** only direct APIs are `FacesMessage`, `FacesContext`, servlet class, and context parameters. No `faces-config.xml`, JSP, custom handlers, or implementation dependency found. Confirm Jakarta Faces resource and Facelets behavior.
- **PrimeFaces:** PrimeFaces Jakarta artifact is required with Jakarta EE runtime. The `UploadedFile` class package and upload behavior are explicit checks. Keep PrimeFaces XML namespace as documented in project skill.

## Build and Server Dependencies

Replace `javax:javaee-api:8.0` with the selected Jakarta EE 10 API as `provided`; do not bundle a second EE implementation. Verify Gradle wrapper 8.4 under Java 21; upgrade wrapper/toolchain only based on build evidence. EAP 8.1 supplies the platform services, including Faces, CDI, and Servlet. Confirm its image and registry access before running the final stage.

## Automation Classification

**Safe mechanical candidates:** Java import prefixes in the five known beans; literal Faces parameter and servlet class values; Java EE API catalog coordinate/version; descriptor namespace/schema/version template; Docker image strings. They still need diff review and compilation/deployment verification.

**Requires semantic review:** exact EE API module/scope, target EAP descriptor schemas, `jboss-web.xml` compatibility, PrimeFaces event/file methods and component tag attributes, CDI bean resolution, file upload limits/behavior, Faces resources, CSS/client-side behavior, and Linux image architecture.

## Acceptance Conditions

1. No application-managed Java EE EE API imports remain in source; distinguish Java SE `javax.*` packages.
2. Target EE dependency is Jakarta EE 10 and remains provided.
3. WAR does not bundle duplicate Servlet/Faces/CDI APIs.
4. All three descriptors parse and deploy on EAP 8.1; root context `/` remains.
5. CDI beans resolve and all pages render.
6. PrimeFaces 15 Jakarta upload, messages, date input, tables, exporter, editor, and AJAX behaviors pass.
7. Target container starts with no classloading/deployment errors.
