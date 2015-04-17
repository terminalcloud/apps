#!/bin/bash
# Script to deploy Revel Framework with running examples app at Terminal.com
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


# Basic Functions
install(){
	# Includes
	wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
	source terlib.sh || (echo "cannot get the includes"; exit -1)

	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Install dependences 
	golang_install
	gvm install go1.2

	# Install Revel
	source ~/.profile
	go get github.com/revel/cmd/revel && echo "Revel was succesfully installed"
	}

show_sample(){
	revel run github.com/revel/revel/samples/chat &
	export PATH=$PATH:/srv/cloudlabs/scripts
	browse.sh http://localhost:9000
}

#Main
if [[ -z $1 ]]; then
	install && show_sample
elif [[ $1 == "show" ]]; then 
	show_sample
else
	echo "unknown parameter specified"
fi