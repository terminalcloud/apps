#!/bin/bash
# Script to deploy Logstash Stack at Terminal.com

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
	nginx_install

	wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
	echo 'deb http://packages.elasticsearch.org/elasticsearch/1.1/debian stable main' > /etc/apt/sources.list.d/elasticsearch.list
	apt-get update
    apt-get -y install elasticsearch=1.1.1
    service elasticsearch restart
    update-rc.d elasticsearch defaults 95 10

    /usr/share/elasticsearch/bin/plugin -install lukas-vlcek/bigdesk/2.4.0
    /usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head

    wget https://download.elasticsearch.org/kibana/kibana/kibana-3.0.1.tar.gz
    tar xvf kibana-3.0.1.tar.gz
    mkdir -p /var/www/kibana3
    cp -R ~/kibana-3.0.1/* /var/www/kibana3/
    chown -R www-data:www-data /var/www/kibana3/
    cp /var/www/kibana3/app/dashboards/logstash.json /var/www/kibana3/app/dashboards/default.json
    mkdir /etc/logstash/paterns
    cat > /etc/logstash/paterns/nginx.gok << EOF
NGINX %{IPORHOST:clientip} %{USER:ident} %{USER:auth} \[%{HTTPDATE:timestamp}\]  "(?:%{WORD:verb} %{URIPATHPARAM:request}(?: HTTP/%{NUMBER:httpversion})?|-)" %{NUMBER:response} (?:%{NUMBER:bytes}|-) "(?:%{URI:referrer}|-)" %{QS:agent} %{NUMBER:request_time} %{NUMBER:upstream_response_time} %{NUMBER:gzip_ratio} (?:%{WORD:cache_hit}|-)%{GREEDYDATA}
EOF

    cat > /etc/nginx/sites-available/default << EOF
server {
        listen 80 default_server;

        root /var/www/kibana3;
        index index.html index.htm;

        location / {
                try_files $uri $uri/ =404;
        }
        location /kibana {
                alias /var/www/kibana3/;
                try_files $uri $uri/ =404;
        }
}
EOF

    sed -i "s/elasticsearch\:.*/elasticsearch\:\ \"http\:\/\/$(hostname)-9200\.terminal\.com\"\,/g" /var/www/kibana3/config.js
    service nginx restart

    echo 'deb http://packages.elasticsearch.org/logstash/1.4/debian stable main' > /etc/apt/sources.list.d/logstash.list
    apt-get update
    apt-get install logstash=1.4.2-1-2c0f5a1
    service logstash restart

    

}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/logstash_hooks.sh
	mkdir -p /CL/hooks/
	mv logstash_hooks.sh /CL/hooks/startup.sh
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