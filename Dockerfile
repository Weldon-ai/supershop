# Use a reliable OpenJDK 17 image
FROM eclipse-temurin:17-jdk-jammy
# Set the working directory inside the container
WORKDIR /app

# Copy Maven wrapper and pom.xml first (for caching)
COPY pom.xml mvnw ./
COPY .mvn .mvn

# Copy the source code
COPY src src

# Build the application (skip tests for faster build)
RUN ./mvnw clean package -DskipTests

# Copy the jar file
RUN cp target/*.jar app.jar

# Expose the port
EXPOSE 8080

# Run the Spring Boot app
ENTRYPOINT ["java", "-jar", "app.jar"]