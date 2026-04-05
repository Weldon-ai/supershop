# Stage 1: Build the app using Maven
FROM eclipse-temurin:17-jdk-jammy AS builder

# Set working directory
WORKDIR /app

# Copy Maven wrapper and pom.xml first (for caching dependencies)
COPY pom.xml mvnw ./
COPY .mvn .mvn

# Copy source code
COPY src src

# Build the application, skip tests for faster build
RUN ./mvnw clean package -DskipTests

# Stage 2: Create a lightweight runtime image
FROM eclipse-temurin:17-jdk-jammy

# Set working directory
WORKDIR /app

# Copy the jar from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the default Spring Boot port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]