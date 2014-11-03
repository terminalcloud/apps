# Ubuntu 14.04 with XFCE4 - Terminal.com Container

This container has a full Ubuntu 14.04 ready to use and install whatever you want.
It also contains X11rdp to let you connect to the machine using remote desktop.

## About XFCE:
**Xfce** is a lightweight desktop environment for UNIX-like operating systems. It aims to be fast and low on system resources, while still being visually appealing and user friendly.

![Imgur](http://i.imgur.com/u4ABBuv.jpg)
![Imgur](http://i.imgur.com/QBElyBe.jpg)

---

## Instructions:
Please read the instructions **carefuly**.

This container is configured to be used as a desktop machine, but you can also use it as a base image to install whatever you want.

The instructions are only valid for Linux, BSD or MacOS systems.
Windows instructions coming soon.


Keep in mind that the user experience may vary depending on the remote desktop client location and network conditions.


### Requirements
- A Unix based machine [Like Linux or MacOs]
- Ssh installed and configured on your system.
- Good network upload and download speeds.
- Ssh keys [installed at Terminal.com](https://www.terminal.com/settings/ssh_keys) and [ssh proxy](https://www.terminal.com/ssh) configured in your computer.


### General Usage:
- Spin up a new Terminal container based on this snap.
- A configuration script will ask for your ssh public key, change the root password.
- It will also tell you which command you should execute to start the ssh tunnel between your computer and the terminal container.
- Go back to your computer, open a terminal tab (command line) and execute the command provided to start the ssh tunnel. If everything is well configured, you will see the command prompt of your terminal container.
- Select your favorite remote desktop client and connect to localhost using the default port (3389). [In linux you just can execute `rdesktop localhost`]
- Login with root and the password that you just configured in the Terminal command line.


(For resolution and further options please refer to the user manual of remote desktop client.)

---

#### Thanks for use this Terminal.com snapshot!