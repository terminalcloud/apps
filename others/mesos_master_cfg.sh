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

wget https://raw.githubusercontent.com/terminalcloud/terminal-tools/master/script-terminals.py
chmod +x script-terminals.py
# apt-get update; apt-get -y install python-pip; pip install terminalcloud

export PATH=$PATH:/srv/cloudlabs/scripts

# Server Configuration
IP=$(/sbin/ifconfig $1 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}' | grep 240)

# Make sure that slave is stopped
service mesos-slave stop
echo manual | tee /etc/init/mesos-slave.override
echo "$IP" | tee /etc/mesos-master/ip
echo "zk://$IP:2181/mesos" | tee /etc/mesos/zk
clear
echo "Enter a Name for your cluster and press enter:"
read cl_name
echo $cl_name | tee /etc/mesos-master/cluster
echo "$IP" | tee /etc/mesos-master/hostname

# Restart Services
service zookeeper restart
service mesos-master restart
service marathon restart

# Setting Zookeeper Node ID [Simple Cluster with 1 ZK service]
echo 1 | tee /etc/zookeeper/conf/myid

# Functions

auto_slave(){
	cd /root
	# Get Slave SID and 
	sid=264be895334c010804e5c9179f6b856e4af19f1e68ec982be49177ebcc645b02 # Slave Snap Sid
    wget https://raw.githubusercontent.com/terminalcloud/terminal-tools/master/script_terminals.py
    chmod +x script_terminals.py
	clear
	echo 'How many slaves do you want to create? (each slave is a new Terminal)'
	read num

	echo 'What kind of slaves do you want to create?'
	echo '"1" for Small [1CPU] [1.6Gb RAM]'
	echo '"2" for Medium [2CPU] [3.2Gb RAM]'
	echo '"3" for xLarge [4CPU] [6.4Gb RAM]'
	read kind
	case $kind in 
		1) kind="small" ;;
		2) kind="medium" ;;
		3) kind="xlarge" ;;
		*) echo "Invalid option, assuming Small"; kind="small" ;;
	esac

	/usr/bin/bash /srv/cloudlabs/scripts/browse.sh https://www.terminal.com/settings/api
	echo 'Please copy your API User token, paste it below and press enter:'
	read utoken
	echo 'Please copy your API Access token, paste it below and press enter: (if it does not exist please generate it)'
	read atoken
	echo 'Trying to generate the Mesos Slaves at Terminal.com with the given tokens'

    # Create slave configurator script
    cat > slave.sh << EOF
echo "$IP" > /root/.master
EOF

    # Create the slave servers
    ./script-terminals.py $num -b $sid -m startup_key -x slave.sh -u $utoken -a $atoken -s $kind -n $cl_name -p "*" -t multi
    clear
   	echo "if you want to add more slaves to this cluster in the future, start a new Mesos Slave Snapshot, link it with this Master \
   	node and and provide this IP address: $IP"
   }


manual_slave(){
	clear
	echo "Now the Master Node is Configured"
	echo "This is the Master Node IP: $IP"
	echo "Please provide it to the Slave configuration Script"
}

echo "Do you want to create the slaves now (y/N)?"
read n
case $n in
    y) auto_slave;;
    n) manual_slave;;
    *) echo "Invalid option, assuming NO" && manual_slave;;
esac


# Open the info page
/usr/bin/bash /srv/cloudlabs/scripts/display.sh /root/info.html