# Kubuntu 14.04 WebDesktop - Terminal Snapshot

*This contains a full configured X11vnc and Guacamole server to let you connect to this machine graphically just using your web browser.*

Be aware that Guacamole is under heavy development. We will continue testing and deploying new versions, so keep an eye on this snap!

## About Kubuntu

**Kubuntu** is an official derivative of the Ubuntu operating system which uses the KDE Plasma Desktop instead of the Unity graphical environment. As part of the Ubuntu project, Kubuntu uses the same underlying systems, every package in Kubuntu shares the same repositories as Ubuntu. It comes with the KDE Plasma Desktop (kubuntu-desktop) and extensive set of application specially designed for KDE.

## About Guacamole

**Guacamole** is a client-less remote desktop gateway. It supports standard protocols like VNC and RDP. Thanks to HTML 5, once Guacamole is installed on a server, all you need to access your desktops is a web browser.

![imgur_1](http://i.imgur.com/wBo7pqH.png)

---

## Instructions

This Terminal is configured to be used as a **desktop machine**, but you can also use it as a base image to install whatever you want. Keep in mind that the user experience may vary depending on the browser, location and network conditions.

### General Usage

- Spin up a new Terminal based on this snapshot.
- Access your desktop directly by pressing on "See your desktop here!".
- For additional options like clipboard interface, access the "Guacamole interface".

- Password for the vnc user: `t3rminal` (*sudo all* granted)

You can also share your desktop screen by opening port 8080 on the "Share access menu" in the Terminal IDE.

As the web desktop interface is based in Guacamole, the clipboard exchange is managed using a clipboard text box, located on the Guacamole interface. You can use it to copy and paste text between your own computer and the Terminal.

### Alternative Way of Using the Snap: Connect Directly Through a VNC Client

Assuming that you have either Linux, OS X or some other Unix system and you have SSH, a pair of SSH keys. Make sure your SSH keys are [installed at Terminal.com](https://www.terminal.com/settings/ssh_keys) and you added [SSH proxy](https://www.terminal.com/ssh) configuration to your SSH config.

Then:
- Add your public SSH key to `~/.ssh/authorized_keys` on the Terminal.
- In your own computer execute `ssh -C root@terminalservername.terminal.com -L 5901:terminalservername:5901` to start an SSH tunnel between your computer and the Terminal terminal. If everything is well configured, you will see the command prompt of your Terminal.
- Select your favorite VNC client and connect to localhost using the default port (5901). (On Linux you just can execute `vncviewer localhost:5901`.)

(For resolution and further options, please refer to the user manual of your VNC client.)

---

#### Thanks for use this Terminal.com snapshot!
