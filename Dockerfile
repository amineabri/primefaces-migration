ARG EAP_PLATFORM=linux/amd64

FROM --platform=${EAP_PLATFORM} registry.redhat.io/jboss-eap-8/eap81-openjdk21-builder-openshift-rhel9@sha256:40f2d11ef2b181330eadb04fc1b89925b91921612f39f72fee475c55a53e06d6 AS builder

ENV GALLEON_PROVISION_FEATURE_PACKS=org.jboss.eap:wildfly-ee-galleon-pack,org.jboss.eap.cloud:eap-cloud-galleon-pack \
    GALLEON_PROVISION_LAYERS=jsf,bean-validation,management,core-tools,deployment-scanner,logging,health,request-controller \
    GALLEON_PROVISION_CHANNELS=org.jboss.eap.channels:eap-8.1:1.8.0.GA-redhat-00006

RUN /usr/local/s2i/assemble

COPY --chown=185:0 operations/eap/configure.cli /tmp/ops-configure.cli
RUN /opt/server/bin/jboss-cli.sh --file=/tmp/ops-configure.cli

FROM --platform=${EAP_PLATFORM} registry.redhat.io/jboss-eap-8/eap81-openjdk21-runtime-openshift-rhel9@sha256:6a3590ad17625af2bffd64d4cd6828da15c56102fcc57fa5c7be9bd4dc662845

COPY --from=builder --chown=185:0 /opt/server /opt/server

ENV CONFIG_IS_FINAL=true \
    WILDFLY_PUBLIC_BIND_ADDRESS=0.0.0.0 \
    WILDFLY_MANAGEMENT_BIND_ADDRESS=127.0.0.1

USER root

RUN test -x /opt/server/bin/standalone.sh \
    && test -d /opt/server/standalone/deployments

COPY --chown=185:0 build/libs/primefaces-homeoffice.war /opt/server/standalone/deployments/ROOT.war
COPY --chown=185:0 operations/eap/healthcheck.sh /opt/server/bin/ops-healthcheck.sh

RUN touch /opt/server/standalone/deployments/ROOT.war.dodeploy \
    && chown 185:0 /opt/server/standalone/deployments/ROOT.war.dodeploy \
    && chmod 0555 /opt/server/bin/ops-healthcheck.sh

USER 185

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=25s --start-period=120s --retries=3 \
    CMD ["/opt/server/bin/ops-healthcheck.sh", "readiness"]
