# **HHVM** Terminal.com Snapshot

*Moving fast with high performance Hack and PHP*

---

## About HHVM

HHVM is an open-source virtual machine designed for executing programs written in Hack and PHP. 
HHVM uses a just-in-time (JIT) compilation approach to achieve superior performance while maintaining the development flexibility that PHP provides.

---

## Main Features

- The Hack Language
- JIT Compilation
- HNI
- FastCGI support
- Increasing PHP5 Parity

---

## Usage

This snap contains HHVM installed and configured with nginx server.
Just spin up a new Terminal based on this snapshot, copy your application code in */var/www/html/* and restart hhvm and nginx as follows:

```
# service hhvm restart
# service nginx stop; service nginx start

```

Logs location:

- hhvm : `/var/log/hhvm/`
- nginx: `/var/log/nginx/`

---

## Documentation

- [HHVM website](http://hhvm.com/)
- [Documentation](https://github.com/hhvm/hack-hhvm-docs)
- [GitHub Repo](https://github.com/facebook/hhvm)

---

### Snapshot Bootstrap Script

This snapshot was created from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/hhvm_installer.sh && bash hhvm_installer.sh`

---

#### Thanks for using HHVM at Terminal.com!
