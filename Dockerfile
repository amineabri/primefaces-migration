ARG EAP_IMAGE=registry.redhat.io/jboss-eap-7/eap73-openjdk8-openshift-rhel7:7.3.10-2
ARG EAP_PLATFORM=linux/amd64

FROM --platform=${EAP_PLATFORM} ${EAP_IMAGE}

USER root

COPY --chown=185:0 build/libs/primefaces-homeoffice.war /opt/eap/standalone/deployments/ROOT.war

RUN touch /opt/eap/standalone/deployments/ROOT.war.dodeploy \
    && chown 185:0 /opt/eap/standalone/deployments/ROOT.war.dodeploy

USER 185

EXPOSE 8080
