FROM eclipse-temurin:17-jre-jammy

# Runtime image that runs the prebuilt Spring Boot fat JAR.
WORKDIR /app

# Copy the application JAR produced by the CI build into the image
# The CI pipeline is expected to run `mvn package` before building this image
COPY target/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]