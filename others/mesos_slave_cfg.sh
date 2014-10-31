#!/bin/bash
# Script to Configure a Mesos Slave server at Terminal.com

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
	echo "Do you want to reboot it now?"
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


/srv/cloudlabs/scripts/display.sh /root/info.html