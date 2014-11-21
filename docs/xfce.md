# Ubuntu 14.04 with XFCE4 - Terminal

*This container contains a full configured X11vnc and Guacamole server to let you connect to this machine graphically using your web browser. Enjoy using desktop applications like Libreoffice or Gimp directly from the cloud!*

## About XFCE

**XFCE** is a lightweight desktop environment for Unix and Unix-like operating systems. It aims to be fast and low on system resources, while still being visually appealing and user-friendly.

![Imgur](http://i.imgur.com/u4ABBuv.jpg)
![Imgur](http://i.imgur.com/QBElyBe.jpg)

---

## Instructions

Please read these instructions **carefully**. The instructions works only for unix-based systems. Windows instructions are coming later.

Keep in mind that the user experience may vary depending on the remote desktop client location and network conditions.

### Requirements

- Linux, BSD or OS X machine.
- SSH installed and configured on your system.
- Good network upload and download speeds.
- SSH keys [installed at Terminal.com](https://www.terminal.com/settings/ssh_keys) and [SSH proxy](https://www.terminal.com/ssh) configured in your `~/.ssh/config` file.

### General Usage

- Spin up a new Terminal based on this snap.
- A configuration script will ask for your SSH public key, change the root password.
- The script will also tell you the command you should execute to start the SSH tunnel between your computer and the Terminal.
- Go back to your computer, open a terminal app and execute the command provided to start the SSH tunnel. If everything is well configured, you will see the command prompt of your Terminal.
- Open your favorite remote desktop client and connect to localhost using the default port (3389). (On Linux you just can execute `rdesktop localhost`).
- Login with root and the password that you just configured in the Terminal command line.

(For resolution and further options please refer to the user manual of remote desktop client.)

---

#### Thanks for use this Terminal.com snapshot!
