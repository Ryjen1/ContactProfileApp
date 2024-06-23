# First stage: Build the application using Maven
FROM maven:3.8.6 AS build
WORKDIR /app

# Copy the pom.xml and source code
COPY pom.xml .
COPY src ./src

# Install OpenJDK 21
RUN apt-get update && apt-get install -y openjdk-21-jdk

# Set JAVA_HOME to JDK 21
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Verify Java installation
RUN java -version

# Package the application
RUN mvn clean package -DskipTests

# Second stage: Run the application using OpenJDK 21
FROM openjdk:21-jdk
WORKDIR /app

# Copy the packaged JAR from the first stage
COPY --from=build /app/target/ContactProfileApp-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

# Entry point to run the JAR
ENTRYPOINT ["java", "-jar", "app.jar"]
