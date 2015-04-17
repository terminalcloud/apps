#!/bin/bash
# Script to deploy FatFree CRM at Terminal.com
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

INSTALL_PATH="/root"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure: 
	ruby_install
	cd $INSTALL_PATH
	echo "source /usr/local/rvm/scripts/rvm" >> .bashrc
	git clone https://github.com/fatfreecrm/fat_free_crm.git
	# You should have the database file modified
	cp fat_free_crm/config/database.mysql.yml fat_free_crm/config/database.yml
	mysql_install
	apt-get -y install build-essential libmysqlclient-dev c
	gem install mysql2
	gem install activerecord-mysql2-adapter
	apt-get -y install libmagick++-dev libxml2 libxml2-dev libxslt1.1 libxslt1-dev libpq-dev # libyaml-de
	cd fat_free_crm
	# Modify the Gemfile to use mysql2 adapter instead of pg 
	bundle install
	rake db:create
	rake db:migrate
	rake ffcrm:setup:admin USERNAME=admin PASSWORD=t3rminal EMAIL=admin@example.com
	rake ffcrm:demo:load # Only for Demo version
	# rails server # This run from the hook script
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/fatfree_hooks.sh
	mkdir -p /CL/hooks/
	mv fatfree_hooks.sh /CL/hooks/startup.sh
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