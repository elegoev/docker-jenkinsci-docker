FROM jenkins/jenkins
MAINTAINER Urs Voegele

User root
RUN apt-get update -y -qq \
    && apt-get install -qqy jq
# USER jenkins

# Skip initial setup.
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false" \
    # Customizable settings:
    # Default admin user.
    JENKINS_USER=admin \
    JENKINS_PASS=admin \
    # Default email.
    JENKINS_EMAIL=admin@localhost \
    # Default URL.
    # This is necessary because Jenkins cannot reliably detect such a URL from within itself.
    JENKINS_URL=http://localhost:8080/

# Custom JENKINS groovy scripts...
COPY ./data/jenkins/*.groovy /usr/share/jenkins/ref/init.groovy.d/

# Install standard plugins
COPY ./data/jenkins/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Change User 'root'
# User root

# Install Helm & JFrog Client
ENV HELM_VERSION="v2.14.3"
ENV HELM_FILENAME=helm-${HELM_VERSION}-linux-amd64.tar.gz
RUN curl -s -L https://storage.googleapis.com/kubernetes-helm/${HELM_FILENAME} | tar xz \
   && mv linux-amd64/helm /bin/helm \
   && rm -rf linux-amd64 \
   && helm init --client-only \
   && curl -s -fL https://getcli.jfrog.io | sh \
   && chmod +x jfrog \
   && mv jfrog /bin/jfrog

# Install Docker Client
COPY ./data/docker/Dockerfile /var/jenkins_home/docker-test/Dockerfile
ENV DOCKER_URL="https://download.docker.com/linux/static/stable/x86_64"
ENV DOCKER_VERSION="18.09.7"
VOLUME /certs
RUN curl -fsSL $DOCKER_URL/docker-$DOCKER_VERSION.tgz | \
         tar zxvf - --strip 1 -C /usr/bin docker/docker
