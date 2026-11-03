# Local Library JARs

The current dependency is public PrimeFaces 15.0.16 with the `jakarta` classifier, targeting Jakarta EE 10/Faces 4. The project compiles with a Java 21 toolchain. Use a local JAR override only if its version, Jakarta namespace and provenance have been verified.

Expected file name:

```text
primefaces-15.0.16-jakarta.jar
```

The Gradle build uses this local JAR first. If it is not present, Gradle resolves `org.primefaces:primefaces:15.0.16:jakarta` from Maven Central. Maven-local resolution is excluded for this module because partial local metadata can hide the Jakarta classifier; an unclassified/legacy JAR is never a fallback. The generated WAR must contain only the Jakarta build.

MIG-00 used an approved reconstructed public 6.2 baseline because the original private 6.2.30 artifact was unavailable. That reconstruction does not establish functional equivalence to 6.2.30. See `docs/modernization/migration/transformation-log.md` for the decision and deferred runtime validation.
