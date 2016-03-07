#!/bin/bash
# Script to deploy xguac at Terminal.com
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
    echo "ATTENTION - THIS PROCESS IS SEMI-AUTOMATIC"
    echo "YOU MIGHT NEED TO DO SOME MANUAL STUFF"
    echo ""
    echo "Press any key to continue"
    read

	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure: 
	# 1 - Get prerrequisites.
	xforwarding_setup
	xfce_install
	java7_oracle_install

	# 2 - Install the product
	useradd vnc
	echo "vnc:vnc" | chpasswd
	echo "vnc ALL=(ALL)       ALL" >> /etc/sudoers


}

show(){
pass
}

if [[ -z $1 ]]; then
	install && show
elif [[ $1 == "show" ]]; then 
	show
else
	echo "unknown parameter specified"
fi