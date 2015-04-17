#!/bin/bash
# Script to deploy Facebook HHVM at Terminal.com
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

set -x
# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure: .
	nginx_install
	#apt-get -y install php5 php-pear php5-gd php5-mcrypt php5-curl
	composer_install
	
	cd $INSTALL_PATH
	git clone https://github.com/hhvm/hack-example-site.git
	cd hack-example-site
	composer update
	composer install

	cd $INSTALL_PATH
	wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add -
	echo deb http://dl.hhvm.com/ubuntu trusty main | sudo tee /etc/apt/sources.list.d/hhvm.list
	apt-get update
	apt-get -y install hhvm

	cd $INSTALL_PATH/hack-example-site
	cp hhvm.hdf server.hdf
	cp nginx.conf /etc/nginx/sites-available/hack-example-site
	ln -s /etc/nginx/sites-available/hack-example-site /etc/nginx/sites-enabled/hack-example-site
	#rm /etc/nginx/sites-enabled/default
	sed -i 's/\/path\/to\/site/\/root\/hack-example-site/g' /etc/nginx/sites-available/
hack-example-site 
	/usr/share/hhvm/install_fastcgi.sh
	/etc/init.d/hhvm restart
	service nginx restart
}

show(){
	wget -q https://raw.githubusercontent.com/terminalcloud/apps/master/docs/hhvm.md
	export PATH=$PATH:/srv/cloudlabs/scripts
	edit.sh hhvm.md ## Show Readme
	cd.sh $INSTALL_PATH ## Show the served directory
}

if [[ -z $1 ]]; then
	install && show
elif [[ $1 == "show" ]]; then 
	show
else
	echo "unknown parameter specified"
fi