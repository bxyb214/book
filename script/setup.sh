#!/usr/bin/env bash

USER='whoami'
APP_ROOT=/var/www/campo


# Development environment
# cp config/database.example.yml config/database.yml
# cp config/secrets.example.yml config/secrets.yml
# cp config/config.example.yml config/config.yml
# bundle install
# bundle exec rake db:create:all db:setup


# Production environment
# sudo mkdir -p $APP_ROOT
# sudo chown $USER:$USER $APP_ROOT
# mkdir -p $APP_ROOT/shared/config
# cp config/database.example.yml $APP_ROOT/shared/config/database.yml
# cp config/secrets.example.yml $APP_ROOT/shared/config/secrets.yml
# cp config/config.example.yml $APP_ROOT/shared/config/config.yml
sed -i "s/secret_key_base: \w\+/secret_key_base: `bundle exec rake secret`/g" /var/www/campo/shared/config/secrets.yml

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
