#!/bin/bash
#SNAP: https://www.terminal.com/snapshot/f2f554a3d2c7a899be901334ec6926c9d1a062ada1b7c3fdc31622d43649fec8
# Script to deploy Church.IO PM at Terminal.com

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
	apache_install
	mysql_install
	apt-get -y install build-essential libreadline-dev libcurl4-openssl-dev nodejs libmysqlclient-dev software-properties-common
	apt-get -y install libaprutil1-dev libapr1-dev apache2-threaded-dev libapache2-mod-xsendfile imagemagick
	apt-add-repository -y ppa:brightbox/ruby-ng
	apt-get update
	apt-get install -y ruby2.1 ruby2.1-dev
	cd $INSTALL_PATH
	git clone git://github.com/churchio/onebody.git
	cd onebody
	git checkout 3.2.0
	mkdir -p tmp/pids log public/system
	chmod -R 777 tmp log public/system
	mysql -u root -proot -e "create database onebody default character set utf8 default collate utf8_general_ci; grant all on onebody.* to onebody@localhost identified by 'onebody';"
	cp config/database.yml{.example,}
	gem install bundler
	bundle install --deployment
	cp config/secrets.yml{.example,}
	vi config/secrets.yml
	#change salt value
	RAILS_ENV=production bundle exec rake db:migrate db:seed
	RAILS_ENV=production bundle exec rake assets:precompile
	apt-get update
	apt-get install libapache2-mod-passenger
	a2enmod passenger
	a2enmod xsendfile
	apache_default_vhost onebody.conf /var/www/onebody/public
	vi /etc/apache2/sites-available/onebody.conf
	#XSendFile On
	#XSendFilePath /var/www/onebody/public/system
	service apache2 restart
}

install_hooks(){
    mkdir -p /CL/hooks/
    cat > /CL/hooks/startup.sh << ENDOFFILE
#!/bin/bash

name="churchio"

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
<p id="exlink"><a id="exlink" target="_blank" href="http://$\(hostname)-80.terminal.com"><b>Check your installation here!</b></a></p>
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
sed -i "s/terminalservername/$\(hostname)/g" /root/info.html

# Open a new terminal
echo | /srv/cloudlabs/scripts/run_in_term.js

# Showing up
cat | /srv/cloudlabs/scripts/run_in_term.js	 << EOF
/srv/cloudlabs/scripts/display.sh /root/info.html
EOF
ENDOFFILE

chmod 777 /CL/hooks/startup.sh
}

install && install_hooks

#RUN: echo "Installation done"