#!/bin/bash
# Script to deploy Church.IO PM at Terminal.com
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

INSTALL_PATH="/var/www"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure: 
	apache_install
	mysql_install
	apt-get -y install build-essential libreadline-dev libcurl4-openssl-dev nodejs libmysqlclient-dev software-properties-common
	apt-get -y install libaprutil1-dev libapr1-dev apache2-threaded-dev libapache2-mod-xsendfile imagemagick
	apt-add-repository -y ppa:brightbox/ruby-ng
	apt-get update
	apt-get install -y ruby2.1 ruby2.1-dev
	cd $INSTALL_PATH
	git clone git://github.com/churchio/onebody.git
	cd onebody
	git checkout 3.2.0
	mkdir -p tmp/pids log public/system
	chmod -R 777 tmp log public/system
	mysql -u root -proot -e "create database onebody default character set utf8 default collate utf8_general_ci; grant all on onebody.* to onebody@localhost identified by 'onebody';"
	cp config/database.yml{.example,}
	gem install bundler
	bundle install --deployment
	cp config/secrets.yml{.example,}
	vi config/secrets.yml
	#change salt value
	RAILS_ENV=production bundle exec rake db:migrate db:seed
	RAILS_ENV=production bundle exec rake assets:precompile
	apt-get update
	apt-get install libapache2-mod-passenger
	a2enmod passenger
	a2enmod xsendfile
	apache_default_vhost onebody.conf /var/www/onebody/public
	vi /etc/apache2/sites-available/onebody.conf
	#XSendFile On
	#XSendFilePath /var/www/onebody/public/system
	service apache2 restart
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/churchio_hooks.sh
	mkdir -p /CL/hooks/
	mv churchio_hooks.sh /CL/hooks/startup.sh
	# Execute startup script by first to get the common files
	chmod 777 /CL/hooks/startup.sh && /CL/hooks/startup.sh
}

if [[ -z $1 ]]; then
	install && show
elif [[ $1 == "show" ]]; then 
	show
else
	echo "unknown parameter specified"
fi