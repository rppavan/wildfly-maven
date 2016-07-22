FROM java:8-alpine

MAINTAINER Pavan Parwatikar <rppavan@gmail.com>

RUN apk update && apk upgrade && apk add curl bash && rm /var/cache/apk/*

ENV MAVEN_VERSION 3.3.9
ENV MAVEN_HOME /usr/lib/mvn

RUN cd /tmp && \
  curl -O "http://mirror.fibergrid.in/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" && \
  tar -zxf "apache-maven-$MAVEN_VERSION-bin.tar.gz" && \
  mv "apache-maven-$MAVEN_VERSION" "$MAVEN_HOME" && \
  ln -s "$MAVEN_HOME/bin/mvn" /usr/bin/mvn && \
  rm /tmp/*
  
VOLUME /root/.m2

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 10.0.0.Final
ENV JBOSS_HOME /opt/jboss/wildfly
# Gracefully shutdown Wildfly
ENV LAUNCH_JBOSS_IN_BACKGROUND 1

# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
RUN cd $HOME \
    && curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && tar -zxf wildfly-$WILDFLY_VERSION.tar.gz \
    && mkdir -p /opt/jboss \
    && mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME \
    && rm wildfly-$WILDFLY_VERSION.tar.gz

# Expose the ports we're interested in
EXPOSE 8080 9990 8009

# Set the default command to run on boot
ENTRYPOINT ["/bin/bash"]
