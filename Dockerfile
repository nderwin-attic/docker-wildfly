FROM	nderwin/docker-jre:8u66

MAINTAINER	Nathan Erwin <nathan.d.erwin@gmail.com>

# install Wildfly
ENV	WILDFLY_VERSION 9.0.2.Final
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
EXPOSE	9990 9993 8009 8080 8443 3528 3529 4712 4713

# run as the wildfly user
USER	wildfly

# start Wildfly in standalone mode
CMD ["/opt/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

