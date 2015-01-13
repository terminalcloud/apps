#!/bin/bash
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
    apt-get -y install build-essential libmysqlclient-dev
    mysql_install
    mysql_setup autolab autolab terminal # db user pass

    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

    gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
    curl -L get.rvm.io | bash -s stable # Requires Basics
    echo "source /usr/local/rvm/scripts/rvm" >> ~/.bash_rc
    source ~/.bash_rc

    git clone https://github.com/autolab/Autolab.git
    RVERSION=$(cat ~/Autolab/.ruby-version | head -1)

    rvm install $RVERSION
    rvm use $RVERSION


    gem install bundler
    gem install mysql2 -v '0.3.17'

    cd ~/Autolab
    rbenv rehash
    bundle install

    cp config/database.yml.template config/database.yml
    sed -i 's/<username>_autolab_development/autolab/g' config/database.yml
    sed -i 's/<username>/autolab/g' config/database.yml
    sed -i 's/<password>/terminal/g' config/database.yml

    cp lib/autoConfig.rb.template lib/autoConfig.rb
    sed -i 's/<tango_host>/localhost/g' lib/autoConfig.rb
    sed -i 's/<tango_port>/3001/g' lib/autoConfig.rb
    sed -i 's/<restful_key>/restful_key/g' lib/autoConfig.rb
    sed -i 's/<restful_courselab>/restful_courselab/g' lib/autoConfig.rb


    bundle exec rake db:create
    bundle exec rake db:migrate

    bundle exec rake autolab:populate # Optional. Populate Db with sample data

    #bundle exec rails s -p 3001 -b 0.0.0.0

    # Installing Tango
    cd ~
    git clone https://github.com/autolab/Tango.git
    cd Tango/autodriver
    make clean; make
    cp autodriver /usr/bin/autodriver
    useradd autograde
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
