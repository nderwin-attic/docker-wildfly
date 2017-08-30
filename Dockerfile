FROM	nderwin/docker-server-jre:8u144

LABEL	Author="Nathan Erwin <nathan.d.erwin@gmail.com>"

# build arguments
ARG	ADMIN_USER
ARG	ADMIN_PASS

# install Wildfly
ENV	WILDFLY_VERSION 11.0.0.CR1
ENV	JBOSS_HOME /opt/wildfly

# Create a user so Wildfly does not run as root
# Create a management user in Wildfly
RUN	cd /opt \
	&& curl http://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz | tar zx \
	&& ln -s /opt/wildfly-$WILDFLY_VERSION /opt/wildfly \
	&& groupadd -r wildfly && useradd -r -g wildfly -d /opt/wildfly -s /sbin/nologin -c "WildFly user" wildfly \
	&& chown -R wildfly:wildfly /opt/wildfly* \
	&& /opt/wildfly/bin/add-user.sh $ADMIN_USER $ADMIN_PASS --silent \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# allow the Wildfly server ports to be seen
EXPOSE	4712 4713 8009 8080 8443 9990 9993

# run as the wildfly user
USER	wildfly

# Copy the execution wrapper script
COPY	run.sh /opt/wildfly

# start Wildfly in standalone mode
CMD ["/opt/wildfly/run.sh"]
