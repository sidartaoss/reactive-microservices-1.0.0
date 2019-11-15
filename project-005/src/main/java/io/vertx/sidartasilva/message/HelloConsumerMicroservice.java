package io.vertx.sidartasilva.message;

import io.vertx.core.json.JsonObject;
import io.vertx.rxjava.core.AbstractVerticle;
import io.vertx.rxjava.core.eventbus.EventBus;
import io.vertx.rxjava.core.eventbus.Message;
import rx.Single;

public class HelloConsumerMicroservice extends AbstractVerticle {

    @Override
    public void start() {
      vertx.createHttpServer()
        .requestHandler(
          req -> {
            EventBus bus = vertx.eventBus();
            Single<JsonObject> obs1 = bus
              .<JsonObject>rxSend("hello", "Adam")
              .map(Message::body);
            Single<JsonObject> obs2 = bus
              .<JsonObject>rxSend("hello", "Eve")
              .map(Message::body);

            Single
              .zip(obs1, obs2, (adam, eve) -> 
                  new JsonObject()
                  .put("Adam", adam.getString("message") 
                      + " from " 
                      + adam.getString("served-by"))
                  .put("Eve", eve.getString("message")
                      + " from "
                      + eve.getString("served-by"))
              )
              .subscribe(
                x -> req.response().end(x.encodePrettily()),
                t -> {
                  t.printStackTrace();
                  req.response().setStatusCode(500).end(t.getMessage());
                }
              );
          }
        )
        .listen(8082);
    }

}
