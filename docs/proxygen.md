# **Proxygen** Terminal.com Snapshot
*A collection of C++ HTTP libraries including an easy to use HTTP server.*

---

## Proxygen: Facebook's C++ HTTP Libraries

This project comprises the core C++ HTTP abstractions used at Facebook. Internally, it is used as the basis for building many HTTP servers, proxies, and clients. This release focuses on the common HTTP abstractions and our simple HTTPServer framework. Future releases will provide simple client APIs as well. The framework supports HTTP/1.1, SPDY/3, and SPDY/3.1. HTTP/2 support is in progress. The goal is to provide a simple, performant, and modern C++ HTTP library.

---

## Snapshot Contents

The Proxygen libraries are instaled on the system, but we also provide the contents of the project repository cloned in the `/root/proxygen` directory, containing:

* `proxygen/external/` Contains non-installed 3rd-party code proxygen depends on.
* `proxygen/lib/` Core networking abstractions.
* `proxygen/lib/http/` HTTP specific code.
* `proxygen/lib/services/` Connection management and server code.
* `proxygen/lib/ssl/` TLS abstractions and OpenSSL wrappers.
* `proxygen/lib/utils/` Miscellaneous helper code.
* `proxygen/httpserver/` Contains code wrapping `proxygen/lib/` for building simple C++ http servers. We recommend building on top of these APIs.

---

## Usage

Spin up your Terminal based on this snapshot to have a system ready to start working with the libraries.
You can use our IDE to play with the sample (currently running on the Terminal), develop your own project and also test it directly on the Terminal.


---

## Documentation

- [Proxygen project announcement](https://code.facebook.com/posts/1503205539947302/introducing-proxygen-facebook-s-c-http-framework/)
- [GitHub repository](https://github.com/facebook/proxygen)
- [General discussion group](https://groups.google.com/d/forum/facebook-proxygen)


---

### Snapshot Bootstrap Script

This snapshot was created from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/Proxygen_installer.sh && bash Proxygen_installer.sh`

---

#### Thanks for using Proxygen at Terminal.com!
