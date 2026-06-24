# Migration: PrimeFaces 8.0 To 10.0.0

Upgrade only PrimeFaces from 8.0 to 10.0.0.

PrimeFaces does not have a normal public 9.x major stage in this migration path; do not invent a PrimeFaces 9 stage.

Required changes:

- Update `gradle/libs.versions.toml` PrimeFaces version to `10.0.0`.
- Update local fallback naming to `libs/primefaces-10.0.0.jar`.
- Keep the default non-Jakarta PrimeFaces artifact.
- Keep `javax:javaee-api:8.0`.
- Keep JBoss EAP 7.3, Java 8, Docker image, descriptors, Facelets namespaces, and `javax.*`.
- Fix page/component incompatibilities caused by PrimeFaces 10 only.

Validate with `./gradlew clean build` and manual QA on `/` and `/elements.xhtml`.
