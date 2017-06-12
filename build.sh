#!/bin/bash

read -p 'Admin username [dockerfly]: ' ADMIN_USER
if [ -z "$ADMIN_USER" ]; then
	ADMIN_USER="dockerfly";
fi

read -sp 'Admin password [dockerfly]: ' ADMIN_PASS
if [ -z "$ADMIN_PASS" ]; then
	ADMIN_PASS="dockerfly";
fi

echo

docker build --build-arg ADMIN_USER=$ADMIN_USER --build-arg ADMIN_PASS=$ADMIN_PASS --rm=true --tag="nderwin/docker-wildfly:latest" .
