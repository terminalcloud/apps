# **Cloud9** Terminal.com Snapshot
*Your development environment, in the cloud*

---

## About Cloud9
**Cloud9** is an open source IDE built with Node.JS on the back-end and JavaScript/HTML5 on the client. It is very actively maintained by about 20 developers in both Amsterdam and San Francisco and is one component of the hosted service at [c9.io](http://c9.io).


### Features
- High performance ACE text editor with bundled syntax highlighting support for JS, HTML, CSS and mixed modes.

- Integrated debugger for [Node.JS](http://nodejs.org/) applications with views of the call stack, variables, live code execution and live inspector

- Advanced Javascript language analysis marking unused variables, globals, syntax errors and allowing for variable rename.

- Local filesystem is exposed through [WebDAV](http://en.wikipedia.org/wiki/WebDAV) to the IDE, which makes it possible to connect to remote workspaces as well.

- Highly extensible through both client-side and server-side plugins.

- Sophisticated process management on the server with evented messaging.

---

![1](https://d6ff1xmuve0sx.cloudfront.net/nc-3.0.305-f90fcd9e/static/homepage/images/c9-web/top-carrousel-1.png)

---

## Usage
Spin up your terminal container based on this snapshot using Cloud9 by clicking on "Check your installation here". 


####Please login to Cloud9 using the credentials below:

- Username: user
- Password: terminal


Cloud9 runs using "forever". If you want to stop, retart or start Cloud9 with other settings you can just kill the "forever" process and then restart it with other options. As an example, the current process run as follows:
`forever start /root/cloud9/server.js -w /root -l 0.0.0.0 --username user --password terminal`


## Documentation
- [Official C9 Website](https://c9.io/)
- [C9 IDE Github repository](https://github.com/ajaxorg/cloud9)
- [Cloud9 Blog](https://c9.io/site/blog)



---

### Additional Information
#### Cloud9 Terminal.com container automatic installation:
You can replicate this container from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/cloud9_installer.sh && bash cloud9_installer.sh`

Use at least a "small" Terminal container to host this application. 

---

#### Thanks for using Cloud9 at Terminal.com!