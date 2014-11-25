#!/bin/bash
# Script to Configure a Nginx Load balancer at Terminal.com

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

export PATH=$PATH:/srv/cloudlabs/scripts

# Server Configuration
IP=$(/sbin/ifconfig $1 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}' | grep 240)
KEY_file="/opt/loadbalancer/etc/server.key"
SERVERKEY=$(date | md5sum | cut -d " " -f1)
[ ! -f "KEY_file" ] && echo $SERVERKEY > "$KEY_file"

# Stacks
UBUNTU="264be895334c010804e5c9179f6b856e4af19f1e68ec982be49177ebcc645b02"
CENTOS="264be895334c010804e5c9179f6b856e4af19f1e68ec982be49177ebcc645b02"
PHP="264be895334c010804e5c9179f6b856e4af19f1e68ec982be49177ebcc645b02"
NODEJS="264be895334c010804e5c9179f6b856e4af19f1e68ec982be49177ebcc645b02"
RUBY="264be895334c010804e5c9179f6b856e4af19f1e68ec982be49177ebcc645b02"
DJANGO="264be895334c010804e5c9179f6b856e4af19f1e68ec982be49177ebcc645b02"

# DBs
MYSQL="264be895334c010804e5c9179f6b856e4af19f1e68ec982be49177ebcc645b02"
MYSQLC="264be895334c010804e5c9179f6b856e4af19f1e68ec982be49177ebcc645b02"
MONGODB="264be895334c010804e5c9179f6b856e4af19f1e68ec982be49177ebcc645b02"



select_sid(){
  cd /root
  wget https://raw.githubusercontent.com/terminalcloud/apps/master/others/lb_stack.json
  clear
  echo 'Please select the basic image for your application'
  '"1" for Ubuntu Basic Image'
  '"2" for CentOS Basic Image'
  '"3" for PHP and Apache on Ubuntu'
  '"4" for Node.js on Ubuntu'
  '"5" for Ruby on Rails on Ubuntu'
  '"6" for DJANGO Stack on Ubuntu'
  '"0" OTHER - Enter your snapshot ID'
  read option
  case $option in
    1) sed -i "s/sid/$UBUNTU/g" lb_stack.json ;;
    2) sed -i "s/sid/$CENTOS/g" lb_stack.json ;;
    3) sed -i "s/sid/$PHP/g" lb_stack.json ;;
    4) sed -i "s/sid/$NODEJS/g" lb_stack.json ;;
    5) sed -i "s/sid/$RUBY/g" lb_stack.json ;;
    6) sed -i "s/sid/$DJANGO/g" lb_stack.json ;;
    0) custom_sid ;;
    *) echo "Invalid option, assuming 1, Ubuntu basic Image"; sed -i "s/sid/$UBUNTU/g" lb_stack.json ;;
  esac
}

select_number(){
  echo 'How many slaves do you want to create? (each slave is a new Terminal)'
  read num

  echo 'What kind of slaves do you want to create?'
  echo '"1" for Small [1CPU] [1.6Gb RAM]'
  echo '"2" for Medium [2CPU] [3.2Gb RAM]'
  echo '"3" for xLarge [4CPU] [6.4Gb RAM]'
  read kind
  case $kind in
    1) sed -i "s/cpuq/100/g" lb_stack.json && sed -i "s/ramq/1600/g" lb_stack.json ;;
    2) sed -i "s/cpuq/200/g" lb_stack.json && sed -i "s/ramq/3200/g" lb_stack.json ;;
    3) sed -i "s/cpuq/400/g" lb_stack.json && sed -i "s/ramq/6400/g" lb_stack.json ;;
    *) echo "Invalid option, assuming Small"; sed -i "s/cpuq/100/g" lb_stack.json && sed -i "s/ramq/1600/g" lb_stack.json ;;
  esac
}

get_tokens(){
  /srv/cloudlabs/scripts/browse.sh https://www.terminal.com/settings/api
  echo 'Please copy your API User token, paste it below and press enter:'
  read utoken
  echo 'Please copy your API Access token, paste it below and press enter: (if it does not exist please generate it)'
  read atoken
  echo 'Trying to generate your application servers'

  sed -i "s/utoken/$utoken/g" lb_stack.json
  sed -i "s/atoken/$atoken/g" lb_stack.json
  sed -i "s/sid/$sid/g" lb_stack.json
  sed -i "s/IP/$IP/g" lb_stack.json
}

create_nodes(){
    for ((i=1;i<=$num;i++));
    do
      curl -L -X POST -H 'Content-Type: application/json' -d @lb_stack.json api.terminal.com/v0.1/start_snapshot
      echo "Starting application server $i ..."
      sleep 2
    done

    clear
    echo "if you want to add more application servers in the future, you can register them against this load balancer by executing:"
    echo "curl $IP:5500/$SERVERKEY,application_ip,application_port,load_balancer_retries,load_balancer_timeout"
   }

custom_sid(){
  echo "Please provide the snapshot ID to be used as application server image, based on the snapshot URL"
  echo "For instance, the Ubuntu snapshot URL is: https://www.terminal.com/snapshot/987f8d702dc0a6e8158b48ccd3dec24f819a7ccb2756c396ef1fd7f5b34b7980"
  echo "and the snapshot ID is 987f8d702dc0a6e8158b48ccd3dec24f819a7ccb2756c396ef1fd7f5b34b7980"
  echo ""
  echo "Enter the snapshot ID and press \"enter\""
  read sid
  sed -i "s/sid/$sid/g" lb_stack.json ;;
}


config_curl(){
  echo "pass"
}


manual_slave(){
	clear
	echo "You've selected to create your application nodes manually "
	echo "You can register your web application server against this load balancer by executing:"
  echo "curl $IP:5500/$SERVERKEY,application_ip,application_port,load_balancer_retries,load_balancer_timeout"
}

select_db(){
  rm lb_stack.json
  wget https://raw.githubusercontent.com/terminalcloud/apps/master/others/lb_stack.json
  echo "Select the DB server flavor"
  '"1" for MySQL on Ubuntu'
  '"2" for MySQL on CentOS'
  '"3" for MongoDB on Ubuntu'
  read option
  case $option in
    1) sed -i "s/sid/$MYSQL/g" lb_stack.json ;;
    2) sed -i "s/sid/$MYSQLC/g" lb_stack.json ;;
    3) sed -i "s/sid/$MONGODB/g" lb_stack.json ;;
    *) echo "Invalid option, assuming 1, MySQL on Ubuntu"; sed -i "s/sid/$MYSQL/g" lb_stack.json ;;
  esac
}


clear
echo "Do you want to create the your application Terminals now (y/N)?"
read n
case $n in
    y) auto_slave;;
    n) manual_slave;;
    *) echo "Invalid option, assuming NO" && manual_slave;;
esac


# Open the info page
/srv/cloudlabs/scripts/display.sh /root/info.html

# Delete tokens
rm /root/tokens.json
