#!/bin/bash
# Script to register a client node to a terminal.com load balancer (made from the nginx load balancer snapshot)

#Install dependences
apt-get update
apt-get -y install curl

# Get command line arguments
SERVERKEY=$1
PORT=$2
TRIES=$3
TIMEOUT=$4

IP=$(/sbin/ifconfig $1 | grep 'inet addr' | awk -F: '{print $2}' | awk '{print $1}' | grep 240)
# Execute registration
curl IP:5500/reg/$SERVERKEY,$IP,$PORT,$TRIES,$TIMEOUT