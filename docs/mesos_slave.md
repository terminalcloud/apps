# **Mesos Slave Node** Terminal.com Snapshot
*Program against a cluster like it’s a single pool of resources*

---

## About Mesos
**Apache Mesos** abstracts CPU, memory, storage, and other compute resources away from machines (physical or virtual), enabling fault-tolerant and elastic distributed systems to easily be built and run effectively.

Mesos is built using the same principles as the Linux kernel, only at a different level of abstraction. The Mesos kernel runs on every machine and provides applications (e.g., Hadoop, Spark, Kafka, Elastic Search) with API’s for resource management and scheduling across entire datacenter and cloud environments.

## Key Features

- Scalability to 10,000s of nodes
- Fault-tolerant replicated master and slaves using ZooKeeper
- Support for Docker containers
- Native isolation between tasks with Linux Containers
- Multi-resource scheduling (memory, CPU, disk, and ports)
- Java, Python and C++ APIs for developing new parallel applications
- Web UI for viewing cluster state

---

## About this Mesos deployment snapshot
This Snapshot is intended to provide an easy way to deploy a Mesos Slave Server.
Before starting this snapshot, please make sure that there is a Master server already running and that you know the IP address of it.  

---

# Usage
- Spin up your Mesos Slave snapshot
- Provide the Master Node IP to the startup script (Already running in the console)
- Access the Mesos Status Panel in your master node and check if this slave is registered (This process can take a couple minutes).

---

![1](http://ampcamp.berkeley.edu/3/exercises/img/mesos-webui-all-slaves640.png)
![2](https://dw8zztroqvu2r.cloudfront.net/assets/marathon-0.6.0/mesosphere-marathon-app-list-8d86646c69aa58ae4762d2314d8e2900.png)  

---

## Documentation
- [Apache Mesos Main Website](http://mesos.apache.org/)
- [Mesos Documentation Page](http://mesos.apache.org/documentation/latest/)
- [Mesos Community Page](http://mesos.apache.org/community/)
- [Mesos Frameworks](http://mesos.apache.org/documentation/latest/mesos-frameworks/)
- [Marathon Framework Github repo](https://github.com/mesosphere/marathon)


---

#### Thanks for Apache Mesos at Terminal.com!