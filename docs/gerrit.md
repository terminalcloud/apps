# **Gerrit** Terminal.com Snapshot
*A web based code review and project management for Git based projects.*

---

## About Gerrit
**Gerrit** is a web based code review system, facilitating online code reviews for projects using the Git version control system.

It makes reviews easier by showing changes in a side-by-side display, and allowing inline comments to be added by any reviewer.

Gerrit simplifies Git based project maintainership by permitting any authorized user to submit changes to the master Git repository, rather than requiring all approved changes to be merged in by hand by the project maintainer. This functionality enables a more centralized usage of Git.


### Some Showcase Gerrit installations

- [ChromiumOS](http://chromium-review.googlesource.com/)
- [LibreOffice](https://gerrit.libreoffice.org/)
- [Couchbase](http://review.couchbase.org/)
- [Eclipse](https://git.eclipse.org/r/)

For a complete list please visite the [Gerrit ShowCases page](https://code.google.com/p/gerrit/wiki/ShowCases)

---

## Usage

- Spin-up your container based on this snapshot and click over "Check your installation here".
- Login with your OpenID user [Yahoo OpenID is recommended]
- The first user to login Gerrit will be the Gerrit Admin by default. You will prompted to change your settings and set your keys.

Keep in mind you will need to setup the [Terminal.com ssh proxy](https://www.terminal.com/ssh) to access your Gerrit terminal with ssh.

### Credentials:

Gerrit unix username:
- Username: gerrit5
- Unix password: t3rminal

Gerrit PostgreSQL:
- Username: gerrit5
- Password: t3rminal


### Deployment information
- Gerrit Installation Path: /home/gerrit5/gerrit
- Gerrit start/stop script: /etc/init.d/gerrit
- Config Directory: /home/gerrit5/gerrit/etc/


---

![1](http://upload.wikimedia.org/wikipedia/mediawiki/thumb/9/94/Chrome_gerrit_9332_2.png/800px-Chrome_gerrit_9332_2.png)  

---

## Documentation
- [Gerrit Main Website](https://code.google.com/p/gerrit/)
- [Users Guide (for the current version)](https://gerrit-documentation.storage.googleapis.com/Documentation/2.9.1/index.html)

---

### Additional Information

#### Gerrit Terminal.com container automatic installation:
You can replicate this container from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/gerrit_installer.sh && bash gerrit_installer.sh`


---

#### Thanks for using Gerrit at Terminal.com!