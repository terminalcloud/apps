# Ubuntu 14.04 with Ajenti - Terminal

This Terminal has a full Ubuntu14.04 ready to use and install whatever you want.
To administer this machine in a graphical mode, we're providing *Ajenti*

## About Ajenti:
*Ajenti* is a full featured Linux and BSD web admin panel.
You can use Ajenti to install packages, create users and other server
administration task from a convenient web interface.

This containter also has intalled and configured the additional *Ajenti V Plugins* . Now you can configure and publish your web sites directly from the web interface!

### Usage:
Open a new browser tab or window and go to **http://terminalservername-3000.terminal.com**

- User: root
- Pasword: root

To configure and host a new website using Ajenti:
- Put you website files in a folder [it can be a plain html site, a GO site and also a php based site!]
- Go to the **Websites** section in Ajenti and create a new site.
- Click **Manage** over your new site in Ajenti and configure folders, domains, ports and everything else!


By default Ajenti is listening on port 3000 but you can change the port
by editing the /etc/ajenti/config.json file.

** MySQL user and password: root **


### Documentation:
For additional information about Ajenti please go to the [Agenti Support site](http://support.ajenti.org)

### Important Note:
Unless you configure your own domain and HTTPS certificate in Agenti, it will **only** work over HTTP.

---

#### Thanks for try this Terminal.com snapshot
