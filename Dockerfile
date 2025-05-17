FROM gradle:8.2.1-jdk17 AS build
WORKDIR /app
COPY --chown=gradle:gradle . .
RUN gradle clean build -x test

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar

ENV PDFTOOLS_AUTH=true
ENV PDFTOOLS_USERNAME=admin
ENV PDFTOOLS_PASSWORD=yourStrongPass

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
