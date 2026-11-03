# Migration: PrimeFaces 14.0.0 To 15.0.16 Jakarta And EAP 8.1

Upgrade PrimeFaces from 14.0.0 to 15.0.16 with the Jakarta classifier, Jakarta EE 10/Faces 4 and Java 21. MIG-08 user scope explicitly separates successful Jakarta build/static migration from deferred EAP8.1 image provisioning/runtime.

Required changes:

- Update Java source and target compatibility to Java 21.
- Replace `javax:javaee-api:8.0` with `jakarta.platform:jakarta.jakartaee-api:10.0.0`.
- Update PrimeFaces to `15.0.16` with the `jakarta` classifier.
- Update local fallback naming to `libs/primefaces-15.0.16-jakarta.jar`.
- Replace only the twelve known Jakarta EE imports, not arbitrary Java SE javax packages.
- Current org.primefaces.model.file.UploadedFile/listener is already correct; do not replay obsolete relocation.
- Update `WEB-INF/web.xml` to Jakarta EE web-app 6.0 and use `jakarta.faces.webapp.FacesServlet`.
- Update `WEB-INF/beans.xml` to Jakarta CDI 4 schema.
- Keep `WEB-INF/jboss-web.xml` context root as `/`.
- Update Facelets namespaces to Jakarta Faces:
  - `xmlns:h="jakarta.faces.html"`
  - `xmlns:f="jakarta.faces.core"`
  - `xmlns:ui="jakarta.faces.facelets"`
  - Keep `xmlns:p="http://primefaces.org/ui"`.
- Use Gradle8.4 on JDK11 with a Java21 compiler toolchain and release21; do not assume Gradle8.4 runtime supports JDK21.
- PF15 requires fileUpload dragDropSupport->dragDrop and moving same allowTypes/sizeLimit to p:validateFile. Native decoder is automatic; remove obsolete UPLOADER selector.
- Explicitly configure saga-blue; exact core Jakarta JAR bundles its CSS, so no additional themes artifact needed.
- Guard Docker/Compose with required EAP_IMAGE referencing an approved provisioned EAP8.1 Java21 server image. The named runtime-only image has no server; do not use it as a bare default or copy to old /opt/eap. Provisioning/deployment remain deferred by user.
- Keep deployment as `ROOT.war` and port `8080`.

Sub-gates: A Jakarta dependencies (PF14 Jakarta classifier bridge), B exact imports, C descriptors/Faces namespaces, D PF15Jakarta/used tag changes, E theme/resources, F final static/WAR validation. Attempt clean build after each; A namespace diagnostics must resolve in B, not be called a passing build. Save checkpoints after successful gates.

Validate with `./gradlew clean build`, independent `./gradlew test`, the repository validator, namespace/classifier/WAR inspection and deployment-guard checks. Missing EAP_IMAGE must reject Compose; synthetic explicit-image syntax checks are not a deployment. EAP8.1 runtime/visual/manual QA remain DEFERRED. Next MIG-09 requires separate authorization/environment.
