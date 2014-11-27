#!/bin/bash
# Script to register a client node to a terminal.com load balancer (made from the nginx load balancer snapshot)

# Check/Install dependences
which curl || apt-get -y install curl || yum -y install curl
apt-get install nfs-common || yum -y install nfs-utils

# Get command line arguments
HOST=$1
SERVERKEY=$2
PORT=$3
TRIES=$4
TIMEOUT=$5
set -x
IP=$(ip a | grep 240| awk '{print $2}' | cut -d / -f1)
# Execute registration
curl $HOST:5500/reg/"$SERVERKEY,$IP,$PORT,$TRIES,$TIMEOUT"
mkdir -p /mnt/share
sleep 2
mount $HOST:/share /mnt/share
