# Ubuntu 14.04 with XFCE4 - Terminal.com Container

This container has a full Ubuntu14.04 ready to use and install whatever you want.
It also containes X11rdp to let you connect to the machine using remote desktop. 

## About XFCE:
**Xfce** is a lightweight desktop environment for UNIX-like operating systems. It aims to be fast and low on system resources, while still being visually appealing and user friendly.

[Imgur](http://i.imgur.com/u4ABBuv.jpg)
[Imgur](http://i.imgur.com/QBElyBe.jpg)

---
   
## Instructions:
Please read the instructions **carefuly**.

This container has been tunned to be used with remote desktop, but you can also use it as a base to install whatever you want. To make the connection secure, we will be using a ssh tunnel.
The instructions are only valid for Linux, BSD or MacOS systems.

Windows instructions comming soon.


Keep in mind that the user experience may vary depending on the remote desktop client location and network conditions.


### Requirements
- A Unix based machine [Like Linux or MacOs]
- Ssh installed and configured on your system.
- Good network upload and download speeds.
- Ssh keys [installed at Terminal.com](https://www.terminal.com/settings/ssh_keys) and [ssh proxy](https://www.terminal.com/ssh) configured in your computer.


### General Usage:
- Spin up this snap.
- A configuration script will ask for your ssh public key, change the root password.
- It will also tell you which command you should execute to start the ssh tunnel between your computer and the terminal container.
- Go back to your computer, open a terminal tab (command line) and execute the command provided to start the ssh tunnel. If everything is well configured, you will see the login prompt of your terminal container.
- Select your favorite remote desktop client and connect to localhost using the default port (3389). [In linux you just can execute `rdesktop localhost`]
- For resolution and further options please refer to the user manual of remote destktop client .

---

#### Thanks for try this Terminal.com snapshot