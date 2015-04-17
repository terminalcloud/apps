#!/bin/bash
# Script to deploy Mesos (Stand-Alone Version) at Terminal.com
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

INSTALL_PATH="/root"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install
	python_install

	# Procedure: 
	apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
	DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
	CODENAME=$(lsb_release -cs)
	echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | tee /etc/apt/sources.list.d/mesosphere.list
	apt-get -y update
	apt-get -y install mesos marathon

	# Install terminalcloud python utils
	pip install terminalcloud
	# reboot
}

compile(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Compilation: 
	apt-get -y install build-essential openjdk-6-jdk python-dev python-boto libcurl4-nss-dev libsasl2-dev
	apt-get -y install maven libapr1-dev libsvn-dev autoconf libtool
	git clone https://github.com/apache/mesos.git
    cd mesos
    ./bootstrap
    mkdir build
    cd build
    ../configure
    make
    make check
    make install
}

hadoop_installer(){
    apt-get install -y openjdk-7-jdk
    wget http://mirrors.nxnethosting.com/apache/hadoop/common/current/hadoop-2.6.0.tar.gz
    tar xvzf hadoop-2.6.0.tar.gz
    mv hadoop-2.6.0 /usr/local/hadoop

cat >> .bash_rc << EOF
#HADOOP VARIABLES START
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export HADOOP_INSTALL=/usr/local/hadoop
export PATH=$PATH:$HADOOP_INSTALL/bin
export PATH=$PATH:$HADOOP_INSTALL/sbin
export HADOOP_MAPRED_HOME=$HADOOP_INSTALL
export HADOOP_COMMON_HOME=$HADOOP_INSTALL
export HADOOP_HDFS_HOME=$HADOOP_INSTALL
export YARN_HOME=$HADOOP_INSTALL
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_INSTALL/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib"
#HADOOP VARIABLES END
EOF

#seguir aca

}


spark_installer(){
echo "deb http://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
apt-get update
apt-get install -y sbt build-essential openjdk-7-jdk scala

# Hadoop




wget http://d3kbcqa49mib13.cloudfront.net/spark-0.8.0-incubating.tgz
tar xzf spark-0.8.0-incubating.tgz
cd spark-0.8.0-incubating/
SPARK_HADOOP_VERSION=2.0.0-mr1-cdh4.4.0 sbt/sbt clean assembly
./make-distribution.sh --hadoop 2.0.0-mr1-cdh4.4.0
mv dist spark-0.8.0-2.0.0-mr1-cdh4.4.0
tar czf spark-0.8.0-2.0.0-mr1-cdh4.4.0.tgz spark-0.8.0-2.0.0-mr1-cdh4.4.0
hadoop fs -mkdir /tmp
hadoop fs -put spark-0.8.0-2.0.0-mr1-cdh4.4.0.tgz /tmp
cd conf/
cp spark-env.sh.template spark-env.sh
IP=$(/sbin/ifconfig $1 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}' | grep 240)
#####################################
cat > spark-env.sh << EOF
export MESOS_NATIVE_LIBRARY=/usr/local/lib/libmesos.so
export SPARK_EXECUTOR_URI=hdfs://54.204.196.36/tmp/spark-0.8.0-2.0.0-mr1-cdh4.4.0.tgz
export MASTER=zk://$IP:2181/mesos
EOF
    cd ..
    ####### SCALA? #######
    ./spark-shell


}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/mesos_standalone_hooks.sh
	mkdir -p /CL/hooks/
	mv mesos_standalone_hooks.sh /CL/hooks/startup.sh
	# Execute startup script by first to get the common files
	chmod 777 /CL/hooks/startup.sh && /CL/hooks/startup.sh
}

if [[ -z $1 ]]; then
	install && show
elif [[ $1 == "show" ]]; then 
	show
else
	echo "unknown parameter specified"
fi