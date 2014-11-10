# **Shinken** Terminal.com Snapshot

*Monitoring framework written in Python.*

---

## About Shinken

**Shinken** is a resilient fully scalable monitoring framework. It supervises hosts and services from an IT and business point of view. When an error (and the recovery) happens, it can alert you or take a predefined action.

Shinken is compatible with Nagios configuration, plugins and interfaces. It is written in Python.

---

## Main Features

- Web 2.0 interface named WebUI that has innovative methods to visualize the state of your systems.
- Live status networked API module to provide real-time access to performance, status and configuration data.
- Provides operational or business insight.
- Monitor hosts and services.
- Contact notifications when service or host problems occur and get resolved (via email, SMS, pager or user-defined method).
- Ability to define event handlers to be run during service or host events for proactive problem resolution.
- Integrates with PNP4Nagios and Graphite time-series databases for storing data, querying or displaying data.
- Supports distributed retention modules, caches and databases to meet persistence and performance expectations.

---

## Usage

Spin up a new Terminal based on this snapshot.

Access the Shinken WebUI by clicking to "Check your installation here" and login with the credentials provided (see below).

The Shinken main interface is a CLI (command line interface). To start the CLI execute `shinken`.

### Credentials

- username: `admin`
- password: `t3rminal`

---

![1](http://www.shinken-monitoring.org/fichiers/img/screenshots/impacts.png)

---

## Documentation

- [Shinken Website](http://www.shinken-monitoring.org/)
- [Documentation](https://shinken.readthedocs.org/en/latest/index.html)
- [Blog](http://shinkenlab.io/)
- [Shinken Forum](http://www.shinken-monitoring.org/forum)

---

### Snapshot Bootstrap Script

This snapshot was created from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/shinken_installer.sh && bash shinken_installer.sh`

---

#### Thanks for using Shinken at Terminal.com!
