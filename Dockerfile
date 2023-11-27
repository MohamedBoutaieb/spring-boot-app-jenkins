FROM openjdk:11
EXPOSE 8080
COPY  target/spring-boot-jenkins.jar spring-boot1-jenkins.jar
ENTRYPOINT ["java", "-jar", "spring-boot1-jenkins.jar"]