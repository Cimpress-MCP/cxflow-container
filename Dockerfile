FROM alpine:3.12

ARG CX_FLOW_VERSION
ENV CX_FLOW_VERSION ${CX_FLOW_VERSION}

VOLUME /tmp

RUN apk add openjdk8-jre wget && apk update && apk upgrade
RUN mkdir /app

RUN echo "CxFlow version defined is $CX_FLOW_VERSION"
RUN wget --quiet "https://github.com/checkmarx-ltd/cx-flow/releases/download/$CX_FLOW_VERSION/cx-flow-$CX_FLOW_VERSION-java11.jar" -O /app/cx-flow.jar

ADD application.yml project.groovy comment.groovy /app/application.yml

ENTRYPOINT ["java"]
CMD ["-Xms512m", "-Xmx2048m","-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/cx-flow.jar", "--spring.config.location=/app/application.yml", "--web"]
EXPOSE 8080:8080
