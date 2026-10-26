# syntax=docker/dockerfile:1

# Builds the SmartData WAR. The Smart* helper jars live in the project local
# Maven repository under libs/maven-repo, so no sibling checkouts are needed.
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /workspace
COPY pom.xml ./
COPY libs ./libs
COPY src ./src
COPY web ./web
RUN mvn -B -ntp clean package

# Small artifact image containing the deployable WAR. The master Payara image
# (SmartDataDeployment/Dockerfile.payara) copies /opt/wars/SmartData.war from
# here.
FROM alpine:3.20 AS artifact
COPY --from=build /workspace/target/SmartData.war /opt/wars/SmartData.war
