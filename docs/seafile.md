# **Seafile** Terminal.com Snapshot

*Open Source Cloud Storage with advanced features.*

---

## About Seafile

**Seafile** is a next-generation open source cloud storage system with advanced support for file syncing, privacy protection and teamwork.

Collections of files are called libraries, and each library can be synced separately. A library can be encrypted with a user chosen password. This password is not stored on the server, so even the server admin cannot view a file's contents.

Seafile allows users to create groups with file syncing, wiki, and discussion to enable easy collaboration around documents within a team.

---

## Main Features

### Complete and advanced file syncing

1. Selective synchronization of file libraries. Each library can be synced separately.
2. Correct handling of file conflicts based on history instead of timestamp.
3. Efficient bandwidth usage by only transfering contents not in the server, and incomplete transfers can be resumed.
4. Sync with two or more servers.
5. Sync with existing folders.
6. Sync a sub-folder.
7. Full version control with configurable revision number.


### Full team collaboration support

1. Groups with file syncing, wiki, discussion.
2. Online file editing and comments.
3. Sharing sub-folders to users/groups.
4. Sharing single files between users.
5. Sharing links.
6. Personal messages.

### Advanced privacy protection

1. Library encryption with a user chosen password.
2. Client side encryption.
3. Never sends the user's password to the server.

---

## Usage

Just spin up a new Terminal based on this snapshot. Access the admin section by clicking to "Seafile login" and login with the credentials provided (see below).

### Credentials

- username: `admin@localhost.localdomain`
- password: `t3rminal`

---

![1](http://i.imgur.com/aUYaYab.png)

---

## Documentation and links

- [Seafile Website](http://seafile.com/en/home/)
- [Servers Manual](http://manual.seafile.com/)
- [Wiki](https://seacloud.cc/group/3/wiki/)
- [Users Forum](https://groups.google.com/forum/#!forum/seafile)

---

### Snapshot Bootstrap Script

This snapshot was created from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/seafile_installer.sh && bash seafile_installer.sh`

---

#### Thanks for using Seafile at Terminal.com!
