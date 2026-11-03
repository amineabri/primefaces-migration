# Migration: PrimeFaces 13.0.0 To 14.0.0

Upgrade only PrimeFaces from 13.0.0 to 14.0.0.

Required changes:

- Update `gradle/libs.versions.toml` PrimeFaces version to `14.0.0`.
- Update local fallback naming to `libs/primefaces-14.0.0.jar`.
- Keep the default non-Jakarta PrimeFaces artifact.
- Keep `javax:javaee-api:8.0`.
- PF14 requires Java 11 and JSF 2.3+. Set source/target/release to Java 11 and align Docker/Compose to the catalog-listed EAP 7.3.10 OpenJDK 11 image. No Java 21 or EAP version change.
- Keep descriptors, Facelets namespaces and `javax.*`. Stock EAP 7.3 supplies JSF 2.3, but actual module/slot configuration and deployment remain runtime gates.
- Fix page/component incompatibilities caused by PrimeFaces 14 only.

Validate with `./gradlew clean build` and manual QA on `/` and `/elements.xhtml`.
