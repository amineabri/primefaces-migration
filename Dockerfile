ARG EAP_BUILDER_IMAGE=registry.redhat.io/jboss-eap-8/eap81-openjdk21-builder-openshift-rhel9:latest
ARG EAP_RUNTIME_IMAGE=registry.redhat.io/jboss-eap-8/eap81-openjdk21-runtime-openshift-rhel9:latest
ARG EAP_PLATFORM=linux/amd64

FROM --platform=${EAP_PLATFORM} ${EAP_BUILDER_IMAGE} AS eap-builder

ENV GALLEON_PROVISION_FEATURE_PACKS=org.jboss.eap:wildfly-ee-galleon-pack,org.jboss.eap.cloud:eap-cloud-galleon-pack
ENV GALLEON_PROVISION_LAYERS=cloud-default-config
ENV GALLEON_PROVISION_CHANNELS=org.jboss.eap.channels:eap-8.1

RUN /usr/local/s2i/assemble

FROM --platform=${EAP_PLATFORM} ${EAP_RUNTIME_IMAGE}

COPY --from=eap-builder --chown=185:0 /opt/server /opt/server

USER root

COPY --chown=185:0 build/libs/primefaces-homeoffice.war /opt/server/standalone/deployments/ROOT.war

RUN touch /opt/server/standalone/deployments/ROOT.war.dodeploy \
    && chown 185:0 /opt/server/standalone/deployments/ROOT.war.dodeploy

USER 185

EXPOSE 8080
