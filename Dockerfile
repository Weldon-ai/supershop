# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven build files first to leverage caching
COPY pom.xml mvnw ./
COPY .mvn .mvn

# Copy the source code
COPY src src

# Package the application (inside Docker)
RUN ./mvnw clean package -DskipTests

# Copy the built jar to the working directory
RUN cp target/*.jar app.jar

# Expose the port your Spring Boot app runs on
EXPOSE 8080

# Command to run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]
