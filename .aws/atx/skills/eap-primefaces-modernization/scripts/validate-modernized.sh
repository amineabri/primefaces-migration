#!/usr/bin/env bash
set -euo pipefail

fail() {
  echo "ERROR: $1" >&2
  exit 1
}

grep -R "javax\\." src/main/java >/dev/null 2>&1 && fail "javax.* imports remain in Java source"

grep -R "eap73-openjdk8" Dockerfile docker-compose.yml >/dev/null 2>&1 && fail "EAP 7.3 image remains in Docker files"
grep -R "jboss-eap-7" Dockerfile docker-compose.yml >/dev/null 2>&1 && fail "JBoss EAP 7 image repository remains in Docker files"

grep -R "eap81-openjdk21-runtime-openshift-rhel9" Dockerfile docker-compose.yml >/dev/null 2>&1 || fail "EAP 8.1 OpenJDK 21 image not found"
grep -R "jakarta.jakartaee-api" gradle build.gradle settings.gradle >/dev/null 2>&1 || fail "Jakarta EE API dependency not found"
grep -R "15.0.16" gradle build.gradle README.md libs >/dev/null 2>&1 || fail "PrimeFaces 15.0.16 not found"

grep -R "6.2.30" build.gradle gradle README.md Dockerfile docker-compose.yml >/dev/null 2>&1 && fail "PrimeFaces 6.2.30 still referenced in build/docs/config"

grep -R "<context-root>/</context-root>" src/main/webapp/WEB-INF/jboss-web.xml >/dev/null 2>&1 || fail "Root context was not preserved"

echo "Modernization validation checks passed."
