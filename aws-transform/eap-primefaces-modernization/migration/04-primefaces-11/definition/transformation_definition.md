# Migration: PrimeFaces 10.0.0 To 11.0.0

Upgrade only PrimeFaces from 10.0.0 to 11.0.0.

Required changes:

- Update `gradle/libs.versions.toml` PrimeFaces version to `11.0.0`.
- Update local fallback naming to `libs/primefaces-11.0.0.jar`.
- Keep the default non-Jakarta PrimeFaces artifact.
- Keep `javax:javaee-api:8.0`.
- Keep JBoss EAP 7.3, Java 8, Docker image, descriptors, Facelets namespaces, and `javax.*`.
- Fix page/component incompatibilities caused by PrimeFaces 11 only.

Validate with `./gradlew clean build` and manual QA on `/` and `/elements.xhtml`.
