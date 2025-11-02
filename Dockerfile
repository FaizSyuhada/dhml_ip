FROM maven:3.9-eclipse-temurin-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

FROM tomcat:9-jdk11
# Remove default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file to Tomcat webapps as ROOT.war (so it runs at /)
COPY --from=build /app/target/dhml.war /usr/local/tomcat/webapps/ROOT.war

# Environment variables will be passed from Dokploy
ENV DB_URL=${DB_URL}
ENV DB_USERNAME=${DB_USERNAME}
ENV DB_PASSWORD=${DB_PASSWORD}

EXPOSE 8080

CMD ["catalina.sh", "run"]

