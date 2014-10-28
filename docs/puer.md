# **Puer** Terminal.com Snapshot
*More than a live-reload server , built for efficient frontend development*

---

## About Puer

**Puer** is a [socket.io](http://socket.io/) based live-reload server with special features that will help you with front-end develpment tasks. 

---

## Features
1. __create static server__ at target dir (default in current dir)
2. __auto reload__ : editing css will update styles only, other files will reload the whole page.
3. __weinre integrated__  use `-i` options
4. __proxy server mode__, use it with an existing server
5. __http request mock__ by `-a` addon，the addon is also __live reloaded__
6. __connect-middleware__ support



##Usage

###Command line

in most cases...

```
cd path/to/your/static/dir && puer --no-launch

```
*Note the --no-launch option to work in a terminal. By default Puer will be litening at port 3000*

To list all of puer's options use `puer -h`
For use case examples please check the [Puer GitHub Repo](https://github.com/leeluolee/puer)


![puer-step-1](http://leeluolee.github.io/attach/2014-10/puer-step-1.gif)

**Puer will refresh the browser for you. All pages will reload when you edit them.**


---

## Documentation
- [Puer GitHub Repo](https://github.com/leeluolee/puer)

---


### Additional Information
#### PostgreSQL Terminal.com container automatic installation:
You can replicate this container from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/puer_installer.sh && bash puer_installer.sh`


---

#### Thanks for using Puer at Terminal.com!