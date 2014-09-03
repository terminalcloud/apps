#!/bin/bash
# Terminal.com
# This simple library is intended to provide an standard method to install
# software from OS repositories.

pkg_update(){
	[[ -f /etc/debian_version ]] && apt-get update 
}

system_cleanup(){
	[[ -f /etc/debian_version ]] && apt-get -y autoremove --purge samba* apache2* \
	|| yum -y remove httpd* samba*
}

basics_install(){
	[[ -f /etc/debian_version ]] && apt-get -y install curl git \
	|| yum -y install curl git
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

php5_install(){
	if [[ -f /etc/debian_version ]]; then
		apt-get -y install php5 php-pear php5-gd php5-mcrypt php5-mysql && php5enmod mcrypt gd pdo_mysql
		service apache2 restart 
	else
		yum install php php-pear php-gd php-mcrypt php-mysql
		service httpd restart
	fi
}

mysql_install(){ # Default pass for root user is always "root"
	if [[ -f /etc/debian_version ]]; then
		debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
		debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
		apt-get -y install mysql-server
	else
		echo "Sorry, On this OS install MySql manually, go manually from here"   
	fi
}

mysql_setup(){ # You need to specify all arguments: db, user, pass
	[ -z "$1" ] && return 1 || db="$1"
	[ -z "$2" ] && return 1 || user="$2"
	[ -z "$3" ] && return 1 || pass="$3"
	mysql -uroot -proot -e"CREATE DATABASE $db;" || return 1
	mysql -uroot -proot -e"CREATE USER '$user'@'localhost' IDENTIFIED BY '$pass';" || return 1
	mysql -uroot -proot -e"GRANT ALL PRIVILEGES ON $db.* to $user@localhost;" || return 1
}

apache_default_vhost(){ # Arguments: filename(.conf) DocumentRoot
	[[ -f /etc/debian_version ]] && vpath="/etc/apache2/sites-available/" || vpath="/etc/httpd/config.d/"
	[ -z "$1" ] && return 1 || filename="$1"
	[ -z "$2" ]  && return 1 || DocumentRoot="$2"
	# Start filling the file
	echo "<VirtualHost *:80>" > $vpath/$filename
	echo "DocumentRoot $DocumentRoot" >> $vpath/$filename
	cat >> $vpath/$filename <<_EOF_
	<Directory />
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
