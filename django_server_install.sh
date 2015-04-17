#!/bin/bash
# Script to deploy a sample Django App, hosted with Apache at Terminal.com
# Cloudlabs, INC. Copyright (C) 2015
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# Cloudlabs, INC. - 653 Harrison St, San Francisco, CA 94107.
# http://www.terminal.com - help@terminal.com


# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
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
	wget -q https://raw.githubusercontent.com/terminalcloud/apps/master/docs/django.md
	export PATH=$PATH:/srv/cloudlabs/scripts
	edit.sh django.md
	cd.sh /var/www/ ## Show the served directory
	start_hooks_install
	echo "echo 'Please wait..'" >> /CL/hooks/startup.sh
	echo "sleep 3; service apache2 restart" >> /CL/hooks/startup.sh
	echo "press any key to continue"
	read; 
	echo "please wait.."
	sleep 10
	service apache2 restart
	echo "terminal ready to use"
}

if [[ -z $1 ]]; then
	install && show
elif [[ $1 == "show" ]]; then 
	show
else
	echo "unknown parameter specified"
fi