# Multi-stage build: Build stage
FROM maven:3.8-openjdk-17 AS build

# Set working directory
WORKDIR /app

# Copy pom.xml and download dependencies (for better caching)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src

# Build the WAR file
RUN mvn clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:17-jre

# Set working directory
WORKDIR /app

# Copy the built WAR and webapp-runner from build stage
COPY --from=build /app/target/elms-1.0.war ./app.war
COPY --from=build /app/target/dependency/webapp-runner.jar ./webapp-runner.jar

# Expose port (Render will set PORT)
EXPOSE 8080

# Start the app using webapp-runner
CMD ["sh", "-c", "java -jar webapp-runner.jar --port $PORT app.war"]