# Reactive Microservices

This project is based mainly on the references below.

    ESCOFFIER, C. Building Reactive Microservices in Java Asynchronous and Event-Based Application Design. First Edition. California: O’Reilly Media, Inc., 2017.

    RedHat Developer, accessed 1 November 2019, <https://developers.redhat.com/promotions/building-reactive-microservices-in-java>

    Kubernetes Hands-On - Deploy Microservices to the AWS Cloud 2018, Udemy, accessed 1 November 2019, <https://www.udemy.com/course/kubernetes-microservices>

    <https://github.com/hazelcast/hazelcast-code-samples/>

    <https://vertx.io/docs/vertx-hazelcast>


Vert.x offers an event bus allowing the different components of an application to interact using messages. Messages are sent to addresses and have a set of headers and a body. An address is an opaque string representing a destination. Message consumers register themselves to addresses to receive the messages. The event bus is also clustered, meaning it can dispatch messages over the  network between distributed  senders and consumers. By starting a Vert.x application in cluster mode, nodes are connected to enable shared data structure, hard-stop  failure detection, and load-balancing group communication. The event bus can dispatch messages among all the nodes in the cluster.


To create such a clustered configuration, you can use Apache Ignite, Apache  Zookeeper, Infinispan, or Hazelcast.

While Hazelcast (or the technology you choose) manages the node discovery and inventory, the event bus communication uses direct peer-to-peer TCP connections.


The event bus provides three types of delivery semantics. First, the send method allows a component to send a message to an address. A single consumer is going to receive the message. If more than one consumer is registered on this address, Vert.x applies a round-robin strategy to select a consumer:


    // Consumer
    vertx.eventBus().consumer("address", message -> {
      System.out.println("Received: '" + message.body() + "'");
    });
    // Sender
    vertx.eventBus().send("address", "hello");


In contrast to send, you can use the publish method to deliver the message to all consumers registered on the address. Finally, the send method can be used with a reply handler. This request/response mechanism allows implementing message-based asynchronous interactions between two components:


      // Consumer
      vertx.eventBus().consumer("address", message -> {
        message.reply("pong");
      });
      // Sender
      vertx.eventBus().send("address", "ping", reply -> {
        if (reply.succeeded()) {
          System.out.println("Received: " + reply.result().body());
        } else {
          // No reply or failure
          reply.cause().printStackTrace();
        }
      });



## Message-Based Microservices

Let’s reimplement the Hello microservice, this time using an event bus instead of an HTTP server to receive the request. The microservice replies to the message to provide the response.


[Writing the Message-Driven Verticle](./project-004/README.md)


[Initiating Message-Based Interactions](./project-005/README.md)

