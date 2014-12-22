# **RabbitMQ** Terminal.com Snapshot

*Messaging that just works.*

---

## About RabbitMQ

Messaging enables software applications to connect and scale. Applications can connect to each other, as components of a larger application, or to user devices and data. Messaging is asynchronous, decoupling applications by separating sending and receiving data.

You may be thinking of data delivery, non-blocking operations or push notifications. Or you want to use publish / subscribe, asynchronous processing, or work queues. All these are patterns, and they form part of messaging.

RabbitMQ is a messaging broker - an intermediary for messaging. It gives your applications a common platform to send and receive messages, and your messages a safe place to live until received.

---

## Main Features

- Reliability - RabbitMQ offers a variety of features to let you trade off performance with reliability, including persistence, delivery acknowledgements, publisher confirms, and high availability.
- Flexible routing - Messages are routed through exchanges before arriving at queues. RabbitMQ features several built-in exchange types for typical routing logic. For more complex routing you can bind exchanges together or even write your own exchange type as a plugin.
- Clustering support - Several RabbitMQ servers on a local network can be clustered together, forming a single logical broker.
- Federation support - For servers that need to be more loosely and unreliably connected than clustering allows, RabbitMQ offers a federation model.
- HA queues - Queues can be mirrored across several machines in a cluster, ensuring that even in the event of hardware failure your messages are safe.
- Multi-Protocol - RabbitMQ supports messaging over a variety of messaging protocols.
- Integrated management UI - RabbitMQ ships with an easy-to use management UI that allows you to monitor and control every aspect of your message broker.
- Plugin system - RabbitMQ ships with a variety of plugins extending it in different ways, and you can also write your own.

---

## Usage

Just spin up a new Terminal based on this snapshot. Access the admin section by clicking to "RabbitMQ Admin login" and login with the credentials provided (see below).

The local API port is: 5672. You can access that port externally at http://terminalservername-5672.terminal.com . Remember to open that port if you want to use cURL directly.


### Credentials

- username: `admin`
- password: `t3rminal`

---

![1](http://i.imgur.com/eI3JR4a.png)

---

## Documentation

- [RabbitMQ website](http://www.rabbitmq.com/)
- [Documentation](http://www.rabbitmq.com/documentation.html)
- [RabbitMQ community page](http://www.rabbitmq.com/community.html)
- [Blog](http://www.rabbitmq.com/blog/)

---

### Snapshot Bootstrap Script

This snapshot was created from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/rabbitmq_installer.sh && bash rabbitmq_installer.sh`

This Terminal snapshot was created with [Pulldocker](http://blog.terminal.com/docker-without-containers-pulldocker/) from the [tutum/rabbitmq](https://registry.hub.docker.com/u/tutum/rabbitmq/) docker image.

---

#### Thanks for using RabbitMQ at Terminal.com!
