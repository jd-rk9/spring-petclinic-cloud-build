FROM eclipse-temurin:17-jdk AS builder
WORKDIR /app

# Copy dependencies first (cache optimization)
COPY ./pom.xml ./
# RUN ./mvnw dependency:go-offline -B
# Build application
COPY ./src ./src
RUN ./mvnw clean package -DskipTests
# Stage 2: Runtime image
FROM eclipse-temurin:17-jre
# Security: Run as non-root user
RUN groupadd -r petclinic && useradd -r -g petclinic petclinic
USER petclinic
# JVM tuning for containers
ENV JAVA_OPTS="-XX:+UseContainerSupport \
               -XX:MaxRAMPercentage=75.0 \
               -XX:+UseG1GC"
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
