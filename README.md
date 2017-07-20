## Docker Wildfly 

This image creates a basic instance of Wildfly with all of the default ports exposed.

## Building

`docker-compose build --build-arg ADMIN_USER=uzer --build-arg ADMIN_PASS=pazz wildfly` where `uzer` and `pazz` are the credentials for the Wildfly admin user

## Running

`docker-compose up` to create a container and start all services

`docker-compose down` will shut down the running container and remove it
