# **iPython Notebook 4 (Jupyter)** Terminal.com Snapshot

*Web-based application for authoring documents that combine live-code with narrative text, equations and visualizations.*

---

## About iPython Notebook 4 (Jupyter Notebook)

The Jupyter Notebook is a web application for interactive data science and scientific computing. It allows users to 
author documents that combine live-code with narrative text, equations, images, video and visualizations. These 
documents encode a complete and reproducible record of a computation that can be shared with others on GitHub, 
Dropbox and the Jupyter Notebook Viewer.

**Kernels**

Kernels are separate processes that sit behind the Jupyter user interfaces and run code in a particular programming language.

IPython is the reference Jupyter kernel, providing a powerful environment for interactive computing in Python.

See Also: [A full list of kernels available for other languages](https://github.com/ipython/ipython/wiki/IPython-kernels-for-other-languages)



---

## Usage

Just spin up a new Terminal based on this snapshot. Access the iPython Notebook interface (now called Jupyter) by cliking on
[Access Jupyter Here!](https://$(hostname)-8080.terminal.com)

The Jupyter service will be running by default, but in case you need to stop/restart it we provide an Upstart script that can
be used with the `service` command:

Examples:

```
service jupyter start
jupyter start/running, process 13950
```

```
service jupyter restart
jupyter stop/waiting
jupyter start/running, process 13971
```

```
service jupyter stop
jupyter stop/waiting
```

Jupyter will be running by default on port 8080. This and other settings can be changed at `/root/.ipython/profile_nbserver/ipython_config.py`



---

![1](http://i.imgur.com/B3VYPI2.png)

---

## Documentation

- [Jupyter project website](https://jupyter.org/)
- [Documentation](https://jupyter.readthedocs.org/en/latest/)
- [Project Jupyter Blog](https://blog.jupyter.org/)
- [iPython home site](http://ipython.org/)

---

### Snapshot Bootstrap Script

This snapshot was created from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/ipython-ntb4_installer.sh && bash ipython-ntb4_installer.sh`

---

#### Thanks for using iPython Notebook at Terminal.com!