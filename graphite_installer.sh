#!/bin/bash
# Script to deploy Graphite at Terminal.com
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
	apt-get -y install graphite-web graphite-carbon python-pip python-dev libffi-dev
	pip install cairocffi
	cd /usr/share/graphite-web/static/js
	ln -s ../../../javascript/jquery-flot/jquery.flot.time.js
	sed -i 's/\#SECRET_KEY.*/SECRET_KEY\ \=\ \'thisisasupersecretsaltkey\'/s' /etc/graphite/local_settings.py
	sed -i 's/\#TIME_ZONE/TIME_ZONE/g' /etc/graphite/local_settings.py
	sed -i 's/\#ALLOWED_HOSTS/ALLOWED_HOSTS/g' /etc/graphite/local_settings.py
    sed -i '10i\ \ \ \ \<script\ type\=\"text\/javascript\"\ src\=\"\.\.\/content\/js\/jquery\.flot\.time\.js\"\>\<\/script\>' /usr/lib/python2.7/dist-packages/graphite/templates/graphlot.html
    graphite-manage syncdb
    # Manual intervention

    sed -i 's/false/true/g' /etc/default/graphite-carbon
    sed -i 's/ENABLE_LOGROTATION.*/ENABLE_LOGROTATION\ \=\ True/g' /etc/carbon/carbon.conf

    echo "CONFIGURE STORAGE SCHEMAS AT /etc/carbon/storage-schemas.conf"
    cp /usr/share/doc/graphite-carbon/examples/storage-aggregation.conf.example /etc/carbon/storage-aggregation.conf
    echo "CONFIGURE STORAGE AGREGATION METHODS AT /etc/carbon/storage-aggregation.conf"

    service carbon-cache start
    apt-get install apache2 libapache2-mod-wsgi
    a2dissite 000-default
    cp /usr/share/graphite-web/apache2-graphite.conf /etc/apache2/sites-available
    chmod -R 777 /var/lib/graphite/
    a2ensite apache2-graphite
    service apache2 restart

# Edit: Simple fix:
# 1) in /usr/share/graphite-web/static/js, link to jquery.flot.time.js:
# ln -s ../../../javascript/jquery-flot/jquery.flot.time.js
# 2) edit /usr/lib/python2.7/dist-packages/graphite/templates/graphlot.html and insert this line in the beginning (you'll see where):
# <script type="text/javascript" src="../content/js/jquery.flot.time.js"></script>


	# DB files in  /var/lib/graphite/whisper
	# https://github.com/graphite-project/graphite-web/issues/789
	# Manual intervention required
}

install_collectd_centos(){
    yum -y install libcurl libcurl-devel rrdtool rrdtool-devel rrdtool-prel libgcrypt-devel gcc make gcc-c++
    yum -y install perl-devel
    wget http://collectd.org/files/collectd-5.5.0.tar.gz
    tar -xzf collectd-5.5.0.tar.gz
    cd collectd-5.5.0
    ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --libdir=/usr/lib --mandir=/usr/share/man --enable-all-plugins
    make
    make install
    cp contrib/redhat/init.d-collectd /etc/init.d/collectd
    chmod +x /etc/init.d/collectd
    service collectd start
}

configure_collectd_centos(){
    # Plugins load
    sed -i 's/\#FQDNLookup.*/FQDNLookup\ \ \ true/g' /etc/collectd.conf
    sed -i 's/\#LoadPlugin\ cpufreq/LoadPlugin\ cpufreq/g' /etc/collectd.conf
    sed -i 's/\#LoadPlugin\ disk/LoadPlugin\ disk/g' /etc/collectd.conf
    sed -i 's/\#LoadPlugin\ df/LoadPlugin\ df/g' /etc/collectd.conf
    sed -i 's/\#LoadPlugin\ ethstat/LoadPlugin\ ethstat/g' /etc/collectd.conf
    sed -i 's/\#LoadPlugin\ write_graphite/LoadPlugin\ write_graphite/g' /etc/collectd.conf


    # Plugin Configurations



}



