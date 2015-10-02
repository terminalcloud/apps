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


cd /home/huginn/huginn
    # From here, customizations
token=$(sudo -u huginn -H rake secret)
sudo -u huginn -H sed -i 's/APP_SECRET_TOKEN\=.*/APP_SECRET_TOKEN\='$token'/g' .env
sudo -u huginn -H sed -i 's/^DOMAIN=.*/DOMAIN='$(hostname)'-3000.terminal.com/g' .env


sudo -u huginn -H bundle exec rake db:create RAILS_ENV=production
sudo -u huginn -H bundle exec rake db:migrate RAILS_ENV=production
sudo -u huginn -H bundle exec rake db:seed RAILS_ENV=production

# Check the username and stuff here
sudo -u huginn -H bundle exec rake db:seed RAILS_ENV=production SEED_USERNAME=admin SEED_PASSWORD=terminal
sudo -u huginn -H bundle exec rake assets:precompile RAILS_ENV=production

#rake production:export
cp deployment/logrotate/huginn /etc/logrotate.d/huginn
