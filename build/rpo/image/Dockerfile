ARG  BASE_IMAGE=harbor-infra.rfosp.local/library/springboot:1-jdk17-2022.06.24-0


FROM ${BASE_IMAGE} as builder
COPY ["image-data/", "/"]

WORKDIR /home/java/app
# must exist exactly one *.jar
RUN java -Djarmode=layertools -jar $(ls *.jar) extract


FROM ${BASE_IMAGE}
# EXPOSE 8080

# healthcheck
# RUN apt update && apt install -y -o APT::Immediate-Configure=false curl && rm -rf /var/lib/apt/lists/*
# HEALTHCHECK --start-period=2m --interval=30s --timeout=15s --retries=3 CMD curl -f http://localhost:8080/actuator/health || exit 1


COPY ["image-data/home/java/bin/jar-launcher", "/home/java/bin/"]

# copy layers
WORKDIR /home/java/app
COPY --from=builder /home/java/app/dependencies/ ./
COPY --from=builder /home/java/app/spring-boot-loader/ ./
COPY --from=builder /home/java/app/snapshot-dependencies/ ./
COPY --from=builder /home/java/app/application/ ./

# ENTRYPOINT java -Djava.security.egd=file:/dev/./urandom org.springframework.boot.loader.JarLauncher
ENTRYPOINT ["/home/java/bin/jar-launcher"]
