# Base image
FROM maven:3.8.4-jdk-11-slim AS build

# Set working directory
WORKDIR /app

# Copy Maven project to working directory
COPY . .

# Build the Maven project
RUN mvn clean install -DskipTests

# Use Apache Tomcat 9 as the base image
FROM tomcat:9.0-jdk11

# Copy the WAR file from the Maven build to the Tomcat webapps directory
COPY --from=build /app/target/addressbook-2.0.war /usr/local/tomcat/webapps/

# Expose port 8080
EXPOSE 8080:8888

# Start Tomcat
CMD ["catalina.sh", "run"]
