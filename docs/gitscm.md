# **Git SCM** Terminal.com Snapshot

*Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.*

---

## About Git

Git is easy to learn and has a tiny footprint with lightning fast performance. 
It outclasses SCM tools like Subversion, CVS, Perforce, and ClearCase with features like cheap local branching, convenient staging areas, and multiple workflows.

---

## Main Features

- Branching and Merging support
- Small and Fast
- Distributed
- Ensures Cryptographic Integrity 
- Staging area support

---

## Usage
Spin up a new Terminal based on this snapshot and follow the on-screen instructions to set your first git user.
Create at least a new user and repository by following the instructions below and use your favorite git client to access your repositories via http/s.

### Adding new users 
We provide a simple script called `git-adduser` to this purpose. Its syntax is as easy as: `git-adduser <username>`.
This script will ask you for a password and will save the information in an encrypted file at `/etc/lighttpd/htdigest`. 

### Removing users
To remove users from http/https authentication execute `git-deluser <username>` or delete the username line from the `/etc/lighttpd/htdigest` file.

### Adding a repository to the server.
The repositories root path is located at `/var/cache/git/`. You can create or clone repo there by using git commands.
Additionally, you can execute `git-addrepo <repo_name>` to create an empty repository.


---

## Documentation

- [Git SCM website](http://git-scm.com/)
- [Documentation](http://git-scm.com/doc)
- [Community pages](http://git-scm.com/community)

---

### Snapshot Bootstrap Script

This snapshot was created from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/gitscm_installer.sh && bash gitscm_installer.sh`

---

#### Thanks for using Git at Terminal.com!
