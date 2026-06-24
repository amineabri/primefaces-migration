# EAP And PrimeFaces Modernization Assessment

## Purpose

Assess the cost, time, and risk of modernizing this JSF/PrimeFaces WAR application before performing the migration.

This phase is assessment-only.

## Hard Rules

- Do not change application source files.
- Do not change Gradle files.
- Do not change Docker files.
- Do not change JSF, Facelets, Java, XML, or README files.
- The only allowed output is:

```text
aws-transform/eap-primefaces-modernization/reports/assessment.md
```

## Current Stack To Assess

- JBoss EAP 7.3.10.GA
- Java EE 8 / `javax.*`
- Java 8
- JSF on EAP 7.3
- PrimeFaces 6.2.30
- Gradle WAR
- Docker Compose
- Root web context `/`

## Target Stack For Estimate

- JBoss EAP 8.1
- OpenJDK 21
- Jakarta EE 10 / `jakarta.*`
- PrimeFaces 15.0.16 with Jakarta classifier
- Gradle WAR
- Docker Compose
- Root web context `/`

## Assessment Steps

1. Build the current application with `./gradlew clean build`.
2. Inventory affected files:
   - `build.gradle`
   - `gradle/libs.versions.toml`
   - Java source under `src/main/java`
   - JSF pages under `src/main/webapp`
   - `WEB-INF/web.xml`
   - `WEB-INF/beans.xml`
   - `WEB-INF/jboss-web.xml`
   - `Dockerfile`
   - `docker-compose.yml`
   - `README.md`
3. Count Java files using Java EE imports.
4. Count Facelets files using Java EE namespace URIs.
5. Count PrimeFaces components on `elements.xhtml` and note likely PrimeFaces 15 compatibility checks.
6. Identify Docker image and platform changes.
7. Produce the assessment report.

## Required Report Format

Create `aws-transform/eap-primefaces-modernization/reports/assessment.md` with these sections:

```markdown
# EAP And PrimeFaces Modernization Assessment

## Executive Summary
Short summary of expected effort and risk.

## Current Inventory
Build, runtime, dependencies, page count, Java source count, descriptor count.

## Migration Work Breakdown
Grouped by build/dependencies, Java namespaces, descriptors, Facelets, PrimeFaces, Docker, and documentation.

## Estimate
Table with low / expected / high:
- AWS Transform agent minutes
- human engineering review time
- manual QA time
- calendar duration

## Cost
Formula using current AWS Transform agent-minute price.
Do not invent a price if current pricing is not available during execution.

## Risks And Blockers
Main compatibility risks.

## Migration Phase Inputs
Concrete instructions and assumptions to pass to Phase 2.

## Go / No-Go
Recommendation and prerequisites.
```

## Estimation Guidance

Use the repository size and complexity to estimate:

- Build/dependency modernization: low complexity.
- Java namespace migration: low to medium complexity depending on compile errors.
- Descriptor/schema migration: medium complexity due to Jakarta EE 10 changes.
- Facelets migration: medium complexity due to namespace and PrimeFaces component compatibility.
- PrimeFaces 6 to 15 component verification: medium to high risk, especially the Elements page.
- Docker EAP 8.1 image update: low to medium complexity due to Red Hat registry access and platform availability.

Prefer ranges over single-point estimates.
