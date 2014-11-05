# **Facebook's osquery** Terminal.com Snapshot

*SQL-powered operating system instrumentation and analytics.*

---

## About **osquery**

With osquery, you can use SQL to query low-level operating system information. Under the hood, instead of querying static tables, these queries dynamically execute high-performance native code. The results of the SQL query are transparently returned to you quickly and easily.

Facebook uses osquery to gain insight into OS X and Linux hosts. Other notable companies also use osquery because of how easy it is to deploy osquery and the advanced insight into their infrastructure that osquery can offer them.

---

### Key Features

- **Interactive SQL:** The interactive query console (osqueryi) gives you SQL interface to try out new queries and to explore your operating system. With the power of the complete SQL language and dozens of useful tables built-in, osqueryi is an invaluable tool when performing incident response, diagnosing systems operations problems, troubleshooting performance issues etc.

- **Distributed monitoring:** The high-performance, low-footprint distributed host monitoring daemon (osqueryd) allows you to schedule queries to be executed across your entire infrastructure. The daemon takes care of aggregating the query results over time and generates logs which indicate state changes in your infrastructure. You can use this to maintain insight into the security, performance, configuration and state of your entire infrastructure. Osqueryd's logging can integrate right into your internal log aggregation pipeline, regardless of your technology stack, via a robust plugin architecture.

- **Performance is a feature:** A top-level goal of osquery is for it to be performant enough to run on production infrastructure with the smallest possible footprint. The core osquery team at Facebook puts a lot of effort into ensuring that all code is rigorously benchmarked and tested for memory leaks. All systems operations in osquery use underlying systems APIs exclusively. For example, the kextstat table in OS X uses the same underlying core APIs as the kextstat command.

---

## Usage

Just spin up a new Terminal based on this snapshot and start using **osquery** on the same Terminal window.

### Commands

- [Interactive SQL shell](https://github.com/facebook/osquery/wiki/using-osqueryi): `osqueryi`
- [Host Monitoring daemon](https://github.com/facebook/osquery/wiki/using-osqueryd): `osqueryd`

---

## Documentation

- [Osquery Website](http://osquery.io/)
- [Documentation home](https://github.com/facebook/osquery/wiki)
- [GitHub Repo](https://github.com/facebook/osquery/)

---

## Additional Information

### Snapshot Bootstrap Script

This snapshot was created from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/osquery_installer.sh && bash osquery_installer.sh`

---

#### Thanks for trying osquery at Terminal.com!
