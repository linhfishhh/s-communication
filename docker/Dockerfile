FROM 323985919046.dkr.ecr.ap-southeast-1.amazonaws.com/dockerhub/openjdk:8-jre-alpine

COPY target/s-communication.jar /usr/app/s-communication.jar

COPY docker/bootstrap.yml /usr/app/bootstrap.yml

CMD ["/usr/bin/java", "-jar", "-Dspring.config.location=file:/usr/app/bootstrap.yml", "/usr/app/s-communication.jar"]
