#!/bin/bash
# Script to deploy IPython Notebook 4 at Terminal.com
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


# Includes
wget https://raw.githubusercontent.com/terminalcloud/apps/master/terlib.sh
source terlib.sh || (echo "cannot get the includes"; exit -1)

install(){
	# Basics
	pkg_update
	system_cleanup
	basics_install

	# Procedure:
	apt-get -y install python-dev python-pip pandoc build-essential libpng12-dev python-setuptools \
	libzmq-dev python-matplotlib git
	pip install setuptools
	pip install gnureadline
	pip install numpy
	pip install dateutil
	pip install pyzmq
	pip install pytz
	pip install tornado
	pip install pyparsing
	pip install ipywidgets
	pip install "ipython[test]"
	pip install "ipython[terminal]"
	pip install "ipython[parallel]"
    pip install "ipython[notebook]"
    pip install notebook

    ipython profile create nbserver

    cat >  /root/.ipython/profile_nbserver/ipython_config.py  << EOF
c = get_config()

# Kernel config
c.IPKernelApp.pylab = 'inline'  # if you want plotting support always

# Notebook config
c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False
c.NotebookApp.port = 8080

c.NotebookApp.trust_xheaders = True

c.NotebookApp.tornado_settings = {
    'headers': {
        'Content-Security-Policy': "frame-ancestors 'self' https://*.terminal.com"
    }
}

EOF

    cat > /etc/init/jupyter.conf << EOF
description "iPython Notebook Jupyter Upstart script"
author "Enrique Conci"

start on filesystem or runlevel [2345]
stop on shutdown

script
    export HOME="/root"; cd $HOME
    echo $$ > /var/run/ipython_start.pid
    exec jupyter-notebook --config='/root/.ipython/profile_nbserver/ipython_config.py'
end script

pre-start script
    echo "[`date`] Starting iPython Notebook (Jupyter) Server" >> /var/log/ipython-ntb.log
end script

pre-stop script
    rm /var/run/ipython_start.pid
    echo "[`date`] Stopping iPython Notebook (Jupyter)" >> /var/log/ipython-ntb.log
end script
EOF

    service jupyter start
}
show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/ipython-ntb4_hooks.sh
	mkdir -p /CL/hooks/
	mv ipython-ntb4_hooks.sh /CL/hooks/startup.sh
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