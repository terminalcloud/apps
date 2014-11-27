# **Nginx Automated Load Balancer** Terminal.com Snapshot

*A customized load-balancer snapshot with automation add-ons*

---

## About this snapshot

This was created to show how to use Terminal.com to extend your infrastructure easily and automatically in a simple way by using simple shell scripts and a trivial Node.js application.


## Basic Components

- A wizard script: When you create this snapshot by the first time, a wizard script will be running in a Terminal tab. This script will ask you for some simple questions and will guide you to creating new Terminals based on existing snapshots.

- A Node.js node registration server: This is a simple rest API application running on your second tab. This application is running on the port 5500 and will react to a get request with specific parameters. This simple application is located at /opt/loadbalancer/bin/node-registrar.js and you can execute it directly using 'forever' or 'node' commands. All Node dependencies are installed on that specific folder.

- A Nginx server pre-configured: Nginx is already installed on this snapshot and using a configuration file prepared to make it work as a load-balanced proxy. The configuration file is loacated at /opt/loadbalancer/nginx-lb.conf. You may want to chang some parameters and do fine-tune on it based on your application characteristics.

- A client side registration script: Anytime you create a new application Terminal node with the wizard script, this script will run. Using some parameters passed to the Terminal.com API during the Terminals creation, this script will register the node against the load-balancer and it will be automatically.

- NFS file server - By default, a NFS server is installed on the load balancer snapshot - The NFS clients will be authorized via the Node.js registration server. When a new Terminal is registered against the load balancer, the local /share folder will be mounted on the client on /mnt/share.


---

## Main Features

- Nginx load balancer configuration ready to use.
- Automatic load balancer nodes creation based on common stacks (Lamp on Ubuntu, Lamp on Centos, NodeJS, Ruby, etc)
- Automatic load balancer registration.
- Automatic NFS share authorization.
- Automatic NFS share mounts on clients.
- Automatic database servers creation based on common images (Mysql, MongoDB, etc)
- Custom snapshots support for application and db servers.
- After installation scripts usage.
- REST based registration server.
- Only shell script and Javascript components - No binary components.

---

## Usage

### Basics

You can use this snapshot in different ways. Use the automatic Terminal generation or just use it as base for you own load-balancerd environment configuration.

- Just start a new Terminal from this snapshot and follow the on-screen instructions.
- Use the script to create new snapshots for your application servers directly from shared or custom snapshots.
- Use the Node.js registration app to add other working Terminals and balance your web load accross your infrastructure.


### Advanced usage - Automatic registration
In the second tap, the Node.js registration server is listening. You can use cURL ro register new servers on this load balancer from clients.
A tipical registration request using the `curl` command is: ` # curl $LB_IP:5500/reg/$SERVER_KEY,$APP_IP,$APP_PORT,$LB_RETRIES,$LB_TIMEOUT`; where:

- $LB_IP is the Load Balancer server IP.
- $SERVER_KEY is a string generated at the time your Load Balancer Terminal is created. You can find it at /opt/loadbalancer/etc/server.key.
- $APP_IP is your application server node IP (the node to be registered against the Load Balancer).
- $APP_PORT is the port where your application is listening on the application server node to be registered.
- $LB_RETRIES is a integer value that represents the amount of retries that Nginx will try to make to the current node before mark it as faulted.
- $LB_TIMEOUR is a integer value that represents the amount of time, in seconds that Nginx will wait before mark the current node as faulted if it does not respond.

---

## Documentation

- [Nginx Documetation](http://nginx.org/en/docs/)

---

### Snapshot Bootstrap Script

This snapshot was created from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/nginx-lb_installer.sh && bash nginx-lb_installer.sh`

---

#### Thanks for using nginx-lb at Terminal.com!
