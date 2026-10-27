FROM jenkins/jenkins:lts-jdk17

USER root

# Trust corporate proxy CA so Jenkins (JVM + apt + curl) can reach the internet
COPY corporate-ca-bundle.crt /usr/local/share/ca-certificates/corporate-ca-bundle.crt
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl unzip python3 python3-pip \
    && update-ca-certificates \
    && keytool -importcert -noprompt -trustcacerts \
        -alias corporate-ca \
        -file /usr/local/share/ca-certificates/corporate-ca-bundle.crt \
        -keystore "$JAVA_HOME/lib/security/cacerts" \
        -storepass changeit \
    && rm -rf /var/lib/apt/lists/*

# Docker CLI static binary (single download, more reliable than apt behind corporate proxy)
RUN curl -fsSL --retry 5 --retry-all-errors "https://download.docker.com/linux/static/stable/x86_64/docker-27.3.1.tgz" -o /tmp/docker.tgz \
    && tar -xzf /tmp/docker.tgz -C /tmp \
    && mv /tmp/docker/docker /usr/local/bin/docker \
    && rm -rf /tmp/docker.tgz /tmp/docker

# AWS CLI v2
RUN curl -fsSL --retry 5 --retry-all-errors "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip \
    && cd /tmp && unzip -q awscliv2.zip && ./aws/install \
    && rm -rf /tmp/awscliv2.zip /tmp/aws

# kubectl static binary
RUN curl -fsSL --retry 5 --retry-all-errors "https://dl.k8s.io/release/v1.31.0/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

# docker.sock (mounted from the host) is owned by root:root on Docker Desktop for Windows,
# so add jenkins to the root group to allow docker CLI access without running as root
RUN usermod -aG root jenkins

USER jenkins

ENV JAVA_OPTS="-Djavax.net.ssl.trustStore=/opt/java/openjdk/lib/security/cacerts -Djavax.net.ssl.trustStorePassword=changeit"
ENV PIP_CERT=/etc/ssl/certs/ca-certificates.crt
ENV PIP_BREAK_SYSTEM_PACKAGES=1
