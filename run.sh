#!/bin/bash
# run.sh

set -e

function _shutdown() {
    echo "Received TERM signal, shutting down now..."
    /opt/wildfly/bin/jboss-cli.sh -c ":shutdown(timeout=3)"
    wait $!
    exit 0
}

trap _shutdown SIGTERM

/opt/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 &
wait $!
