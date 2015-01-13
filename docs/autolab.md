# **Autolab** Terminal.com Snapshot

*Offer auto-graded assigment for students - For any programming class, and any language.*

---

## About Autolab

Autolab is a course management service at CMU that enables instructors to offer programming labs to their students over the Internet. The two key ideas in Autolab are autograding, that is, programs evaluating other programs, and scoreboards.

Autolab also provides other services that instructors expect in a course management system, including gradebooks, rosters, handins/handouts, lab writeups, code annotation, manual grading, late penalties, grace days, cheat checking, meetings, partners, and bulk emails.

---

## Usage

Spin up a new Terminal based on this snapshot and access the developer section with the credentials provided (see below).

### Credentials

- Development login: `admin@foo.bar`

### Command line execution
- The Tango server can be executed by running: `cd /root/Tango/ ; /root/Tango/startTangoREST.sh`
- The Autolab application is executed by running: `cd /root/Autolab; bundle exec rails s -p 3001 -b 0.0.0.0`

*Tango port: 3000, Autolab port: 3001*

---

## Documentation

- [Autolab website](http://www.autolabproject.com/)
- [Documentation](http://docs.autolab.cs.cmu.edu/)
- [GitHub Repo](https://github.com/autolab/Autolab/)

---

### Snapshot Bootstrap Script

This snapshot was created from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/autolab_installer.sh && bash autolab_installer.sh`

---

#### Thanks for using Autolab at Terminal.com!
