#!/bin/bash

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

# Set home dir
WORKDIR='/home/huginn/huginn'


setup_domain(){
    read -p "Please write down your domain carefuly and press enter:" domain
    sudo -u huginn -H sed -i 's/^DOMAIN=.*/DOMAIN='$domain'-3000.terminal.com/g' .env
}


custom_smtp(){
    echo "Please provide the information needed."
    read -p "SMTP Domain (e.g.: gmail.com)?:" SMTP_DOMAIN
    read -p "SMTP User Name (e.g.: you@gmail.com)?:" SMTP_USER_NAME
    read -p "SMTP Server (e.g.: smtp.gmail.com):" SMTP_SERVER
    read -s -p "Password (Will not be shown):" SMTP_PASS
    echo 'OK'
    sudo -u huginn -H sed -i 's/SMTP_DOMAIN\=.*/SMTP_DOMAIN\='$SMTP_DOMAIN'/g' .env
    sudo -u huginn -H sed -i 's/SMTP_USER_NAME\=.*/SMTP_USER_NAME\='$SMTP_USER_NAME'/g' .env
    sudo -u huginn -H sed -i 's/SMTP_SERVER\=.*/SMTP_SERVER\='$SMTP_SERVER'/g' .env
    sudo -u huginn -H sed -i 's/SMTP_PASSWORD\=.*/SMTP_PASSWORD\='$SMTP_PASS'/g' .env
}



main_process(){
    # Setup uniq token
    token=$(sudo -u huginn -H rake secret)
    sudo -u huginn -H sed -i 's/APP_SECRET_TOKEN\=.*/APP_SECRET_TOKEN\='$token'/g' .env

    # Ask for custom domains or setup the default one
    while true; do
        read -p "Do you wish to use your custom domain on this installation?" yn_domain
        case $yn_domain in
            [Yy]* ) setup_domain; break;;
            [Nn]* ) sudo -u huginn -H sed -i 's/^DOMAIN=.*/DOMAIN='$(hostname)'-3000.terminal.com/g' .env ; break;;
            * ) echo "Please answer yes or no.";;
        esac
    done

    # Ask for SMTP stuff
    while true; do
        read -p "Do you want to setup your SMTP credentials?" yn_smtp
        case $yn_smtp in
            [Yy]* ) custom_smtp; break;;
            [Nn]* ) true; break;;
            * ) echo "Please answer yes or no.";;
        esac
    done
    echo 'Creating Database - Please stand by...'
    sudo -u huginn -H bundle exec rake db:create RAILS_ENV=production
    sudo -u huginn -H bundle exec rake db:migrate RAILS_ENV=production
    sudo -u huginn -H bundle exec rake db:seed RAILS_ENV=production

    # Check the username and stuff here
    read -p "Please provide an Admin user name for Huginn:" USER
    read -s -p "Password (Will not be shown): " PASS
    echo "OK"
    sudo -u huginn -H bundle exec rake db:seed RAILS_ENV=production SEED_USERNAME=$USER SEED_PASSWORD=$PASS
    sudo -u huginn -H bundle exec rake assets:precompile RAILS_ENV=production
    echo "please wait..."
    sleep 3
}

cd $WORKDIR
main_process
sudo -u root -H rake production:export
cp deployment/logrotate/huginn /etc/logrotate.d/huginn
