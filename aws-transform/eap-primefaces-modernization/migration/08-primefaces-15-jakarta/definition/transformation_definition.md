# Migration: PrimeFaces 14.0.0 To 15.0.16 Jakarta And EAP 8.1

Upgrade PrimeFaces from 14.0.0 to 15.0.16 with the Jakarta classifier and cut over to JBoss EAP 8.1, Jakarta EE 10, and Java 21.

Required changes:

- Update Java source and target compatibility to Java 21.
- Replace `javax:javaee-api:8.0` with `jakarta.platform:jakarta.jakartaee-api:10.0.0`.
- Update PrimeFaces to `15.0.16` with the `jakarta` classifier.
- Update local fallback naming to `libs/primefaces-15.0.16-jakarta.jar`.
- Replace Java imports from `javax.*` to `jakarta.*`.
- Update PrimeFaces upload imports from `org.primefaces.model.UploadedFile` to `org.primefaces.model.file.UploadedFile`.
- Update `WEB-INF/web.xml` to Jakarta EE web-app 6.0 and use `jakarta.faces.webapp.FacesServlet`.
- Update `WEB-INF/beans.xml` to Jakarta CDI 4 schema.
- Keep `WEB-INF/jboss-web.xml` context root as `/`.
- Update Facelets namespaces to Jakarta Faces:
  - `xmlns:h="jakarta.faces.html"`
  - `xmlns:f="jakarta.faces.core"`
  - `xmlns:ui="jakarta.faces.facelets"`
  - Keep `xmlns:p="http://primefaces.org/ui"`.
- Update Docker to `registry.redhat.io/jboss-eap-8/eap81-openjdk21-runtime-openshift-rhel9:latest`.
- Keep deployment as `ROOT.war` and port `8080`.

Validate with `./gradlew clean build`, `bash .aws/atx/skills/eap-primefaces-modernization/scripts/validate-modernized.sh`, `docker compose config`, and manual QA on `/` and `/elements.xhtml`.
