# wildfly-maven
Alpine linux-5.4 with Wildfly-10, Maven-3.3.9 and JDK-8.
To setup a dev environment with this image, use docker-compose to put together different parts of the environment.
An example `docker-compose.yml` could be
```yml
version: '2'
services: 
  api:
    image: rppavan/wildfly-maven
    ports:
      - "8080:8080"
      - "9990:9990"
    volumes:
      - $GIT_HOME:/src/git/
      - ~/.m2:/root/.m2
    command: $JBOSS_HOME/bin/standalone.sh -b=0.0.0.0
# Can start a build, deploy and run script here instead.
    links:
      - redis
    dns:
    - 8.8.8.8
    - 8.8.4.4

  redis:
    image: redis:alpine
    ports:
      - "6379:6379"
```

