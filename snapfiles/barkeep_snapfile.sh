#!/bin/bash
#SNAP: https://www.terminal.com/snapshot/f2f554a3d2c7a899be901334ec6926c9d1a062ada1b7c3fdc31622d43649fec8
# Script to deploy Barkeep at Terminal.com

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
  apt-get -y install python-pip python-imaging
  apt-get install -y g++ build-essential libxslt1-dev libxml2-dev python-dev libmysqlclient-dev redis-server
  # Ruby SE


  ruby_install
  source .bash_rc
  rvm install ruby-1.9.3-p194
  rvm use ruby-1.9.3-p194 --default
  gem install bundler

  git clone git://github.com/ooyala/barkeep.git ~/barkeep
  cd ~/barkeep && bundle install
  apt-get install mysql-server

  mysqladmin -u root --password='' create barkeep
  cd ~/barkeep && ./script/run_migrations.rb

  cd ~/barkeep
  foreman export upstart upstart_scripts -a barkeep -l /var/log/barkeep -u $USER -f Procfile
  mv upstart_scripts/* /etc/init

  cp environment.prod.rb environment.rb
  cp environment.prod.sh environment.sh

}

install_hooks(){
    mkdir -p /CL/hooks/
    cat > /CL/hooks/startup.sh << ENDOFFILE
#!/bin/bash

name="barkeep"

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
<p id="exlink"><a id="exlink" target="_blank" href="http://\$(hostname)-80.terminal.com"><b>Check your installation here!</b></a></p>
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
echo | /srv/cloudlabs/scripts/run_in_term.js

# Showing up
cat | /srv/cloudlabs/scripts/run_in_term.js	 << EOF
/srv/cloudlabs/scripts/display.sh /root/info.html
EOF

ENDOFFILE
chmod 777 /CL/hooks/startup.sh
}

install && install_hooks

#RUN: cd ~/barkeep ; start barkeep
