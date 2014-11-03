# **PostgreSQL Stack** Terminal.com Snapshot
*This PostgreSQL Snapshot offers you a complete and flexible DB server*

---

## About PostgreSQL

**PostgreSQL**, often simply "Postgres", is an object-relational database management system (ORDBMS) with an emphasis on extensibility and standards-compliance. As a database server, its primary function is to store data, securely and supporting best practices, and retrieve it later, as requested by other software applications, be it those on the same computer or those running on another computer across a network (including the Internet). It can handle workloads ranging from small single-machine applications to large Internet-facing applications with many concurrent users.

---

## Additional Tools

### PgWeb
**PgWeb** is Web-based PostgreSQL database browser written in Go. It requires a database with filled with some data to work and it will listen at port 8080 by default.

```

Usage:
  pgweb [OPTIONS]

Application Options:
  -v, --version  Print version
  -d, --debug    Enable debugging mode (false)
      --url=     Database connection string
      --host=    Server hostname or IP (localhost)
      --port=    Server port (5432)
      --user=    Database user (postgres)
      --db=      Database name (postgres)
      --ssl=     SSL option (disable)
      --listen=  HTTP server listen port (8080)

```

For Demo purposes, there is a sample database to browse with pgweb installed on this Terminal.

### PhpPGAdmin
**phpPgAdmin** is a web-based client which leverages PHP scripting and the PostgreSQL database to provide a convenient way for users to create databases, create tables, alter tables and query their own data using industry-standard SQL.

To access phpPgAdmin just click over the link provided and login with the postgress credentials.


---


### Credentials:

- username: postgres
- password: t3rminal


---

## Documentation
- [PostgreSQL Main Website](http://www.postgresql.org/)
- [PostgreSQL Manuals](http://www.postgresql.org/docs/manuals/)
- [PgWeb GitHub Repo](https://github.com/sosedoff/pgweb)
- [PhpPGAdmin Website](http://phppgadmin.sourceforge.net/doku.php)

---


### Additional Information
#### PostgreSQL Terminal.com container automatic installation:
You can replicate this container from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/postgres_installer.sh && bash postgres_installer.sh`


---

#### Thanks for using PostgreSQL at Terminal.com!