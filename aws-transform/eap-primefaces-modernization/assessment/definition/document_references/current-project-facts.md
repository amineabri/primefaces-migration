# Current Project Facts

- Build: Gradle WAR project.
- Version catalog: `gradle/libs.versions.toml`.
- Current Java level: Java 8 source and target compatibility.
- Current Java EE dependency: `javax:javaee-api:8.0`, provided.
- Current PrimeFaces dependency: `org.primefaces:primefaces:6.2.30`.
- Current server image: `registry.redhat.io/jboss-eap-7/eap73-openjdk8-openshift-rhel7:7.3.10-2`.
- Current deployment path: root web application as `ROOT.war`.
- Current context root: `/`.
- Current pages:
  - `home.xhtml`
  - `dashboard.xhtml`
  - `employees.xhtml`
  - `reports.xhtml`
  - `elements.xhtml`
- The app intentionally has no authentication, authorization, database, JPA, REST APIs, messaging, monitoring, CI/CD, or Kubernetes.
