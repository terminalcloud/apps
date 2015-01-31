# **GitLab** Terminal.com Snapshot

*Version Control on your own Server*

---

## About GitLab
GitLab is an incredibly powerful open source code collaboration platform, git repository manager, issue tracker and code reviewer. 
It integrates with issue trackers, continuous integration services and our Enterprise Edition has phenomenal LDAP and Active Directory support.

---

## Main Features

- Unified and side-by-side diffs
- Merge requests for code review
- Line specific comments
- Issues with attachments
- Issue labels and assignments
- Issue milestones / sprints
- Link to an external issue tracker
- Activity feed per project
- User dashboard with filters
- Comprehensive activity feed
- A wiki which is stored in git
- Code snippets
- Branches and a network graph
- Unique permission levels per user and project (guest, reporter, developer, master, owner)
- Protected branches (only masters can push to protected branches)
- Forking of repo’s
- Merge requests between forks
- Groups consisting of multiple people with a shared namespace for projects
- Multiple deploy keys are possible for the same project
- Multiple projects are possible for the same deploy key
- Global and per project notification settings
- Http(s) and ssh git access
- LDAP user authentication (also compatible with Active Directory)
- Single Sign On (SSO) support via Omniauth strategies
- Web hooks
- Convenient backups
- Administrative interface
- Web based editor
- Code search
- Runs on physical and virtual machines
- High availability / clustering / scale out
- Access to the source code
- Broadcast messages

---

## Usage

Just spin up a new Terminal based on this snapshot. Access the admin section by clicking to "Check your installation here" and login with the credentials provided (see below).

### Credentials

- username: `root`
- password: `5iveL!fe`

--- 

![1](http://i.imgur.com/QLTcBYq.png)

---

## Documentation

- [GitLab website](https://about.gitlab.com/)
- [Documentation](http://doc.gitlab.com/ce/)
- [Community pages](https://about.gitlab.com/community/)
- [Blog](https://about.gitlab.com/blog/)

---

### Snapshot Bootstrap Script

This snapshot was created from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/gitlab_installer.sh && bash gitlab_installer.sh`

---

#### Thanks for using GitLab at Terminal.com!