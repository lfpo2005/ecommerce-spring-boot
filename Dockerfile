FROM maven:3.8.6-jdk-11
ARG JAR_FILE=/target/*.jar
COPY ${JAR_FILE} ecommerce-java.jar
ENTRYPOINT ["java","-jar","/ecommerce-java.jar"]