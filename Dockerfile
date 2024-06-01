# First stage: Build stage
FROM schoolofdevops/maven:spring AS build

WORKDIR /app


# Copy the source code and build the application
COPY . .
RUN mvn package

# Second stage: Runtime stage
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy the built jar file from the build stage
COPY --from=build /app/target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.jar /run/petclinic.jar

EXPOSE 8080

CMD ["java", "-jar", "/run/petclinic.jar"]
