#!/bin/bash
# Script to deploy Phabricator at Terminal.com
# Cloudlabs, INC. Copyright (C) 2015
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# Cloudlabs, INC. - 653 Harrison St, San Francisco, CA 94107.
# http://www.terminal.com - help@terminal.com

INSTALL_PATH="/var/www"

# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure: 
	php5_install
	mysql_install
	apt-get -y install python-pip || yum -y install python-pip
	apt-get -y install php-apc || yum -y install php-apc
	pip install Pygments
	mkdir -p '/var/repo/'
	chown -R www-data:www-data '/var/repo/'
	cd $INSTALL_PATH
	git clone https://github.com/phacility/libphutil.git
	git clone https://github.com/phacility/arcanist.git
	git clone https://github.com/phacility/phabricator.git
	chown -R www-data:www-data *
	cd phabricator
	./bin/config set mysql.host localhost
	./bin/config set mysql.user root
	./bin/config set mysql.pass root
	./bin/config set pygments.enabled true
	./bin/config set storage.upload-size-limit 10M
	./bin/config set repository.default-local-path "/var/repo/"
	./bin/storage upgrade --force
	apache_install
	apache_default_vhost phabricator.conf /var/www/phabricator/webroot
	cat > /etc/apache2/sites-available/phabricator.conf << EOF
<VirtualHost *>
  DocumentRoot /var/www/phabricator/webroot

<Directory "/var/www/phabricator/webroot">
  Order allow,deny
  Allow from all
</Directory>

  RewriteEngine on
  RewriteRule ^/rsrc/(.*)     -                       [L,QSA]
  RewriteRule ^/favicon.ico   -                       [L,QSA]
  RewriteRule ^(.*)$          /index.php?__path__=\$1  [B,L,QSA]
</VirtualHost>
EOF
    sed -i '45i sql_mode=STRICT_ALL_TABLES' /etc/mysql/my.cnf
    sed -i '46i ft_stopword_file=/var/www/phabricator/resources/sql/stopwords.txt' /etc/mysql/my.cnf
    sed -i '47i ft_min_word_len=3' /etc/mysql/my.cnf
    sed -i "48i ft_boolean_syntax=' |-><()~*:\"\"&^' " /etc/mysql/my.cnf
    sed -i '49i innodb_buffer_pool_size=1600M' /etc/mysql/my.cnf
    sed -i 's/;date.timezone =/date.timezone = America\/Los_Angeles/g' /etc/php5/apache2/php.ini
    sed -i 's/post_max_size = 8M/post_max_size = 20M/g' /etc/php5/apache2/php.ini
    sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 18M/g' /etc/php5/apache2/php.ini

    a2enmod rewrite
    php5enmod apcu
    service mysql restart
    mysql -uroot -proot -e 'REPAIR TABLE phabricator_search.search_documentfield;'
    ./bin/phd start
    echo "PATH=\$PATH:/var/www/arcanist/bin/" >> ~/.bashrc
	service apache2 restart


}

install_hooks(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/phabricator_hooks.sh
	mkdir -p /CL/hooks/
	mv phabricator_hooks.sh /CL/hooks/startup.sh
	chmod 777 /CL/hooks/startup.sh
}



if [[ -z $1 ]]; then
	install && install_hooks
elif [[ $1 == "show" ]]; then 
	show
else
	echo "unknown parameter specified"
fi