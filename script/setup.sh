#!/usr/bin/env bash

USER=`whoami`
APP_ROOT=/var/www/campo

# :<<!
# !

# sudo apt-get update

# Install system packages
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y redis-server memcached git-core nodejs imagemagick postfix

# Install Elasticsearch
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb http://packages.elastic.co/elasticsearch/1.6/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-1.6.list
# sudo bash -c "echo 'deb http://packages.elasticsearch.org/elasticsearch/1.0/debian stable main' > /etc/apt/sources.list.d/elasticsearch.list"
sudo apt-get update
sudo apt-get install -y openjdk-7-jre-headless elasticsearch
sudo update-rc.d elasticsearch defaults
sudo service elasticsearch start

# Install PostgreSQL
# http://www.postgresql.org/download/linux/ubuntu/
sudo bash -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install postgresql-9.4
sudo su postgres -c "createuser -d -R -S $USER"

# Install rvm and ruby
sudo apt-get install -y curl
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source /usr/local/rvm/scripts/rvm
sed -i -e 's/ftp\.ruby-lang\.org\/pub\/ruby/ruby\.taobao\.org\/mirrors\/ruby/g' /usr/local/rvm/config/db
rvm install 2.2.1
rvm use --default 2.2.1

# Install Passenger
# https://www.phusionpassenger.com/documentation/Users%20guide%20Nginx.html#install_on_debian_ubuntu
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
sudo apt-get install apt-transport-https ca-certificates
sudo bash -c "echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main' > /etc/apt/sources.list.d/passenger.list"
sudo apt-get update
sudo apt-get install nginx-extras passenger





# Development environment
cp config/database.example.yml config/database.yml
cp config/secrets.example.yml config/secrets.yml
cp config/config.example.yml config/config.yml
bundle install
bundle exec rake db:create:all db:setup

# Production environment
sudo mkdir -p $APP_ROOT
sudo chown $USER:$USER $APP_ROOT
mkdir -p $APP_ROOT/shared/config
cp config/database.example.yml $APP_ROOT/shared/config/database.yml
cp config/secrets.example.yml $APP_ROOT/shared/config/secrets.yml
cp config/config.example.yml $APP_ROOT/shared/config/config.yml
sed -i "s/secret_key_base: \w\+/secret_key_base: `bundle exec rake secret`/g" $APP_ROOT/shared/config/secrets.yml

# Resque init script
sudo cp config/resque.example.sh /etc/init.d/resque
sudo chmod +x /etc/init.d/resque
sudo sed -i "s|APP_ROOT=.\+|APP_ROOT=$APP_ROOT/current|" /etc/init.d/resque
sudo sed -i "s/USER=\w\+/USER=$USER/" /etc/init.d/resque
sudo update-rc.d resque defaults



# Nginx config
sudo cp config/nginx.example.conf /etc/nginx/sites-available/campo
sudo sed -i "s|root .\+;|root $APP_ROOT/current/public;|" /etc/nginx/sites-available/campo
sudo ln -s /etc/nginx/sites-available/campo /etc/nginx/sites-enabled
sudo rm /etc/nginx/sites-enabled/default
sudo sed -i 's/# passenger_root/passenger_root/' /etc/nginx/nginx.conf
sudo sed -i "s|# passenger_ruby .\+;|passenger_ruby /home/$USER/.rvm/wrappers/default/ruby;|" /etc/nginx/nginx.conf
sudo service nginx restart
