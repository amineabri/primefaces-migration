# Target Stack Notes

## JBoss EAP 8.1

Use Red Hat JBoss EAP 8.1 with the OpenJDK 21 runtime image:

```text
registry.redhat.io/jboss-eap-8/eap81-openjdk21-runtime-openshift-rhel9:latest
```

EAP 8.x is Jakarta EE based. Applications must migrate from Java EE `javax.*` APIs to Jakarta EE `jakarta.*` APIs.

## Jakarta EE 10

Use the provided API dependency:

```text
jakarta.platform:jakarta.jakartaee-api:10.0.0
```

Do not package Jakarta EE platform APIs in the WAR.

## PrimeFaces 15.0.16

Use PrimeFaces 15.0.16 with the Jakarta classifier:

```text
org.primefaces:primefaces:15.0.16:jakarta
```

For private/local artifact workflows, use:

```text
libs/primefaces-15.0.16-jakarta.jar
```

PrimeFaces package names mostly remain `org.primefaces.*`, but some model classes moved between PrimeFaces 6 and newer versions. In this app, check file upload imports first.
