#!/bin/bash
#SNAP: https://www.terminal.com/snapshot/f2f554a3d2c7a899be901334ec6926c9d1a062ada1b7c3fdc31622d43649fec8
# Script to deploy PostgreSQL Stack at Terminal.com

INSTALL_PATH="/root/"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure: 
	postgres_install
	
	# PGWeb installation
	mkdir -p /opt/pgweb
	cd /opt/pgweb
	wget https://github.com/sosedoff/pgweb/releases/download/v0.3.0/pgweb_linux_amd64.zip
	unzip pgweb_linux_amd64.zip && rm pgweb_linux_amd64.zip
	chmod +x pgweb_linux_amd64
	ln -s /opt/pgweb/pgweb_linux_amd64 /bin/pgweb

	# PhpPGAdmin
	apt-get -y install phppgadmin || yum -y install phppgadmin
	cp /etc/apache2/conf.d/phppgadmin /etc/apache2/conf-enabled/phppgadmin.conf
	/etc/init.d/apache2 restart
}

install_hooks(){
    mkdir -p /CL/hooks/
    cat > /CL/hooks/startup.sh << ENDOFFILE

#!/bin/bash

name="postgres"

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
<p id="exlink"><a id="exlink" target="_blank" href="http://\$(hostname)-80.terminal.com"><b>Access your application here</b></a></p>
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
sed -i "s/terminalservername/\$(hostname)/g" /root/info.html

# Open a new terminal
echo "pgweb --url postgres://postgres:t3rminal@localhost:5432/test"| /srv/cloudlabs/scripts/run_in_term.js

# Showing up
cat | /srv/cloudlabs/scripts/run_in_term.js	 << EOF
/srv/cloudlabs/scripts/display.sh /root/info.html
EOF
ENDOFFILE

chmod 777 /CL/hooks/startup.sh
}

install && install_hooks

#RUN: echo "Installation done"