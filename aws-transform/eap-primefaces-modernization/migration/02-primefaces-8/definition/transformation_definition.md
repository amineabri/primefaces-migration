# Migration: PrimeFaces 7.0 To 8.0

Upgrade only PrimeFaces from 7.0 to 8.0.

Required changes:

- Update `gradle/libs.versions.toml` PrimeFaces version to `8.0`.
- Update local fallback naming to `libs/primefaces-8.0.jar`.
- Keep `javax:javaee-api:8.0`.
- Keep JBoss EAP 7.3, Java 8, Docker image, descriptors, Facelets namespaces, and `javax.*`.
- Fix page/component incompatibilities caused by PrimeFaces 8 only.

Validate with `./gradlew clean build` and manual QA on `/` and `/elements.xhtml`.
