# **Webdis** Terminal.com Snapshot

*A fast HTTP interface for Redis*

---

## About Webdis

Webdis is a simple HTTP server which forwards commands to Redis and sends the reply back using a format of your choice. 
Accessing /COMMAND/arg0/arg1/.../argN[.ext] on Webdis executes the command on Redis and returns the response; the reply format can be changed with the optional extension (.json, .txt ...)

---

## Main Features

- Simple HTTP
- JSON(P) output, and other formats
- Chunked pub/sub
- Access Control by IP+mask or HTTP Auth
- And [more...](http://webd.is/#more)

---

## Usage

Just spin up a new Terminal based on this snapshot. 
Access Redis though Webdis by going to on port 7379.

Example:

```
root@ubuntu:~# curl localhost:7379/set/hello/world
→ {"set":[true,"OK"]}
root@ubuntu:~# curl localhost:7379/get/hello
→ {"get":"world"}
```

You can also access Webdis externally on http://terminalservername-7379.terminal.com

---

## Documentation

- [Webdis Website](http://webd.is/)
- [GitHub Repo](https://github.com/nicolasff/webdis)

---

### Snapshot Bootstrap Script

This snapshot was created from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/snapfiles/webdis_snapfile.sh && bash webdis_snapfile.sh

---

#### Thanks for using Webdis at Terminal.com!
