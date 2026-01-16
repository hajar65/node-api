# Étape 1 : Build de l'application avec Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
# Copier le fichier de configuration et les sources
COPY pom.xml .
COPY src ./src
# Compiler et créer le fichier .jar
RUN mvn clean package -DskipTests

# Étape 2 : Exécution de l'application
FROM eclipse-temurin:17-jre
WORKDIR /app
# Copier uniquement le fichier jar généré à l'étape précédente
COPY --from=build /app/target/*.jar app.jar
# Exposer le port par défaut de Spring Boot
EXPOSE 8080
# Lancer l'application
ENTRYPOINT ["java", "-jar", "app.jar"]
