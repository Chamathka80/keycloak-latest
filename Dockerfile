FROM jboss/keycloak:latest

ENV KEYCLOAK_VERSION 21.0.1
ENV JDBC_POSTGRES_VERSION 42.2.5i
ENV LAUNCH_JBOSS_IN_BACKGROUND 1
ENV PROXY_ADDRESS_FORWARDING false
ENV JBOSS_HOME /opt/jboss/keycloak
ENV LANG en_US.UTF-8

ARG KEYCLOAK_DIST=https://github.com/keycloak/keycloak/releases/download/21.0.1/keycloak-21.0.1.tar.gz
USER root
RUN KEYCLOAK_DIST=https://github.com/keycloak/keycloak/releases/download/21.0.1/keycloak-21.0.1.tar.gz /bin/sh -c microdnf update -y && microdnf install -y glibc-langpack-en gzip hostname java-11-openjdk-headless openssl tar which && microdnf clean all
RUN ls /opt/jboss/tools
RUN KEYCLOAK_DIST=https://github.com/keycloak/keycloak/releases/download/21.0.1/keycloak-21.0.1.tar.gz /bin/sh -c /opt/jboss/tools/build-keycloak.sh
USER 1000
EXPOSE 8080
EXPOSE 8443
ENTRYPOINT [ "/opt/jboss/tools/docker-entrypoint.sh" ]
CMD ["-b", "0.0.0.0"]
