# API / Namespace Compatibility Report

Line references are current source locations. Target API names are the intended Jakarta/PrimeFaces equivalents described by the repository target; compile and taglib validation must confirm exact symbols for the chosen releases.

| Finding | Current API | Required API | Files | Complexity | Recommended Change |
|---|---|---|---|---|---|
| ATX-FIND-004 | `javax.enterprise.context.ApplicationScoped` | `jakarta.enterprise.context.ApplicationScoped` | `DashboardBean.java:10`, `EmployeeBean.java:9`, `HomeBean.java:9`, `ReportsBean.java:9` | LOW | Replace imports and compile against Jakarta EE 10 |
| ATX-FIND-004 | `javax.enterprise.context.SessionScoped` | `jakarta.enterprise.context.SessionScoped` | `ElementsBean.java:13` | LOW | Replace import; validate session bean/passivation behavior |
| ATX-FIND-004 | `javax.inject.Named` | `jakarta.inject.Named` | All five view beans: lines 10/11/16 as above | LOW | Replace imports; confirm EL bean names resolve |
| ATX-FIND-004 | `javax.faces.application.FacesMessage` | `jakarta.faces.application.FacesMessage` | `ElementsBean.java:14` | LOW | Replace import and verify messages display |
| ATX-FIND-004 | `javax.faces.context.FacesContext` | `jakarta.faces.context.FacesContext` | `ElementsBean.java:15` | LOW | Replace import; verify message/request context behavior |
| ATX-FIND-005 | `<param-name>javax.faces.PROJECT_STAGE</param-name>` | `jakarta.faces.PROJECT_STAGE` | `WEB-INF/web.xml:9-12` | LOW | Rename context parameter |
| ATX-FIND-005 | `<param-name>javax.faces.FACELETS_SKIP_COMMENTS</param-name>` | `jakarta.faces.FACELETS_SKIP_COMMENTS` | `WEB-INF/web.xml:14-17` | LOW | Rename context parameter |
| ATX-FIND-005 | `javax.faces.webapp.FacesServlet` | `jakarta.faces.webapp.FacesServlet` | `WEB-INF/web.xml:24-33` | LOW | Update servlet class, retain `*.xhtml` mapping and multipart config |
| ATX-FIND-005 | Java EE/JCP `web-app_4_0.xsd`, version 4.0 | Jakarta EE web descriptor for Servlet 6.0 | `WEB-INF/web.xml:2-5` | MEDIUM | Convert namespace/schema/version; validate on EAP 8.1 |
| ATX-FIND-005 | CDI beans schema 1.1 | Jakarta CDI descriptor schema/version supported by EE 10 | `WEB-INF/beans.xml:2-6` | LOW-MEDIUM | Convert schema/version; retain annotated discovery |
| ATX-FIND-005 | JBoss web schema 7.2 | EAP 8.1-supported `jboss-web.xml` schema | `WEB-INF/jboss-web.xml:2-6` | MEDIUM | Validate accepted descriptor schema and preserve `/` |
| ATX-FIND-007 | `org.primefaces.model.UploadedFile` | `org.primefaces.model.file.UploadedFile` per project modernization skill | `ElementsBean.java:5,49,202,206` | LOW | Update import/type and validate target method names/signatures |
| ATX-FIND-007 | `FileUploadEvent` and event listener signature | Target PrimeFaces Jakarta event API | `ElementsBean.java:4,84`; `elements.xhtml:211-220` | MEDIUM | Verify package, listener binding, multipart handling and file API with PF 15 |
| ATX-FIND-008 | `p:calendar` with `pattern`, `showOn`, `dateSelect` | `p:datePicker` target syntax/attributes | `elements.xhtml:55-57` | MEDIUM | Convert according to exact transition where required; test formatting and AJAX |
| ATX-FIND-009 | `p:growl` and nested `p:autoUpdate` | Supported `p:messages`/message update pattern | `elements.xhtml:18-20`; messages at 22 | LOW-MEDIUM | Remove/replace only when target taglib requires; verify no lost/duplicated feedback |
| ATX-FIND-010 | `p:dataTable`/column `sortBy` and `filterBy` EL | Target taglib's accepted expressions | `employees.xhtml:22-34`; `elements.xhtml:150-159` | MEDIUM | Check exact target release semantics and ensure sort/filter still work |
| ATX-FIND-010 | `p:dataExporter` CSV | Target PF exporter API | `elements.xhtml:180-182` | LOW-MEDIUM | Verify downloaded CSV and data encoding after each relevant stage |
| ATX-FIND-010 | `p:textEditor` | Target PF editor/Quill API and security mode | `elements.xhtml:189-194` | MEDIUM | Verify value binding and target secure-mode requirements; follow skill guidance |
| ATX-FIND-010 | PF JS widget/theme classes | Target client resources and CSS classes | `app.css`; `elements.xhtml`; `WEB-INF/templates/main.xhtml` | MEDIUM | No custom JS detected; perform visual/browser-console regression |

## Application Server-Specific APIs

No Java imports from JBoss/EAP server-specific packages were found. Server coupling is through deployment image, `jboss-web.xml`, expected `/opt/eap/standalone/deployments/ROOT.war` path, numeric container user 185, port 8080, and root context. These are configuration-level target checks rather than Java API rewrites.

## JSF/Faces Changes

No `faces-config.xml`, custom converter/validator, phase listener, navigation handler, or JSF implementation library is present. The directly observed Faces APIs are `FacesMessage`, `FacesContext`, the Faces servlet and context parameters listed above. Facelets pages use standard XML namespaces; the PrimeFaces namespace remains `http://primefaces.org/ui` per the repository skill. Confirm any Jakarta Faces view namespace changes against the exact target framework rather than blanket-replacing XHTML namespaces.

## Non-findings

No `javax.persistence`, servlet filter/listener, validation, JMS, EJB, JAX-RS, or JAX-WS imports were found. Java SE packages beginning in `javax` are not, by themselves, Enterprise namespace violations; source/WAR scans must distinguish these from removed EE APIs.
