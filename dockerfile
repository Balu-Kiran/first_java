# 1. Build Stage
FROM maven:3.9.6-eclipse-temurin-21 AS builder

WORKDIR /app

COPY pom.xml .
RUN mvn -B dependency:go-offline

COPY src ./src
RUN mvn -B clean package -DskipTests

# 2. Run Stage
FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=builder /app/target/*.war app.war

EXPOSE 8080
ENTRYPOINT ["java", "-war", "app.war"]

