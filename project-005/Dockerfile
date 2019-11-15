FROM openjdk:8-jre-alpine
ENV VERTICLE_FILE project-005-1.0-SNAPSHOT.jar
ENV VERTICLE_HOME /usr/verticles
ENV VERTX_JGROUPS -Dvertx.jgroups.config=default-configs/default-jgroups-kubernetes.xml -Djava.net.preferIPv4Stack=true
ENV ENV_CLUSTER -cluster
EXPOSE 8082
EXPOSE 5701
COPY $VERTICLE_FILE $VERTICLE_HOME/
WORKDIR $VERTICLE_HOME
ENTRYPOINT ["sh", "-c"]
CMD ["exec java $VERTX_JGROUPS -jar $VERTICLE_FILE $ENV_CLUSTER"]

