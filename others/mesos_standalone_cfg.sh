#!/bin/bash
# Script to Configure Mesos Server at Terminal.com

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