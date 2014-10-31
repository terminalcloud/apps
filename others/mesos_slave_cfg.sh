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

# Server Configuration
IP=$(/sbin/ifconfig $1 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}' | grep 240)

# Make sure that Master is stopped and remove ZK just in case (?)
service mesos-master stop
echo manual | tee /etc/init/mesos-master.override
echo $IP | tee /etc/mesos-slave/ip

clear
[[ -f /root/.master ]] && M_IP=$(cat /root/.master) || manual_slave

echo "zk://$M_IP:2181/mesos" | tee /etc/mesos/zk
echo $IP | tee /etc/mesos-slave/hostname
service mesos-slave restart
echo "Slave node $IP ready"

/srv/cloudlabs/scripts/display.sh /root/info.html