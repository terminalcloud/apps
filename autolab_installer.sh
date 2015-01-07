#!/bin/bash
# Script to deploy autolab at Terminal.com

INSTALL_PATH="/root"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Backend:
	cd $INSTALL_PATH
  # Installing rbenv and ruby-build
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
  echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  source ~/.bash_profile
  git clone https://github.com/autolab/Autolab.git
  RVERSION=$(cat ~/Autolab/.ruby-version | head -1)
  rbenv install "$RVERSION"
  gem install bundler
  cd "~/Autolab"
  rbenv rehash
  bundle install

  mysql_install
  mysql_setup autolab autolab terminal # db user pass

  cp config/database.yml.template config/database.yml
  sed -i 's/\<username\>_autolab_development/autolab/g' config/database.yml
  sed -i 's/\<username\>/autolab/g' config/database.yml
  sed -i 's/\<password\>/terminal/g' config/database.yml

  bundle exec rake db:create
  bundle exec rake db:migrate

  bundle exec rake autolab:populate # Optional. Populate Db with sample data

  bundle exec rails s -p 3000
}



show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/autolab_hooks.sh
	mkdir -p /CL/hooks/
	mv autolab_hooks.sh /CL/hooks/startup.sh
	# Execute startup script by first to get the common files
	chmod 777 /CL/hooks/startup.sh && /CL/hooks/startup.sh
}

if [[ -z $1 ]]; then
	install && show
elif [[ $1 == "show" ]]; then
	show
else
	echo "unknown parameter specified"
fi
