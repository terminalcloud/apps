#!/bin/bash
# Script to deploy Logstash Stack at Terminal.com
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

INSTALL_PATH="/var/www"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure:
	java7_oracle_install # this can prompt for something [not automatic step]
	apache_install
    wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
    add-apt-repository "deb http://packages.elasticsearch.org/logstash/1.4/debian stable main"
    add-apt-repository "deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main"
    apt-get update; apt-get -y install logstash logstash-contrib elasticsearch

    sed -i 's/setuid.*/setuid\ root/g' /etc/init/logstash.conf
    sed -i 's/.*LS_USER.*/LS_USER=root/g' /etc/default/logstash

    cd /var/www/html; wget https://download.elasticsearch.org/kibana/kibana/kibana-3.1.2.tar.gz
    tar -xzf kibana-3.1.2.tar.gz && mv kibana-3.1.2 kibana
    HOSTNAME=$(hostname)
    sed -i "s/\ elasticsearch\:.*/elasticsearch: \"http\:\/\/$HOSTNAME\-9200\.terminal\.com\"\,/g" /var/www/html/kibana/config.js
    echo "http.cors.enabled: true" >> /etc/elasticsearch/elasticsearch.yml
    echo "http.cors.allow-origin: \"http://$HOSTNAME-80.terminal.com\" " >> /etc/elasticsearch/elasticsearch.yml
    service logstash stop
    service elasticsearch restart
    service apache2 restart
    service logstash start
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/elk_hooks.sh
	mkdir -p /CL/hooks/
	mv elk_hooks.sh /CL/hooks/startup.sh
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