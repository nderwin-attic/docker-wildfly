#!/bin/sh

docker run -it -p 9990:9990 -p 8080:8080 --name="docker-wildfly" --hostname="docker-wildfly" --rm=true nderwin/docker-wildfly:10.1.0.Final.1

