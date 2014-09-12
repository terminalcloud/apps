#!/bin/bash
# Script to deploy a sample Django App, hosted with Apache at Terminal.com
INSTALL_PATH="/var/www"

# Includes
wget https://raw.githubusercontent.com/qmaxquique/terminal.com/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure: 
	
	# 1 - Product Installation
	python_install
	apache_install
	cd $INSTALL_PATH
	mkdir sampleapp
	cd sampleapp
	virtualenv env
	source env/bin/activate && deactivate # Test virtualenv
	env/bin/pip install django
	env/bin/django-admin.py startproject sampleapp .	
    apt-get install libapache2-mod-wsgi || yum install httpd-mod-wsgi

	cat > /etc/apache2/sites-enabled/000-default.conf << _EOF_
ServerName localhost
<VirtualHost *>
	WSGIDaemonProcess sampleapp python-path=/var/www/sampleapp:/var/www/sampleapp/env/lib/python2.7/site-packages
	WSGIProcessGroup sampleapp
	WSGIScriptAlias / /var/www/sampleapp/sampleapp/wsgi.py
	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/html
</VirtualHost>
_EOF_
	service apache2 restart
}

show(){
	wget -q https://raw.githubusercontent.com/qmaxquique/terminal.com/master/docs/django.md
	export PATH=$PATH:/srv/cloudlabs/scripts
	edit.sh django.md
	cd.sh /var/www/ ## Show the served directory
	start_hooks_install
	echo "echo 'Please wait..'" >> /CL/hooks/startup.sh
	echo "sleep 3; service apache2 restart" >> /CL/hooks/startup.sh
}

if [[ -z $1 ]]; then
	install && show
elif [[ $1 == "show" ]]; then 
	show
else
	echo "unknown parameter specified"
fi