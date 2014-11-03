# **Wide** Terminal.com Snapshot
*A Web IDE for Teams using Golang.*

---

## About Wide
**Wide** is an open source Web IDE for teams using Golang.

A Product Information Management tool (also known as PIM, PCM or Products MDM) is intended to help merchants to centralize and harmonize all the technical and marketing information of their catalogs and products.


## Motivation

* **Team** IDE:
  * Safe and reliable: the project source code stored on the server in real time, the developer's machine crashes without losing any source code
  * Unified environment: server unified development environment configuration, the developer machine without any additional configuration
  * Out of the box: 5 minutes to setup a server then open browser to develop, debug
  * Version Control: each developer has its own source code repository, easy sync with the trunk
* **Web based** IDE:
  * Developer needs a browser only
  * Cross-platform, even on mobile devices
  * Easy for extensions
  * Easy integration with other systems
  * For the geeks
* A try for commercial-open source: versions customized for enterprises, close to their development work flows respectively
* Currently more popular Go IDE has some defects or regrets:
  * Text editor (vim/emacs/sublime/Atom, etc.): For the Go newbie is too complex
  * Plug-in (goclipse, etc.): the need for the original IDE support, not professional
  * LiteIDE: no modern user interface :p
  * No team development experience
* There are a few of GO IDEs, and no one developed by Go itself, this is a nice try



## Key Features

* Code Highlight, Folding: Go/HTML/JavaScript/Markdown etc.
* Autocomplete: Go/HTML etc.
* Format: Go/HTML/JSON etc.
* Run & Debug: run/debug multiple processes at the same time
* Multiplayer: a real team development experience
* Navigation, Jump to declaration, Find usages, File search etc.
* Shell: run command on the server
* Git integration: git command on the web
* Web development: Frontend devlopment (HTML/JS/CSS) all in one
* Go tool: go get/install/fmt etc.



---

## Usage

Just spin-up your container based on this snapshot and click to "Check your installation here".
Login with your admin credentials and start using Wide.


### Credentials:

- username: admin
- password: t3rminal


---

![1](https://camo.githubusercontent.com/56436ce77d8960bc578ee044480559c50791f44b/687474703a2f2f62336c6f672e6f72672f776964652f64656d6f2f32303134313032342e706e67)

---

## Documentation
- [GitHub Repo](https://github.com/b3log/wide)

---

### Additional Information

#### Wide Terminal.com container automatic installation:
You can replicate this container from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/wide_installer.sh && bash wide_installer.sh show`

---

#### Thanks for using Wide at Terminal.com!
