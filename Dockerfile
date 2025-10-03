FROM eclipse-temurin:17-jdk AS builder
WORKDIR /app

# Copy Maven wrapper and pom.xml to leverage Docker layer caching
COPY ./mvnw ./
COPY ./.mvn ./.mvn/
COPY ./pom.xml ./

# Download dependencies
RUN ./mvnw dependency:go-offline -B

# Copy source code and build the application
COPY ./src ./src
RUN ./mvnw package -DskipTests

# Stage 2: Runtime image
FROM eclipse-temurin:17-jre

# Copy the application JAR from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Security: Run as non-root user
RUN groupadd -r petclinic && useradd -r -g petclinic petclinic
USER petclinic
# JVM tuning for containers
ENV JAVA_OPTS="-XX:+UseContainerSupport \
               -XX:MaxRAMPercentage=75.0 \
               -XX:+UseG1GC"               
ENTRYPOINT ["java", "-jar", "/app.jar"]
