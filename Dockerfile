
FROM eclipse-temurin:17-jdk

# Update image
RUN set -x && apt update -y && apt upgrade -y

ENV SONAR_SCANNER_VER=4.8.0.2856
ENV SONAR_SCANNER_OPTS="-Xmx512m -Dsonar.host.url=https://sonarqube.digital.homeoffice.gov.uk/"
ENV PATH=/opt/sonar-scanner-${SONAR_SCANNER_VER}/bin:${PATH}


ENV  LANG en_US.UTF-8
ENV  LANGUAGE en_US.UTF-8
ENV  LC_ALL en_US.UTF-8

# =======================================

 RUN apt install -y wget curl unzip git python3-pip

#for ansible plugins
RUN pip3 install ansible-lint

#Install sonar-scanner
RUN wget -O /tmp/sonar-scanner-cli-${SONAR_SCANNER_VER}.zip \
    https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VER}.zip && \
    unzip /tmp/sonar-scanner-cli-${SONAR_SCANNER_VER}.zip -d /opt/ && \
    rm -rf /tmp/sonar-scanner-cli-${SONAR_SCANNER_VER}.zip

ENTRYPOINT ["sonar-scanner"]
