#!/bin/bash
# Script to deploy Fedena at Terminal.com

INSTALL_PATH="/opt/fedena"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
  # Basics
  system_cleanup
  basics_install

  # Procedure:
  apt-get -y install zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev
  apt-get -y install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev libmysqlclient-dev
  gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
  curl -L https://get.rvm.io | bash -s stable
  source /usr/local/rvm/scripts/rvm
  echo "source /usr/local/rvm/scripts/rvm" >> ~/.bashrc
  rvm install 1.8.7
  rvm use 1.8.7 --default
  gem install rails -v 2.3.5
  mysql_install terminal
  git clone https://github.com/projectfedena/fedena.git $INSTALL_PATH
  gem uninstall -i /usr/local/rvm/gems/ruby-1.8.7-head@global rake
  gem uninstall -i ~/.rvm/gems/ruby-1.8.7-head@global rake
  gem install rake -v 0.8.7
  gem install declarative_authorization -v 0.5.1
  gem install i18n -v 0.4.2
  gem install mysql
  gem install rush -v 0.6.8
  gem update --system 1.3.7
  sed -i 's/foradian/terminal/g' config/database.yml
  rake db:create
  rake db:migrate
  rake fedena:plugins:install_all
  chmod +x script/*
  # start the server with script/server
  script/server -d # deatached version
}

install_hooks(){
    mkdir -p /CL/hooks/
    cat > /CL/hooks/startup.sh << ENDOFFILE

#!/bin/bash

name="fedena"

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

#RUN: echo "Installation done"