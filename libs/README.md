# Local Library JARs

Place the PrimeFaces Elite/PRO maintenance JAR here if it is not available from a dependency repository.

Expected file name:

```text
primefaces-7.0.jar
```

The Gradle build uses this local JAR first. If it is not present, Gradle resolves `org.primefaces:primefaces:7.0` from the configured repositories.
