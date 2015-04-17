#!/bin/bash
# Script to Configure Mesos Server at Terminal.com
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

# Server Configuration
IP=$(/sbin/ifconfig $1 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}' | grep 240)

echo "$IP" | tee /etc/mesos-master/ip
echo "zk://$IP:2181/mesos" | tee /etc/mesos/zk
echo "Mesos Standalone" | tee /etc/mesos-master/cluster
echo "$IP" | tee /etc/mesos-master/hostname
echo $IP | tee /etc/mesos-slave/ip
echo $IP | tee /etc/mesos-slave/hostname



# Restart Services
service zookeeper restart
service mesos-master restart
service marathon restart
service mesos-slave restart

echo "Configuration Done"