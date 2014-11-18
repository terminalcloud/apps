# Ubuntu 14.04 with XFCE4 and Guacamole  - Terminal

This Terminal has a full Ubuntu 14.04 ready to use and install whatever you want.
It also contains a full configured X11vnc and Guacamole server to let you connect to this machine graphically just using your web browser.

As Guacamole is under heavy development and still under the version 1, please use with caution.

We've installed the Guacamole version that works best with Terminal but we will continue testing and deploying new versions, so keep an eye on this snap!


## About XFCE:
**Xfce** is a lightweight desktop environment for UNIX-like operating systems. It aims to be fast and low on system resources, while still being visually appealing and user friendly.


## About Guacamole
**Guacamole** is a clientless remote desktop gateway. It supports standard protocols like VNC and RDP.
Thanks to HTML5, once Guacamole is installed on a server, all you need to access your desktops is a web browser.

![imgur_1](http://i.imgur.com/6Q5NtX6.png)

---

## Instructions:

This Terminal is configured to be used as a **desktop machine**, but you can also use it as a base image to install whatever you want.
Keep in mind that the user experience may vary depending on the browser, location and network conditions.


### General Usage
- Spin up a new Terminal based on this snapshot.
- Access your desktop directly by pressing on "See your desktop here!".


You can also share your desktop screen by opening the port 8080 on the "Share access menu" in this Terminal IDE.

As the web desktop interface is based in Guacamole, the clipboard exchange is managed using a clipboard text box, located on the first screen. You can use it to copy and paste text between your own computer and the Terminal.


### Additional usage information [optional]:
You can also connect to the desktop using a VNC client directly.

To do that, you have to use a **Unix based machine** (Like Linux or MacOs), have **ssh** installed and configured on your system, ssh keys [installed at Terminal.com](https://www.terminal.com/settings/ssh_keys) and [ssh proxy](https://www.terminal.com/ssh) configured in your computer.

Then,
- Add your public ssh keys to the .ssh/authorized_keys file .
- In your own computer execute `ssh -C root@terminalservername.terminal.com -L 5901:terminalservername:5901 `to start the ssh tunnel between your computer and the terminal Terminal. If everything is well configured, you will see the command prompt of your terminal Terminal.
- Select your favorite VNC client and connect to localhost using the default port (5901). [In linux you just can execute `vncviewer localhost:5901`]


(For resolution and further options, please refer to the user manual of VNC client.)

---

#### Thanks for use this Terminal.com snapshot!
