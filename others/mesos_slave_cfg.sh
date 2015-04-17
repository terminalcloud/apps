#!/bin/bash
# Script to Configure a Mesos Slave server at Terminal.com
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

export PATH=$PATH:/srv/cloudlabs/scripts

# Functions
manual_slave(){
	echo "Enter the Master node IP address and press enter:"
	read M_IP
}

manual_reboot(){
	echo "Do you want to reboot it now? (y/n)"
	read n
	case $n in
	    y) init 6;;
	    n) echo "OK";;
	    *) echo "Invalid option, assuming NO";;
	esac
}


# Server Configuration
IP=$(/sbin/ifconfig $1 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}' | grep 240)

# Make sure that Master is stopped and remove ZK just in case (?)
service mesos-master stop
service mesos-slave stop
service marathon stop
echo manual | tee /etc/init/mesos-master.override
echo $IP | tee /etc/mesos-slave/ip

clear
[[ -f /root/.master ]] && M_IP=$(cat /root/.master) || manual_slave

echo "zk://$M_IP:2181/mesos" | tee /etc/mesos/zk
echo $IP | tee /etc/mesos-slave/hostname
service mesos-slave start
service marathon start

echo "Slave node $IP ready"
echo "We suggest to restart this Terminal to ensure the node configuration is applied"
[[ -f /root/.master ]] && init 6 || manual_reboot