#!/bin/bash
#SNAP: https://www.terminal.com/snapshot/f2f554a3d2c7a899be901334ec6926c9d1a062ada1b7c3fdc31622d43649fec8
# Script to deploy Balero CMS at Terminal.com

INSTALL_PATH="/var/www"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
  # Basics
  system_cleanup
  basics_install

  # Procedure:
  php5_install
  mysql_install
  mysql_setup balero balero terminal
  cd $INSTALL_PATH
  wget -O balero.zip https://github.com/BaleroCMS/balerocms-src/archive/master.zip
  unzip balero.zip && rm balero.zip
  mv balerocms-src-master balero
  chown -R www-data:www-data balero
  mv /var/www/balero/site/etc/balero.config.xml.blank /var/www/balero/site/etc/balero.config.xml
  apache_install
  apache_default_vhost balero.conf $INSTALL_PATH/balero/
  echo "date.timezone = America/Los_Angeles" >> /etc/php5/apache2/php.ini
  sed -i 's/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 30M/g' /etc/php5/apache2/php.ini
  sed -i 's/post_max_size\ \=\ 8M/post_max_size\ \=\ 32M/g' /etc/php5/apache2/php.ini
  sed -i 's/max_execution_time\ \=\ 30/max_execution_time\ \=\ 60/g' /etc/php5/apache2/php.ini
  service apache2 restart
}

install_hooks(){
    mkdir -p /CL/hooks/
    cat > /CL/hooks/startup.sh << ENDOFFILE

#!/bin/bash

name="balero"

export PATH=$PATH:/srv/cloudlabs/scripts

# Update server URL in Docs
sed -i "s/terminalservername/\$(hostname)/g" /var/www/balero/site/etc/balero.config.xml

# Getting the doc and styles
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/"$name".md
wget -q -N --timeout=2 https://raw.githubusercontent.com/terminalcloud/apps/master/docs/termlib.css && mv termlib.css /root/

# Making the file...
cat > /root/info.html << EOF
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="termlib.css" />
<p id="exlink"><a id="exlink" target="_blank" href="http://\$(hostname)-80.terminal.com/admin"><b>Balero CMS Admin login</b></a></p>
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
sed -i "s/terminalservername/$(hostname)/g" /root/info.html

# Open a new terminal
echo | /srv/cloudlabs/scripts/run_in_term.js

# Showing up
cat | /srv/cloudlabs/scripts/run_in_term.js  << EOF
/srv/cloudlabs/scripts/display.sh /root/info.html
EOF
ENDOFFILE
chmod 777 /CL/hooks/startup.sh
}

install && install_hooks

#RUN: echo "Installation done"