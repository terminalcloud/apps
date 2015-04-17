#!/bin/bash
# Script to deploy Padrino at Terminal.com
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

	# Backend:
	cd $INSTALL_PATH
	gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
	curl -L get.rvm.io | bash -s stable # Requires Basics
	source /usr/local/rvm/scripts/rvm
	echo "source /usr/local/rvm/scripts/rvm" >> .bashrc
	rvm install 2.1.2
  rvm docs generate-ri
	rvm use 2.1.2
	rvm rubygems current
	source .bashrc
  gem install padrino
  padrino g project myapp -d datamapper -b
  cd myapp
  padrino g admin
  padrino rake dm:migrate seed
  #padrino start
}



show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/padrino_hooks.sh
	mkdir -p /CL/hooks/
	mv padrino_hooks.sh /CL/hooks/startup.sh
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
