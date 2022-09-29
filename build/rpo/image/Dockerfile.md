# Layered Dockerfile

The two new features introduced in Spring Boot 2.3 to help improve image
creation techniques were: layered jars and buildpack support.


By default, the following layers are defined:

    dependencies for any dependency whose version does not contain SNAPSHOT.
    spring-boot-loader for the jar loader classes.
    snapshot-dependencies for any dependency whose version contains SNAPSHOT.
    application for application classes and resources.

The layers order is important as it determines how likely previous layers are
to be cached when part of the application changes. The default order is
dependencies, spring-boot-loader, snapshot-dependencies, application.


## Test

docker run --rm -e JAVA_OPTS='-Dserver.servlet.context-path=/set-by-opts' swagger:latest
docker run --rm -e JAVA_ARGS ='--server.servlet.context-path=/set-by-args' swagger:latest

## Layers

RUN apt update
RUN apt install -y tree
RUN tree -L 4 dependencies
RUN tree -L 4 spring-boot-loader
RUN tree -L 4 snapshot-dependencies
RUN tree -L 4 application


RUN tree -L 4 dependencies
dependencies
└── BOOT-INF
    └── lib
        ├── accessors-smart-2.4.7.jar
        ├── android-json-0.0.20131108.vaadin1.jar
        ├── apiguardian-api-1.1.0.jar
        ├── asm-9.1.jar
        ├── assertj-core-3.19.0.jar
        ├── byte-buddy-1.10.22.jar
        ├── byte-buddy-agent-1.10.22.jar
        ├── hamcrest-2.2.jar
        ├── HdrHistogram-2.1.12.jar
        ├── jackson-annotations-2.12.6.jar
        ├── jackson-core-2.12.6.jar
        ├── jackson-databind-2.12.6.jar
        ├── jackson-datatype-jdk8-2.12.6.jar
        ├── jackson-datatype-jsr310-2.12.6.jar
        ├── jackson-module-parameter-names-2.12.6.jar
        ├── jakarta.activation-api-1.2.2.jar
        ├── jakarta.annotation-api-1.3.5.jar
        ├── jakarta.xml.bind-api-2.3.3.jar
        ├── jsonassert-1.5.0.jar
        ├── json-path-2.5.0.jar
        ├── json-smart-2.4.7.jar
        ├── jul-to-slf4j-1.7.33.jar
        ├── junit-jupiter-5.7.2.jar
        ├── junit-jupiter-api-5.7.2.jar
        ├── junit-jupiter-engine-5.7.2.jar
        ├── junit-jupiter-params-5.7.2.jar
        ├── junit-platform-commons-1.7.2.jar
        ├── junit-platform-engine-1.7.2.jar
        ├── LatencyUtils-2.0.3.jar
        ├── log4j-api-2.17.1.jar
        ├── log4j-to-slf4j-2.17.1.jar
        ├── logback-classic-1.2.10.jar
        ├── logback-core-1.2.10.jar
        ├── logstash-logback-encoder-7.0.1.jar
        ├── micrometer-core-1.7.8.jar
        ├── mockito-core-3.9.0.jar
        ├── mockito-junit-jupiter-3.9.0.jar
        ├── objenesis-3.2.jar
        ├── opentest4j-1.2.0.jar
        ├── slf4j-api-1.7.33.jar
        ├── snakeyaml-1.28.jar
        ├── spring-aop-5.3.15.jar
        ├── spring-beans-5.3.15.jar
        ├── spring-boot-2.5.9.jar
        ├── spring-boot-actuator-2.5.9.jar
        ├── spring-boot-actuator-autoconfigure-2.5.9.jar
        ├── spring-boot-autoconfigure-2.5.9.jar
        ├── spring-boot-jarmode-layertools-2.5.9.jar
        ├── spring-boot-test-2.5.9.jar
        ├── spring-boot-test-autoconfigure-2.5.9.jar
        ├── spring-context-5.3.15.jar
        ├── spring-core-5.3.15.jar
        ├── spring-expression-5.3.15.jar
        ├── spring-jcl-5.3.15.jar
        ├── spring-test-5.3.15.jar
        ├── spring-web-5.3.15.jar
        ├── spring-webmvc-5.3.15.jar
        ├── swagger-ui-4.6.2.jar
        ├── tomcat-embed-core-9.0.56.jar
        ├── tomcat-embed-el-9.0.56.jar
        ├── tomcat-embed-websocket-9.0.56.jar
        └── xmlunit-core-2.8.4.jar
2 directories, 62 files


RUN tree -L 4 spring-boot-loader
spring-boot-loader
└── org
    └── springframework
        └── boot
            └── loader
4 directories, 0 files


RUN tree -L 4 snapshot-dependencies
snapshot-dependencies
0 directories, 0 files


RUN tree -L 4 application
application
├── BOOT-INF
│   ├── classes
│   │   ├── apidocs
│   │   │   ├── apidocs.json
│   │   │   ├── bpm
│   │   │   ├── core
│   │   │   ├── dms
│   │   │   ├── esb
│   │   │   └── schema.json
│   │   ├── application.properties
│   │   ├── com
│   │   │   └── gratex
│   │   └── logback.xml
│   ├── classpath.idx
│   └── layers.idx
└── META-INF
    ├── MANIFEST.MF
    └── maven
        └── com.gratex.rfosp
            └── swagger
13 directories, 7 files
