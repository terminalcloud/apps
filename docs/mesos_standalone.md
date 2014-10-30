# **Mesos Standalone** Terminal.com Snapshot
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
Mesos is a flexible and highly configurable "Distributed Systems Kernel" Cluster.
You can use several execution [Frameworks](http://mesos.apache.org/documentation/latest/mesos-frameworks/) with it.
We're including [Marathon](https://github.com/mesosphere/marathon) (A Cluster-wide init and control system [or PaaS layer] for services) as the default framework installed on this snap.  

On this case, this snapshot have both services installed on it. (Master and Slave) It should be used for test and development purposes mainly.

---

# Usage
- Spin up your Mesos Standalone Terminal.
- Configure your cluster name using the statup script (Already running in the console)
- Acess the Mesos Status Panel and the Marathon Framework Interface by clicking on the links provided.

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