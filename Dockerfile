# Stage 1: Build
FROM eclipse-temurin:17-jdk AS build
WORKDIR /app

COPY source/.mvn/ .mvn/
COPY source/mvnw source/pom.xml ./
RUN chmod +x mvnw && ./mvnw dependency:go-offline -B

COPY source/src/ src/
RUN ./mvnw package -DskipTests -B

# Stage 2: Run
FROM eclipse-temurin:17-jre
WORKDIR /app

COPY --from=build /app/target/*.war app.war

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.war"]
