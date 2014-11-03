#!/bin/bash
# Script to Configure Mesos Server at Terminal.com

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

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
	wget https://raw.githubusercontent.com/terminalcloud/apps/master/others/mesos_slave.json
	

	clear
	echo 'How many slaves do you want to create? (each slave is a new Terminal)'
	read num

	echo 'What kind of slaves do you want to create?'
	echo '\"1\" for Small [1CPU] [1.6Gb RAM]'
	echo '\"2\" for Medium [2CPU] [3.2Gb RAM]'
	echo '\"3\" for xLarge [4CPU] [6.4Gb RAM]'
	read kind
	case $kind in 
		1) sed -i "s/cpuq/100/g" mesos_slave.json && sed -i "s/ramq/1600/g" mesos_slave.json ;;
		2) sed -i "s/cpuq/200/g" mesos_slave.json && sed -i "s/ramq/3200/g" mesos_slave.json ;;
		3) sed -i "s/cpuq/400/g" mesos_slave.json && sed -i "s/ramq/6400/g" mesos_slave.json ;;
		*) echo "Invalid option, assuming Small"; sed -i "s/cpuq/100/g" mesos_slave.json && sed -i "s/ramq/1600/g" mesos_slave.json ;;
	esac

	/srv/cloudlabs/scripts/browse.sh https://www.terminal.com/settings/api
	echo 'Please copy your API User token, paste it below and press enter:'
	read utoken
	echo 'Please copy your API Access token, paste it below and press enter: (if it does not exist please generate it)'
	read atoken
	echo 'Trying to generate the Mesos Slaves at Terminal.com with the given tokens'

	sed -i "s/utoken/$utoken/g" mesos_slave.json
	sed -i "s/atoken/$atoken/g" mesos_slave.json
	sed -i "s/sid/$sid/g" mesos_slave.json
	sed -i "s/IP/$IP/g" mesos_slave.json

	for ((i=1;i<=$num;i++));
		do 
	    curl -L -X POST -H 'Content-Type: application/json' -d @mesos_slave.json api.terminal.com/v0.1/start_snapshot
	    echo "Starting Slave $i ..."
	    sleep 2
    done

   	clear
   	echo "if you want to add more slaves to this cluster in the future, just start a new Mesos Slave Snapshot and provide this IP address: $IP"
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
/srv/cloudlabs/scripts/display.sh /root/info.html

# Delete tokens
rm /root/mesos_slave.json