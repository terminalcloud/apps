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

clear
echo "Now the Master Node is Configured"
echo "This is the Master Node IP: $IP"
echo "Please provide it to the Slave configuration Script" 