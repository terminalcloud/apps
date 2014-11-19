# Kubuntu 14.04 WebDesktop - Terminal Snapshot

This Terminal has a full Ubuntu 14.04 ready to use and install whatever you want.
It also contains a full configured X11vnc and Guacamole server to let you connect to this machine graphically just using your web browser.

As Guacamole is under heavy development and still under the version 1, please use with caution.

We've installed the Guacamole version that works best with Terminal but we will continue testing and deploying new versions, so keep an eye on this snap!


## About Kubuntu:

**Kubuntu** is an official derivative of the Ubuntu operating system which uses the KDE Plasma Desktop instead of the Unity graphical environment. As part of the Ubuntu project, Kubuntu uses the same underlying systems, every package in Kubuntu shares the same repositories as Ubuntu. It comes with the KDE Plasma Desktop (kubuntu-desktop) and extensive set of application specially designed for KDE.


## About Guacamole
**Guacamole** is a clientless remote desktop gateway. It supports standard protocols like VNC and RDP.
Thanks to HTML5, once Guacamole is installed on a server, all you need to access your desktops is a web browser.

![imgur_1](http://i.imgur.com/dOGMd8W.png)

---

## Instructions:

This Terminal is configured to be used as a **desktop machine**, but you can also use it as a base image to install whatever you want.
Keep in mind that the user experience may vary depending on the browser, location and network conditions.


### General Usage
- Spin up a new Terminal based on this snapshot.
- Access your desktop directly by pressing on "See your desktop here!".
- For additional options like cliboard interface, access the "Guacamole interface".

- Password for vnc user: `t3rminal` (*sudo all* granted)

You can also share your desktop screen by opening the port 8080 on the "Share access menu" in this Terminal IDE.

As the web desktop interface is based in Guacamole, the clipboard exchange is managed using a clipboard text box, located on the Guacamole Interface. You can use it to copy and paste text between your own computer and the Terminal.

### Additional usage information [optional]:
You can also connect to the desktop using a VNC client directly.

To do that, you have to use a **Unix based machine** (Like Linux or OS X), have **ssh** installed and configured on your system, ssh keys [installed at Terminal.com](https://www.terminal.com/settings/ssh_keys) and [ssh proxy](https://www.terminal.com/ssh) configured in your computer.

Then,
- Add your public ssh keys to the .ssh/authorized_keys file .
- In your own computer execute `ssh -C root@terminalservername.terminal.com -L 5901:terminalservername:5901 `to start the ssh tunnel between your computer and the terminal Terminal. If everything is well configured, you will see the command prompt of your terminal Terminal.
- Select your favorite VNC client and connect to localhost using the default port (5901). [In linux you just can execute `vncviewer localhost:5901`]


(For resolution and further options, please refer to the user manual of VNC client.)

---

#### Thanks for use this Terminal.com snapshot!
