#!/bin/bash
# Script to Configure a Nginx Load balancer at Terminal.com with automatic app servers generation

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

export PATH=$PATH:/srv/cloudlabs/scripts


# Server Configuration
IP="$(/sbin/ifconfig $1 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}' | grep 240)"
wget https://raw.githubusercontent.com/terminalcloud/apps/master/others/lb_stack.json
WORKDIR='/root'

# KEY_file (used as LB identification)
KEY_file='/opt/loadbalancer/etc/server.key'
SERVERKEY="$(date | md5sum | cut -d " " -f1)"
[ ! -f "KEY_file" ] && echo $SERVERKEY > "$KEY_file"

# Set defaults
PORT='80'
TRIES='3'
TIMEOUT='60'

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

# Functions

select_sid(){
  echo 'Please select the basic image for your application'
  '"1" for Ubuntu Basic Image'
  '"2" for CentOS Basic Image'
  '"3" for PHP and Apache on Ubuntu'
  '"4" for Node.js on Ubuntu'
  '"5" for Ruby on Rails on Ubuntu'
  '"6" for DJANGO Stack on Ubuntu'
  '"0" OTHER - You have to Enter your snapshot ID'
  read -p '> ' option
  case $option in
    1) sid = "$UBUNTU" && PORT='80' ;;
    2) sid = "$CENTOS" && PORT='80' ;;
    3) sid = "$PHP"  && PORT='80' ;;
    4) sid = "$NODEJS" && PORT='3000' ;;
    5) sid = "$RUBY" && PORT='8000' ;;
    6) sid = "$DJANGO" && PORT='3000' ;;
    0) custom_sid ;;
    *) echo "Invalid option, assuming 1, Ubuntu basic Image"; sid = "$UBUNTU" && PORT='80' ;;
  esac
}

select_number(){
  read -p 'How many servers do you want to create? (each server is a new Terminal): ' num
}

select_size(){
  echo 'Select the size of your server/s'
  echo '"1" for Small [1CPU] [1.6Gb RAM]'
  echo '"2" for Medium [2CPU] [3.2Gb RAM]'
  echo '"3" for xLarge [4CPU] [6.4Gb RAM]'
  read -p '> ' kind
  case $kind in
    1) cpuq = '100' && ramq = '1600' ;;
    2) cpuq = '200' && ramq = '3200' ;;
    3) cpuq = '400' && ramq = '6400' ;;
    *) echo "Invalid option, assuming Small"; cpuq = '100' && ramq = '1600' ;;
  esac
}

get_tokens(){
  /srv/cloudlabs/scripts/browse.sh https://www.terminal.com/settings/api
  read -p  'Please copy your API User token, paste it here and press enter: ' utoken
  read -p  'Please copy your API Access token, paste it here and press enter: (if it does not exist please generate it)' atoken
}

lb_questions(){
  read -p "Enter the application port number [Default=$PORT]" port ; port=${port:-$PORT}; PORT=port
  read -p "Enter the application Max Retries [Default=$TRIES] " tries ; tries=${tries:-$TRIES}; TRIES=tries
  read -p "Enter the application Timeout [Default=$TIMEOUT seconds] " timeout ; timeout=${timeout:-$TIMEOUT}; TIMEOUT=timeout
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
  read -p "Enter the snapshot ID: " sid
}


select_db(){
  rm lb_stack.json
  wget https://raw.githubusercontent.com/terminalcloud/apps/master/others/lb_stack.json
  echo "Select the DB server flavor"
  '"1" for MySQL on Ubuntu'
  '"2" for MySQL on CentOS'
  '"3" for MongoDB on Ubuntu'
  read -p '> ' option
  case $option in
    1) sid = "$MYSQL" ;;
    2) sid = "$MYSQLC" ;;
    3) sid = "$MONGODB" ;;
    *) echo "Invalid option, assuming 1, MySQL on Ubuntu"; sid = "$MYSQL" ;;
  esac
}

config_json(){
  sed -i "s/utoken/$utoken/g" lb_stack.json
  sed -i "s/atoken/$atoken/g" lb_stack.json
  sed -i "s/sid/$sid/g" lb_stack.json
  sed -i "s/cpuq/$cupq/g" lb_stack.json
  sed -i "s/ramq/$ramq/g" lb_stack.json
  sed -i "s/IP/$IP/g" lb_stack.json
  sed -i "s/SERVERKEY/$SERVERKEY/g" lb_stack.json
  sed -i "s/PORT/$PORT/g" lb_stack.json
  sed -i "s/TRIES/$TRIES/g" lb_stack.json
  sed -i "s/TIMEOUT/$TIMEOUT/g" lb_stack.json
}

# Main Functions

auto_proc(){
  select_sid
  select_number
  select_size
  get_tokens
  lb_questions
  config_json
  create_nodes
  read -p "Do you want to create DB servers? [y/N]: " db ; db=${db:-"n"};
  if ["$db" == "y"]; then
    select_db
    select_number
    select_size
    config_json
    create_nodes
  fi
}



manual_proc(){
  clear
  echo "You've selected to create your application nodes manually "
  echo "You can register your web application server against this load balancer by executing:"
  echo "curl $IP:5500/$SERVERKEY,application_ip,application_port,load_balancer_retries,load_balancer_timeout"
}

clear
read -p "Do you want to create the your application Terminals now (y/N)?" n

case $n in
    y) auto_proc ;;
    n) manual_proc ;;
    *) echo "Invalid option, assuming NO" && manual_proc;;
esac


# Open the info page
/srv/cloudlabs/scripts/display.sh /root/info.html

# Delete tokens
rm /root/tokens.json
