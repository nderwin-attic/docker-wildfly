FROM	nderwin/docker-jre:8u45

MAINTAINER	Nathan Erwin <nathan.d.erwin@gmail.com>

RUN	apt-get install -y curl

# install Wildfly
ENV	WILDFLY_VERSION 8.2.0.Final
ENV	JBOSS_HOME /opt/wildfly

RUN	cd /opt && curl http://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz | tar zx
RUN	ln -s /opt/wildfly-$WILDFLY_VERSION /opt/wildfly

# Create a user so Wildfly does not run as root
RUN	groupadd -r wildfly && useradd -r -g wildfly -d /opt/wildfly -s /sbin/nologin -c "WildFly user" wildfly
RUN	chown -R wildfly:wildfly /opt/wildfly*

# Create a management user in Wildfly
RUN	/opt/wildfly/bin/add-user.sh dockerfly dockerfly --silent

# housekeeping
RUN	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# allow the Wildfly server ports to be seen
EXPOSE	8080 9990

# run as the wildfly user
USER	wildfly

# start Wildfly in standalone mode
CMD ["/opt/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
