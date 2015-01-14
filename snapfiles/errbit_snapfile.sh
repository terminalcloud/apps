#!/bin/bash
#SNAP: https://www.terminal.com/snapshot/f2f554a3d2c7a899be901334ec6926c9d1a062ada1b7c3fdc31622d43649fec8
# Script to deploy Errbit at Terminal.com

INSTALL_PATH="/root"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure:
	cd $INSTALL_PATH
	echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
	apt-get update
	apt-get -y --force-yes install mongodb-10gen
	apt-get -y 	install libxml2 libxml2-dev libxslt-dev libcurl4-openssl-dev libzip-dev libssl-dev
	curl -sSL https://get.rvm.io | bash -s stable
	/usr/local/rvm/bin/rvm install 1.9.3
	ruby_install
	gem install bundler
	git clone https://github.com/errbit/errbit.git
	cd errbit
	bundle install
	rake errbit:bootstrap
	echo "Errbit is now installed"
	echo "Now you please update the config.yml file with the dev url or update the deploy.rb file to send to production with capistrano"
	echo "use \"script/rails server\" to start the Errbit dev server" 
	# sed -i 's/errbit.example.com/$(hostname)-80.terminal.com/g' errbit/config/config.yml 
	# script/rails server
	# Deploy: cap deploy:setup deploy db:create_mongoid_indexes
}

install_hooks(){
    mkdir -p /CL/hooks/
    cat > /CL/hooks/startup.sh << ENDOFFILE

#!/bin/bash

name="errbit"

export PATH=$PATH:/srv/cloudlabs/scripts

# Getting the doc and styles
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/"$name".md
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/termlib.css && mv termlib.css /root/


# Making the file...
cat > /root/info.html << EOF
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="termlib.css" />
<p id="exlink"><a id="exlink" target="_blank" href="http://\$(hostname)-3000.terminal.com"><b>Check your installation here!</b></a></p>
</head>
<body>
EOF

# Converting markdown file
markdown "$name.md" >> /root/info.html

# Closing file
cat >> /root/info.html << EOF
</body>
</html>
EOF

# Convert links to external links
sed -i 's/a\ href/a\ target\=\"\_blank\"\ href/g' /root/info.html

# Update server URL in Docs
sed -i "s/terminalservername/http\:\/\/\$(hostname)\-3000\.terminal\.com/g" /root/info.html

# Update Errbit config
sed -i 's/errbit.example.com/$(hostname)\-3000.terminal.com/g' /root/errbit/config/config.yml

# Showing up
cat | /srv/cloudlabs/scripts/run_in_term.js << EOF
/srv/cloudlabs/scripts/display.sh /root/info.html
EOF

ENDOFFILE

chmod 777 /CL/hooks/startup.sh
}

install && install_hooks

#RUN: cd /root/errbit ; script/rails server