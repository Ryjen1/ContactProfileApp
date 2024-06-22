# Use a Maven image with OpenJDK 17 for the build stage
FROM maven:3.9.5-openjdk-21 AS build
COPY . .
RUN mvn clean package -DskipTests

# Use an Eclipse Temurin JDK 21 image for the runtime stage
FROM openjdk:21-jdk-slim
COPY --from=build /target/ContactProfileApp-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
