# **Phabricator** Terminal.com Snapshot

*An open source code review platform.*

---

## About Phabricator

**Phabricator** is a collection of open source web applications that help software companies build better software.

Phabricator supports Git, Mercurial and Subversion. The Phabricator server runs on Linux or Mac OS X, but can be used on any platform. The optional, yet powerful, command line client Arcanist runs on Linux, Mac OS X or Windows. Phabricator is written mostly in PHP.

## Key Features

**Review code** with **Differential**.

![1](http://phabricator.org/images/phabricator//differential.png)

- **Host Git/Mercurial/SVN Repositories or connect other hosts**
Phabricator can host Git, Mercurial and Subversion repositories. It also works well with existing repositories (like GitHub, Bitbucket or other repositories you already have elsewhere) without needing to host them itself.

![2](http://phabricator.org/images/repos.png)

- **Browse and Audit Source Code**
Use **Diffusion** to look at source code in your browser.

![3](http://phabricator.org/images/phabricator//diffusion.png)

- **Track bugs**
Legacy system? Keep track of all the defects and problems using **Maniphest**.

![4](http://phabricator.org/images/phabricator//maniphest_mobile.png)

- **Write Things Down**
You can write things down with **Phriction**, which is a wiki.

![5](http://phabricator.org/images/phabricator//phriction.png)

- **Watch for Danger**
As your company scales, keep track of activity with **Herald**, which notifies you when things you care about happen (like a specific file being changed).

![6](http://phabricator.org/images/phabricator//herald.png)

- **CLI**
The arcanist command line tool gives you CLI access to most of Phabricator's functionality.

![7](http://phabricator.org/images/phabricator//arcanist.png)

- **API**
The **Conduit** API allows you to write scripts that interact with Phabricator over an HTTP JSON API.

![8](http://phabricator.org/images/phabricator/conduit.png)

---

## Usage

Just spin up your Terminal based on this snapshot and click to "Check your installation here".
Create your own admin account and start configuring Phabricator.
Phabricator provides various authentication methods like user/pass, Amazon, Facebook, Google, GitHub, etc. Configure yours at http://yourterminalname-80.terminal.com/auth/

For more information about usage please check the [User Documentation](http://www.phabricator.com/docs/phabricator/) page.

##### Changing default URL

If you want to change the Phabricator URL, execute: `/var/www/phabricator/bin/config set phabricator.base-uri "new URL"`

---

![10](http://phabricator.org/images/phabricator//hero.png)

---

## Documentation

- [Phabricator Official Website](http://phabricator.org/)
- [Applications](http://phabricator.org/applications/)
- [User Documentation](http://www.phabricator.com/docs/phabricator/)

---

## Additional Information

### Snapshot Bootstrap Script

This snapshot was created from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/phabricator_installer.sh && bash phabricator_installer.sh`


---

#### Thanks for using Phabricator at Terminal.com!
