# Stage 1: Build
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app

COPY source/pom.xml .
RUN mvn dependency:go-offline -B

COPY source/src/ src/
RUN mvn package -DskipTests -B

# Stage 2: Run
FROM tomcat:10.1-jre17
RUN rm -rf /usr/local/tomcat/webapps/ROOT

COPY --from=build /app/target/rewriting.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
