#!/bin/bash

# Add repository with Sphinx search engine
zypper addrepo -f 'http://download.opensuse.org/repositories/server:/search/openSUSE_13.2/server:search.repo'
# Add repository with latest PhantomJS headless browser
zypper addrepo -f 'http://download.opensuse.org/repositories/OBS:/Server:/2.6/openSUSE_13.2/OBS:Server:2.6.repo'
zypper --gpg-auto-import-keys refresh

# Install required packages
zypper install -y mysql mysql-devel sphinx ruby-devel rubygem-bundler libxml2-devel libxslt-devel sqlite3-devel nodejs \
                  phantomjs

# Enable MySQL service — now and on startup
chkconfig mysql on
service mysql start

# Setup hackweek_development database
mysql -e "CREATE DATABASE IF NOT EXISTS hackweek_development DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;"
mysql -e "GRANT ALL PRIVILEGES on hackweek_development.* to hackweek@localhost identified by 'S3cr3t';"

# Setup hackweel_test database
mysql -e "CREATE DATABASE IF NOT EXISTS hackweek_test DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;"
mysql -e "GRANT ALL PRIVILEGES on hackweek_test.* to hackweek@localhost identified by 'S3cr3t';"

# Download english morphology dictionary
wget 'http://sphinxsearch.com/files/dicts/en.pak' -O /vagrant/en.pak
