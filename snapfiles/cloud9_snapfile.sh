#!/bin/bash
#SNAP: https://www.terminal.com/snapshot/f2f554a3d2c7a899be901334ec6926c9d1a062ada1b7c3fdc31622d43649fec8
# Script to deploy Cloud9 at Terminal.com

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
	apt-get install -y python-software-properties python make build-essential g++ curl libssl-dev apache2-utils git libxml2-dev
	apt-get -y remove nodejs
	cd $INSTALL_PATH
	git clone git://github.com/creationix/nvm.git /root/nvm
	/root/nvm/install.sh
	source /root/.bashrc
	nvm install v0.8.28
	nvm use v0.8.28
	npm install forever -g
	git clone https://github.com/ajaxorg/cloud9.git cloud9
	cd cloud9
	npm install packager
	npm install
	echo "To start Cloud9 please execute: nvm use v0.8.28 && forever start /root/cloud9/server.js -w /root -l 0.0.0.0 --username user --password terminal"
}

install_hooks(){
    mkdir -p /CL/hooks/
    cat > /CL/hooks/startup.sh << ENDOFFILE
#!/bin/bash

name="cloud9"

export PATH=\$PATH:/srv/cloudlabs/scripts

# Getting the doc and styles
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/"\$name".md
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/termlib.css && mv termlib.css /root/


# Making the file...
cat > /root/info.html << EOF
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="termlib.css" />
<p id="exlink"><a id="exlink" target="_blank" href="http://\$(hostname)-3131.terminal.com"><b>Check your installation here!</b></a></p>
</head>
<body>
EOF

# Converting markdown file
markdown "\$name.md" >> /root/info.html

# Closing file
cat >> /root/info.html << EOF
</body>
</html>
EOF

# Convert links to external links
sed -i 's/a\ href/a\ target\=\"\_blank\"\ href/g' /root/info.html

# Update server URL in Docs
sed -i "s/terminalservername/http\:\/\/\$(hostname)\-80\.terminal\.com/g" /root/info.html

# Showing up
cat | /srv/cloudlabs/scripts/run_in_term.js << EOF
/srv/cloudlabs/scripts/display.sh /root/info.html
EOF
ENDOFFILE

chmod 777 /CL/hooks/startup.sh
}

install && install_hooks

#RUN: nvm use v0.8.28 && forever start /root/cloud9/server.js -w /root -l 0.0.0.0 --username user --password terminal