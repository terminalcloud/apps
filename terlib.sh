#!/bin/bash
# Terminal.com
# This simple library is intended to provide a standard method to install
# software from OS repositories.

pkg_update(){
	[[ -f /etc/debian_version ]] && apt-get -y update 
}

system_cleanup(){
	[[ -f /etc/debian_version ]] && apt-get -y autoremove --purge samba* apache2* \
	|| yum -y remove httpd* samba*
	echo "nameserver 8.8.8.8" >> /etc/resolv.conf
	echo "nameserver 8.8.8.9" >> /etc/resolv.conf
	#[[ -f /etc/debian_version ]] && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade || yum -y update
}

basics_install(){
	[[ -f /etc/debian_version ]] && apt-get -y install curl git software-properties-common unzip markdown bash\
	|| yum -y install curl git unzip markdown bash #libcurl4-openssl-dev
}

puppet_install(){
	[[ -f /etc/debian_version ]] && apt-get -y install puppet \
	|| yum -y install puppet
	}

composer_install(){
	curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin --filename=composer
	chmod 755 /bin/composer
}

apache_install(){
	if [[ -f /etc/debian_version ]]; then
		apt-get -y install apache2 && a2enmod rewrite && service apache2 restart
	else
		yum -y install httpd
	fi
}

nginx_install(){
	if [[ -f /etc/debian_version ]]; then
		apt-get -y install nginx nginx-extras
	else
		yum -y install nginx
	fi
}


php5_install(){
	if [[ -f /etc/debian_version ]]; then
		apt-get -y install php5 php-pear php5-gd php5-mcrypt php5-mysql php5-gd libssh2-php php5-sqlite php5-curl libapache2-mod-php5 && php5enmod curl mcrypt gd pdo_mysql
		service apache2 restart 
	else
		yum install php php-pear php-gd php-mcrypt php-mysql libssh2-php php5-sqlite php5-curl
		service httpd restart
	fi
}

mysql_install(){ # Default pass for root user is "root", if no argument is given.
	[[ -z "$1" ]] && pass="root" || pass=$1  
	if [[ -f /etc/debian_version ]]; then
		debconf-set-selections <<< "mysql-server mysql-server/root_password password $pass"
		debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $pass"
		apt-get -y install mysql-server
	else
		echo "Sorry, On this OS install MySql manually, go manually from here" ; return 1  
	fi
}

mysql_setup(){ # Arguments: <db> <user> <pass> . Default (for empty) values = testdb test terminal
	[ -z "$1" ] && db="testdb" || db="$1"
	[ -z "$2" ] && user="test" || user="$2"
	[ -z "$3" ] && pass="terminal" || pass="$3"
	mysql -uroot -proot -e"CREATE DATABASE $db;" || return 1
	mysql -uroot -proot -e"CREATE USER '$user'@'localhost' IDENTIFIED BY '$pass';" || return 1
	mysql -uroot -proot -e"GRANT ALL PRIVILEGES ON $db.* to $user@localhost;" || return 1
}

apache_default_vhost(){ # Arguments: <filename(.conf)> <DocumentRoot>. Default values = default.conf /var/www/html
	[[ -f /etc/debian_version ]] && vpath="/etc/apache2/sites-available/" || vpath="/etc/httpd/config.d/"
	[ -z "$1" ] && filename="default.conf" || filename="$1"
	[ -z "$2" ]  && DocumentRoot="/var/www/html" || DocumentRoot="$2"
	# Start filling the file
	echo "<VirtualHost *:80>" > $vpath/$filename
	echo "DocumentRoot $DocumentRoot" >> $vpath/$filename
	echo "<Directory $DocumentRoot >" >> $vpath/$filename
	cat >> $vpath/$filename <<_EOF_
    Options FollowSymLinks
    AllowOverride All
    #<IfModule mod_rewrite.c>
	#  RewriteEngine On
	#  RewriteBase /
	#  RewriteCond %{REQUEST_FILENAME} !-f
	#  RewriteCond %{REQUEST_FILENAME} !-d
	#  RewriteRule . /index.php [L]
	#</IfModule>
    </Directory>
</VirtualHost>
_EOF_

	# Remove default vhost file, enable the new one and restart Apache. 
	if [[ -f /etc/debian_version ]]; then
		[[ -f /etc/apache2/sites-enabled/000-default.conf ]] && rm /etc/apache2/sites-enabled/000-default.conf
		ln -s /etc/apache2/sites-available/$filename /etc/apache2/sites-enabled/$filename 
		service apache2 restart 
	else
		[[ -f /etc/httpd/conf.d/000-default.conf ]] && rm /etc/httpd/conf.d/000-default.conf
		service httpd restart
	fi
}

golang_install(){
	if [[ -f /etc/debian_version ]]; then 
		apt-get -y install bison gcc make binutils build-essential mercurial golang
	else
		yum -y install bison gcc make glibc-devel mercurial golang
	fi
	bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
	source /root/.gvm/scripts/gvm
	echo "export GOPATH=\$HOME/go" >> ~/.profile
	echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> ~/.profile
	source ~/.profile
}

start_hooks_install(){
	mkdir -p /CL/hooks 
	cat > /CL/hooks/startup.sh << _EOF_
#!/bin/bash
cat > /root/info.html << EOF
<html>
<head><title>External Browser Link</title></head>
<body>
Check out your installation <a target="_blank" href="//\$(hostname)-80.terminal.com">here!</a>
</body>
</html>
EOF

cat | /srv/cloudlabs/scripts/run_in_term.js << EOF
/srv/cloudlabs/scripts/display.sh /root/info.html
EOF

_EOF_
	chmod 755 /CL/hooks/startup.sh
}

ruby_install(){
	curl -L get.rvm.io | bash -s stable # Requires Basics
	source /usr/local/rvm/scripts/rvm
	rvm install 2.1.2
	rvm use current --default
	rvm rubygems current
	[[ $1 == "rails" ]] && gem install rails
}

python_install(){ # This will install django in /opt/myenv virtual-env
	if [[ -f /etc/debian_version ]]; then
		apt-get -y install python-pip python2.7 dh-virtualenv
	else
		yum -y install python-pip python2.7 dh-virtualenv
	fi
}

postgres_install(){
	if [[ -f /etc/debian_version ]]; then
		apt-get -y install libpq-dev python-dev
		apt-get -y install postgresql postgresql-contrib
		service postgresql start
	else
		yum -y install postgresql
		service postgresql start
	fi
}

gunicorn_install(){ # by now assuming the virtualvend exists, otherwise going global
	source /opt/myenv/bin/activate
	pip install gunicorn
}