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

Usage Section

---

![1](IMAGE_URL)

---

## Documentation

- [nginx-lb website]()
- [Documentation]()

---

### Snapshot Bootstrap Script

This snapshot was created from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/nginx-lb_installer.sh && bash nginx-lb_installer.sh`

---

#### Thanks for using nginx-lb at Terminal.com!
