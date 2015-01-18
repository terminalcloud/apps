#!/bin/bash
#SNAP: https://www.terminal.com/snapshot/f2f554a3d2c7a899be901334ec6926c9d1a062ada1b7c3fdc31622d43649fec8
# Script to deploy Toshi API Bitcoin at Terminal.com

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
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  curl -L get.rvm.io | bash -s stable
  source /usr/local/rvm/scripts/rvm
  cd $INSTALL_PATH
  echo "source /usr/local/rvm/scripts/rvm" >> .bashrc
  rvm install 2.1.2
  rvm use 2.1.2
  rvm rubygems current
  apt-get -y install libpq-dev postgresql redis-server
  update-rc.d redis-server disable
  gem install bundler
  sed -i 's/5432/21001/g' /etc/postgresql/9.3/main/postgresql.conf
  sed -i 's/local/#local/g' /etc/postgresql/9.3/main/pg_hba.conf
  sed -i 's/host/#host/g' /etc/postgresql/9.3/main/pg_hba.conf
  echo "local all postgres trust" >> /etc/postgresql/9.3/main/pg_hba.conf
  echo "host  all all 127.0.0.1/32  trust" >> /etc/postgresql/9.3/main/pg_hba.conf
  service postgresql restart
  createdb -U postgres -h 127.0.0.1 -p 21001 toshi_development
  createdb -U postgres -h 127.0.0.1 -p 21001 toshi_test
  git clone https://github.com/coinbase/toshi.git
  cd toshi
  cp config/toshi.yml.example config/toshi.yml
  gem install bundle
  bundle install
  bundle exec rake db:migrate
  echo 'echo "port 21002" | redis-server -' > redis_start.sh
  chmod +x redis_start.sh
}


install_hooks(){
    mkdir -p /CL/hooks/
    cat > /CL/hooks/startup.sh << ENDOFFILE

#!/bin/bash

name="toshi"

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
<p id="exlink"><a id="exlink" target="_blank" href="http://\$(hostname)-5000.terminal.com"><b>See your Toshi instance running here!</b></a></p>
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

# Start Redis
nohup /root/toshi/redis_start.sh &

# Convert links to external links
sed -i 's/a\ href/a\ target\=\"\_blank\"\ href/g' /root/info.html

# Update server URL in Docs
sed -i "s/terminalservername/\$(hostname)/g" /root/info.html


# Showing up
cat | /srv/cloudlabs/scripts/run_in_term.js	 << EOF
cd /root/toshi;  sleep 5; screen -dmS 'toshi' foreman start
/srv/cloudlabs/scripts/display.sh /root/info.html
EOF
ENDOFFILE

chmod 777 /CL/hooks/startup.sh
}

install && install_hooks

#RUN: echo "Installation done"