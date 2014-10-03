# **Ushahidi** Terminal.com Snapshot
*Make smart decisions with a data management system that rapidly collects data from the crowd and visualizes what happened, when and where.*

---

## About Ushahidi
**Ushahidi** is a web and mobile platform that allows you to create, visualize and share stories on a map. It allows individuals to share their stories on their own terms using the tools they already have. 


### Features
- **Free & Open Source** - The Ushahidi Platform is free for you to download and use. It is released under the GNU Lesser General Public License [(LGPL)](http://creativecommons.org/licenses/LGPL/2.1/).

- **Interactive Mapping** - One of the most powerful ways to visualize information is to display it on a map. The Ushahidi platform give you rich information mapping tools.

- **Dynamic Timeline** - Track your reports on the map and over time, filter your data by time, and see when things happened and where.

- **Multiple Data Streams** -The Ushahidi Platform allows you to easily collect information via text messages, email, twitter and web-forms.


---

![1](http://newswatch.nationalgeographic.com/files/2012/06/UHP2-921x700.png)

---

## Usage
Spin up your terminal container based on this snapshot and Customize your Ushahidi installation by clicking on "Finish your installation here".

Database Credentials to be used during the installation:

- host: localhost
- name: ushahidi
- user: ushahidi
- Pass: terminal

Then, follow the installation wizard to finish your installation by configuring your site name, hints, admin user, etc.

When the installation is complete, you can access the ushahidi admin section at http://terminalservername-80.terminal.com/admin; access the main site at http://terminalservername-80.terminal.com or [configure your own domain by CNAME](https://www.terminal.com/faq#cname).


## Documentation
- [Ushahidi Main Page](http://www.ushahidi.com/)
- [Ushahidi Wiki](https://wiki.ushahidi.com)


---

### Additional Information
#### Ushahidi Terminal.com container automatic installation:
You can replicate this container from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/ushahidi_installer.sh && bash ushahidi_installer.sh`

Use at least a "small" Terminal container to host this application. 

---

#### Thanks for using Ushahidi at Terminal.com!