# Stage 1: Build + extraction du WAR
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app

COPY source/pom.xml .
RUN mvn dependency:go-offline -B

COPY source/src/ src/
RUN mvn package -DskipTests -B

# Extraire le WAR ici où jar est disponible (JDK)
RUN mkdir -p /app/webapp && cd /app/webapp && jar xf /app/target/rewriting.war

# Stage 2: Run
FROM tomcat:10.1-jre17
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copier l'app déjà extraite → le volume uploads/ n'écrasera qu'un sous-dossier
COPY --from=build /app/webapp /usr/local/tomcat/webapps/ROOT

EXPOSE 8080
