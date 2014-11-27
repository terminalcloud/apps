# **Nginx Automated Load Balancer** Terminal.com Snapshot

*A customized load-balancer snapshot with automation add-ons*

---

## About this snapshot

This was created to show how to use Terminal.com to extend your infrastructure easily and automatically in a simple way by using simple shell scripts and a trivial node.js application.


## Contents

- A wizard script: When you create this snapshot by the first time, a wizard script will be running in a Terminal tab. This script will ask you for some simple questions that will guide you creating new Terminals based on existing snapshots.

- A Node.js node registration server: This is a simple rest API application running on your second tab. This application is running on the port 5500 and will react to a get request with specific parameters. This simple application is located at /opt/loadbalancer/bin/node-registrar.js and you can execute it directly using 'forever' or 'node' commands. All Node dependencies are installed on that specific folder.

- A Nginx server pre-configured: Nginx is already installed on this snapshot and using a configuration file prepared to make it work as a load-balanced proxy. The configuration file is loacated at /opt/loadbalancer/nginx-lb.conf. You may want to chang some parameters and do fine-tune on it based on your application characteristics.

- A client side registration script: Anytime you create a new application Terminal node with the wizard script, this script will run. Using some parameters passed to the Terminal.com API during the Terminals creation, this script will register the node against the load-balancer and it will be automatically.


---

## Main Features

- FEATURES

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
