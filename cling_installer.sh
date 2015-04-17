#!/bin/bash
# Script to deploy CLING at Terminal.com
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
	[[ -f /etc/debian_version ]] && apt-get -y install gcc g++ || yum -y install gcc g++
	wget https://ecsft.cern.ch/dist/cling/current/cling-Ubuntu-14.04-64bit-b714047cbb.tar.bz2
	tar jfxv cling-Ubuntu-14.04-64bit-b714047cbb.tar.bz2
	mv cling-Ubuntu-14.04-64bit-b714047cbb cling
	echo "PATH=$PATH:/root/cling/bin" >> .profile
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/cling_hooks.sh
	mkdir -p /CL/hooks/
	mv cling_hooks.sh /CL/hooks/startup.sh
	# Execute startup script by first to get the common files
	clear
	echo "PRESS ENTER TO START CLING"
	chmod 777 /CL/hooks/startup.sh && /CL/hooks/startup.sh
	source .profile
	clear
	cling
}

if [[ -z $1 ]]; then
	install && show
elif [[ $1 == "show" ]]; then 
	show
else
	echo "unknown parameter specified"
fi