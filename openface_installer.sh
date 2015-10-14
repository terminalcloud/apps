#!/bin/bash
# Script to deploy Akeneo PM at Terminal.com
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
    apt-get install -y build-essential cmake curl gfortran git libatlas-dev libavcodec-dev libavformat-dev \
    libboost-all-dev libgtk2.0-dev libjpeg-dev liblapack-dev libswscale-dev pkg-config python-dev python-pip wget zip

    pip2 install numpy scipy pandas
    pip2 install scikit-learn scikit-image
    curl -s https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash -e
    git clone https://github.com/torch/distro.git ~/torch --recursive

    cd ~/torch && ./install.sh
    ~/torch/install/bin/luarocks install nn
    ~/torch/install/bin/luarocks install dpnn
    ~/torch/install/bin/luarocks install image
    ~/torch/install/bin/luarocks install optim

    cd ~ && mkdir -p src && cd src && curl -L https://github.com/Itseez/opencv/archive/2.4.11.zip -o ocv.zip && \
    unzip ocv.zip && cd opencv-2.4.11 && mkdir release && cd release

    cmake -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local
    make -j8 && make install

    cd ~ && mkdir -p src && cd src
    curl -L https://github.com/davisking/dlib/releases/download/v18.16/dlib-18.16.tar.bz2 -o dlib.tar.bz2 && \
    tar xf dlib.tar.bz2

    cd dlib-18.16/python_examples && mkdir build && cd build

    cmake ../../tools/python && cmake --build . --config Release && cp dlib.so ..
    cp dlib.so /usr/local/lib/dlib.so

    # Additional libs
    git clone https://github.com/cmusatyalab/openface.git

    apt-get install libxml2-dev libxslt1-dev
    cd openface
    apt-get install libopenblas-base
    pip install dlib

    # In the snapshot we also install PyCharm
}

show(){
	# Get the startup script
	wget -q -N https://raw.githubusercontent.com/terminalcloud/apps/master/others/akeneo_hooks.sh
	mkdir -p /CL/hooks/
	mv akeneo_hooks.sh /CL/hooks/startup.sh
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