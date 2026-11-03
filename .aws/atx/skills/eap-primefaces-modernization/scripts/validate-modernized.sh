#!/usr/bin/env bash
set -euo pipefail

fail() {
  echo "ERROR: $1" >&2
  exit 1
}

grep -R "javax\\." src/main/java >/dev/null 2>&1 && fail "Unexpected javax.* source reference; classify Java SE uses explicitly before allowing one"

grep -R "eap73-openjdk8" Dockerfile docker-compose.yml >/dev/null 2>&1 && fail "EAP 7.3 image remains in Docker files"
grep -R "jboss-eap-7" Dockerfile docker-compose.yml >/dev/null 2>&1 && fail "JBoss EAP 7 image repository remains in Docker files"

grep -F '${EAP_IMAGE:?' docker-compose.yml >/dev/null || fail "Provisioned EAP 8.1 Java 21 image guard missing"
grep -F 'test -x /opt/server/bin/standalone.sh' Dockerfile >/dev/null || fail "Provisioned-server build guard missing"
grep -R "jakarta.jakartaee-api" gradle build.gradle settings.gradle >/dev/null 2>&1 || fail "Jakarta EE API dependency not found"
grep -R "15.0.16" gradle build.gradle README.md libs >/dev/null 2>&1 || fail "PrimeFaces 15.0.16 not found"

grep -R "6.2.30" build.gradle gradle Dockerfile docker-compose.yml >/dev/null 2>&1 && fail "PrimeFaces 6.2.30 still configured"

grep -R "<context-root>/</context-root>" src/main/webapp/WEB-INF/jboss-web.xml >/dev/null 2>&1 || fail "Root context was not preserved"

python3 - <<'PY'
import io
from pathlib import Path
import re
import struct
import xml.etree.ElementTree as ET
import zipfile

def require(condition, message):
    if not condition:
        raise SystemExit("ERROR: " + message)

war_path = Path("build/libs/primefaces-homeoffice.war")
require(war_path.is_file(), "Build the Jakarta WAR before validation")
with zipfile.ZipFile(war_path) as war:
    require(war.testzip() is None, "Invalid WAR ZIP")
    libraries = [n for n in war.namelist() if n.startswith("WEB-INF/lib/") and n.endswith(".jar")]
    require(libraries == ["WEB-INF/lib/primefaces-15.0.16-jakarta.jar"],
            "Expected sole PF15 Jakarta dependency, without bundled platform APIs")
    classes = [n for n in war.namelist() if n.endswith(".class")]
    require(len(classes) == 11, "Expected 11 application classes")
    for name in classes:
        data = war.read(name)
        require(struct.unpack(">H", data[6:8])[0] == 65, "Expected Java21 class: " + name)
        require(not re.search(rb"javax[/.]", data), "Legacy application namespace: " + name)
    for name, version in [("web.xml", "6.0"), ("beans.xml", "4.0")]:
        root = ET.fromstring(war.read("WEB-INF/" + name))
        require(root.tag.startswith("{https://jakarta.ee/xml/ns/jakartaee}"), "Descriptor namespace: " + name)
        require(root.get("version") == version, "Descriptor version: " + name)
    web = ET.fromstring(war.read("WEB-INF/web.xml"))
    ns = {"j": "https://jakarta.ee/xml/ns/jakartaee"}
    params = {p.findtext("j:param-name", namespaces=ns): p.findtext("j:param-value", namespaces=ns)
              for p in web.findall("j:context-param", ns)}
    require(params.get("primefaces.THEME") == "saga-blue", "Explicit Saga Blue configuration required")
    require("primefaces.UPLOADER" not in params, "Obsolete uploader selector remains")
    require(web.findtext("j:servlet/j:servlet-class", namespaces=ns) == "jakarta.faces.webapp.FacesServlet",
            "Jakarta Faces servlet required")
    with zipfile.ZipFile(io.BytesIO(war.read(libraries[0]))) as pf:
        require(b"jakarta/faces/" in pf.read("org/primefaces/event/FileUploadEvent.class"),
                "PF artifact is not Jakarta")
        require("META-INF/resources/primefaces-saga-blue/theme.css" in pf.namelist(), "Saga Blue resource missing")
        taglib = ET.fromstring(pf.read("META-INF/primefaces.taglib.xml"))
        tag_ns = {"f": taglib.tag.split("}")[0][1:]}
        tags = {t.findtext("f:tag-name", namespaces=tag_ns):
                {a.findtext("f:name", namespaces=tag_ns) for a in t.findall("f:attribute", tag_ns)}
                for t in taglib.findall("f:tag", tag_ns)}
        for path in Path("src/main/webapp").rglob("*.xhtml"):
            require(war.read(str(path.relative_to("src/main/webapp"))) == path.read_bytes(),
                    "Stale packaged resource: " + str(path))
            for element in ET.parse(path).getroot().iter():
                if element.tag.startswith("{http://primefaces.org/ui}"):
                    tag = element.tag.split("}")[1]
                    require(tag in tags, "Unsupported tag: " + tag)
                    for attribute in element.attrib:
                        require(attribute in tags[tag], "Unsupported attribute: " + tag + "." + attribute)
        # Upstream transformer leaves these serialized-lambda signature strings, not type links.
        known_literals = {
            "org/primefaces/component/autoupdate/AutoUpdateTagHandler.class":
                {b"javax/faces/application/ProjectStage"},
            "org/primefaces/model/JPALazyDataModel$Builder.class":
                {b"javax/persistence/EntityManagerFactory"},
            "org/primefaces/context/PrimeApplicationContext.class":
                {b"javax/validation/Validator", b"javax/validation/ValidatorFactory"},
        }
        java_se = (b"javax/imageio/", b"javax/xml/namespace/", b"javax/xml/parsers/", b"javax/xml/xpath/")
        for name in (n for n in pf.namelist() if n.endswith(".class")):
            for reference in set(re.findall(rb"javax/[A-Za-z0-9_/$]+", pf.read(name))):
                require(reference.startswith(java_se) or reference in known_literals.get(name, set()),
                        "Unclassified dependency residue: " + name + " " + reference.decode())
        print("Residual javax: application 0; dependency Java SE references, embedded build metadata,")
        print("and four known upstream serialized-lambda literals classified. Deserialization risk remains deferred.")
print("Jakarta build/static/WAR checks passed. EAP 8.1 runtime and visual validation DEFERRED.")
PY
