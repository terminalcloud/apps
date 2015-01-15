#!/bin/bash
#SNAP: https://www.terminal.com/snapshot/f2f554a3d2c7a899be901334ec6926c9d1a062ada1b7c3fdc31622d43649fec8
# Script to deploy ERPNext at Terminal.com

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
	apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
	sudo add-apt-repository "deb http://ams2.mirrors.digitalocean.com/mariadb/repo/5.5/ubuntu $OS_VER main"

	apt-get -y install python-dev python-setuptools build-essential python-mysqldb git memcached \
	ntp vim screen htop mariadb-server mariadb-common libmariadbclient-dev  libxslt1.1 libxslt1-dev \
	redis-server libssl-dev libcrypto++-dev postfix nginx supervisor python-pip fontconfig libxrender1
	echo "It's recommended to stop here and proceed using a **bench** user"
	git clone https://github.com/frappe/bench bench-repo
	sudo pip install -e bench-repo/
	bench patch mariadb-config
	/etc/init.d/redis-server restart
	bench init frappe-bench && cd frappe-bench
	bench get-app erpnext https://github.com/frappe/erpnext
	bench new-site erpsite3 
	bench frappe --install_app erpnext erpsite3
}

install_hooks(){
    mkdir -p /CL/hooks/
    cat > /CL/hooks/startup.sh << ENDOFFILE

#!/bin/bash
name="erpnext"

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
<p id="exlink"><a id="exlink" target="_blank" href="http://\$(hostname)-8000.terminal.com"><b>Test your installation here!</b></a></p>
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
sed -i "s/terminalservername/\$(hostname)/g" /root/info.html

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

#RUN: bench start