# **Mesos Slave Node** Terminal.com Snapshot

*Program against a cluster like it’s a single pool of resources*

---

## About Mesos

**Apache Mesos** abstracts CPU, memory, storage and other resources away from machines (physical or virtual). It enables fault-tolerant and elastic distributed systems to be easily built and run effectively.

Mesos is built using the same principles as the Linux kernel, only at a different level of abstraction. The Mesos kernel runs on every machine and provides applications (e.g. Hadoop, Spark, Kafka, Elastic Search) with APIs for resource management and scheduling across entire datacenter and cloud environments.

## Key Features

- Scales up to 10,000s of nodes.
- Fault-tolerant replicated master and slaves using ZooKeeper.
- Support for Docker containers.
- Native isolation between tasks with Linux Terminals.
- Multi-resource scheduling (memory, CPU, disk and ports).
- Java, Python and C++ APIs for developing new parallel applications.
- Web UI for inspecting cluster state.

---

## About This Snapshot

This snapshot provides an easy way to deploy a Mesos slave server. It needs [Mesos master server](/snapshot/8425157703ed8995766cf72fd98116b986067c72b92737f2f862fdd28c5f1aed) as it doesn't do anything useful on its own.

---

# Usage

- Spin up your Mesos slave snapshot.
- Provide the Master Node IP to the startup script (see the terminal).
- Access the Mesos status panel in your master node and check if all the slaves are registered (the registration process can take a couple of minutes).

---

![1](http://ampcamp.berkeley.edu/3/exercises/img/mesos-webui-all-slaves640.png)
![2](https://dw8zztroqvu2r.cloudfront.net/assets/marathon-0.6.0/mesosphere-marathon-app-list-8d86646c69aa58ae4762d2314d8e2900.png)

---

## Documentation

- [Apache Mesos Official Website](http://mesos.apache.org/)
- [Mesos Documentation Page](http://mesos.apache.org/documentation/latest/)
- [Mesos Community Page](http://mesos.apache.org/community/)
- [Mesos Frameworks](http://mesos.apache.org/documentation/latest/mesos-frameworks/)
- [Marathon Framework GitHub Repo](https://github.com/mesosphere/marathon)

---

#### Thanks for using Apache Mesos at Terminal.com!
