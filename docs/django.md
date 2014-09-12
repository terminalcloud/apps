# **Django Applications Server** Terminal.com Snapshot

## About **Django**

Django is a high-level Python Web framework that encourages rapid development and clean, pragmatic design.

Developed by a fast-moving online-news operation, Django was designed to handle two challenges: the intensive deadlines of a newsroom and the stringent requirements of the experienced Web developers who wrote it. It lets you build high-performing, elegant Web applications quickly.


## Usage:
Just spin up you terminal.com container based on this snapshot and you will have everything needed to develop, deploy and serve Django applications. 

This container has Apache web server installed, serving a sample Django App that can be the base for you new project.

To write you own application just go to the installation directory at /var/www/sampleapp and use it as a base.
You can also use virtualenv (also includded) to install Django in another directory and then change the Apache settings to serve it as well.

This container has **mod_wsgi** for Apache. You can used to host your previously developed application as well, using as example the configuration files provided.


## Documentation and resources
- Django [Official Webpage](https://www.djangoproject.com/)
- Django (current version installed) [Official Documentation](https://docs.djangoproject.com/en/1.7/)
- [Weblog](https://www.djangoproject.com/weblog/)


### Additional Information
#### Terminal.com container automatic installation
You can replicate this container from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing

`wget https://raw.githubusercontent.com/terminalcloud/apps/master/django_server_install.sh &&  bash django_server_install.sh`

---

#### Thanks for hosting you Django app at Terminal.com!