FROM openjdk:8

LABEL maintainer=<"f.ziviello@email.it">

ARG JMETER_VERSION="5.4.3"
ARG JMETER_CMDRUNNER_VERSION="2.2"
ARG JMETER_PLUGINMANAGER_VERSION="1.6"
ARG JMETER_PRMCTL_VERSION="0.4"
ARG JMETER_HOME="/opt/apache-jmeter-${JMETER_VERSION}"
ARG JMETER_LIB="${JMETER_HOME}/lib"
ARG JMETER_PLUGINS="${JMETER_LIB}/ext"

RUN cd /opt \
 && wget https://mirrors.estointernet.in/apache/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz \
 && tar xzf apache-jmeter-${JMETER_VERSION}.tgz \
 && rm apache-jmeter-${JMETER_VERSION}.tgz

RUN wget https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-manager/${JMETER_PLUGINMANAGER_VERSION}/jmeter-plugins-manager-${JMETER_PLUGINMANAGER_VERSION}.jar \
  && mv ./jmeter-plugins-manager-${JMETER_PLUGINMANAGER_VERSION}.jar ${JMETER_PLUGINS} \
  && wget https://repo.maven.apache.org/maven2/kg/apc/jmeter-plugins-prmctl/${JMETER_PRMCTL_VERSION}/jmeter-plugins-prmctl-${JMETER_PRMCTL_VERSION}.jar \
  && mv jmeter-plugins-prmctl-${JMETER_PRMCTL_VERSION}.jar ${JMETER_PLUGINS} \
  && wget https://www.vinsguru.com/download/87/tag-jmeter-extn-1.1.zip \
  && unzip tag-jmeter-extn-1.1.zip -d ${JMETER_PLUGINS} \
  && rm tag-jmeter-extn-1.1.zip \
  && wget https://repo1.maven.org/maven2/kg/apc/cmdrunner/${JMETER_CMDRUNNER_VERSION}/cmdrunner-${JMETER_CMDRUNNER_VERSION}.jar \
  && mv ./cmdrunner-${JMETER_CMDRUNNER_VERSION}.jar ${JMETER_LIB} \
  && java -cp ${JMETER_PLUGINS}/jmeter-plugins-manager-${JMETER_PLUGINMANAGER_VERSION}.jar org.jmeterplugins.repository.PluginManagerCMDInstaller \
  && ${JMETER_HOME}/bin/PluginsManagerCMD.sh install bzm-random-csv 0.7

RUN ln -s ${JMETER_HOME}/bin/jmeter /usr/local/bin

WORKDIR /etc/spotify
