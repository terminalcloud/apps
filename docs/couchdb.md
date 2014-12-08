# **CouchDB** Terminal.com Snapshot

*Apache CouchDB™ is a database that uses JSON for documents, JavaScript for MapReduce indexes, and regular HTTP for its API*

---

## About CouchDB

**CouchDB** is a database that completely embraces the web. Store your data with JSON documents. Access your documents and query your indexes with your web browser, via HTTP. Index, combine, and transform your documents with JavaScript. CouchDB works well with modern web and mobile apps. You can even serve web apps directly out of CouchDB. And you can distribute your data, or your apps, efficiently using CouchDB’s incremental replication. CouchDB supports master-master setups with automatic conflict detection.

CouchDB is often categorized as a “NoSQL” database, a term that became increasingly popular in late 2009, and early 2010. While this term is a rather generic characterization of a database, or data store, it does clearly define a break from traditional SQL-based databases. A CouchDB database lacks a schema, or rigid pre-defined data structures such as tables. Data stored in CouchDB is a JSON document(s). The structure of the data, or document(s), can change dynamically to accommodate evolving needs.

---

## Usage

Just spin up a new Terminal based on this snapshot. Access the admin section by clicking to "Web administration console" and login with the credentials provided (look for "login" in the lower right corner of the web administration console).

### Credentials

- username: `admin`
- password: `t3rminal`

---

![1](http://docs.couchdb.org/en/latest/_images/futon-createdb.png)

---

## Documentation

- [CouchDB website](http://couchdb.apache.org/)
- [Documentation home](http://docs.couchdb.org/en/1.6.1/)
- [CouchDB 15' guide](https://wiki.apache.org/couchdb/CouchIn15Minutes)
- [Blog](http://blog.couchdb.org/)

---

### Snapshot Bootstrap Script

This snapshot was created from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/couchdb_installer.sh && bash couchdb_installer.sh`

---

#### Thanks for using CouchDB at Terminal.com!
