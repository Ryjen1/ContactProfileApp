# Use a Maven image with OpenJDK 17 for the build stage
FROM maven:3.8.5-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

# Use an Eclipse Temurin JDK 21 image for the runtime stage
FROM eclipse-temurin:21-jdk
COPY --from=build /target/demo-0.0.1-SNAPSHOT.jar demo.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "demo.jar"]
