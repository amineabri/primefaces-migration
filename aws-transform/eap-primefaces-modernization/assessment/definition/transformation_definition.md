# EAP And PrimeFaces Modernization Assessment

## Purpose

Assess the cost, time, and risk of modernizing this JSF/PrimeFaces WAR application before performing the migration.

This phase is assessment-only and must break the estimate down by migration stage.

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

## Staged Target Path

Estimate these stages separately:

1. PrimeFaces 6.2.30 to PrimeFaces 8.0 on the current Java EE / EAP 7.3 stack.
2. PrimeFaces 8.0 to PrimeFaces 11.0.0 on the current Java EE / EAP 7.3 stack.
3. PrimeFaces 11.0.0 to PrimeFaces 15.0.16 Jakarta, plus JBoss EAP 8.1 / Jakarta EE 10 / Java 21 cutover.

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
5. Count PrimeFaces components on `elements.xhtml` and note likely compatibility checks for each stage.
6. Identify Docker image and platform changes for stage 3 only.
7. Produce the assessment report with a stage-by-stage cost/time/effort breakdown.

## Required Report Format

Create `aws-transform/eap-primefaces-modernization/reports/assessment.md` with these sections:

```markdown
# EAP And PrimeFaces Modernization Assessment

## Executive Summary
Short summary of expected effort and risk.

## Current Inventory
Build, runtime, dependencies, page count, Java source count, descriptor count.

## Stage Breakdown
One subsection per stage:
- PrimeFaces 6.2.30 to 8.0
- PrimeFaces 8.0 to 11.0.0
- EAP 8.1 and PrimeFaces 15.0.16 Jakarta

## Estimate
Table with low / expected / high:
- AWS Transform agent minutes per stage
- AWS Transform cost per stage
- human engineering review time
- manual QA time
- calendar duration

## Cost
Concrete low / expected / high estimated AWS Transform migration cost in USD for each stage and for the full staged sequence.
Use this formula: stage migration cost = estimated stage agent minutes * current AWS Transform custom transformation agent-minute price.
Use USD 0.035 per agent minute if current pricing cannot be fetched during execution, and clearly state the pricing date.
Mention that local builds, local file reads, and user idle time are not charged as agent minutes.

## Risks And Blockers
Main compatibility risks.

## Migration Phase Inputs
Concrete instructions and assumptions to pass to each matching migration stage.

## Go / No-Go
Recommendation and prerequisites.
```

## Estimation Guidance

Use the repository size and complexity to estimate:

- PrimeFaces 6.2.30 to 8.0: UI library compatibility only; low to medium complexity.
- PrimeFaces 8.0 to 11.0.0: UI library compatibility only; medium complexity.
- PrimeFaces 11.0.0 to 15.0.16 Jakarta plus EAP 8.1: higher complexity because it combines PrimeFaces, Jakarta namespace, descriptor, Java 21, and Docker updates.

Prefer ranges over single-point estimates.

## Pricing Guidance

AWS Transform custom transformation pricing is per agent minute. As of 2026-06-24, the published price is:

```text
USD 0.035 per agent minute
```

The assessment must include a table like:

```markdown
| Stage | Scenario | Estimated agent minutes | Estimated AWS Transform cost |
| --- | ---: | ---: |
| PrimeFaces 6.2.30 to 8.0 | Expected | 45 | $1.58 |
| PrimeFaces 8.0 to 11.0.0 | Expected | 60 | $2.10 |
| EAP 8.1 and PrimeFaces 15 Jakarta | Expected | 120 | $4.20 |
```

Use estimates appropriate to this repository rather than copying the sample numbers blindly.
