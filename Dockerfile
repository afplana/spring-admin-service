FROM openjdk:14-jdk-alpine as BUILD

LABEL key="riot90"

ARG WORKDIR="/app"
WORKDIR ${WORKDIR}
COPY ./ ${WORKDIR}/

RUN ./mvnw clean package

FROM openjdk:14-jdk-alpine

ARG WORKDIR="/app"
WORKDIR ${WORKDIR}
COPY --from=BUILD ${WORKDIR}/target/*.jar ${WORKDIR}/app.jar
EXPOSE 8092

ENTRYPOINT ["java", "-Xmx256M", "-jar", "app.jar"]