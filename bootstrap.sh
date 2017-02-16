#!/usr/bin/env bash

echo -e "\n--- Start the provisioning magic ---\n"

echo -e "\n--- Updating packages list... ---\n"
apt-get -q9 update

echo -e "\n--- Installing Apache and its modules... ---\n"
apt-get install -y apache2
apt-get install -y php
apt-get install -y php-cli
apt-get install -y php-mysql
apt-get install -y php-curl
apt-get install -y php-gd
apt-get install -y php-xdebug
apt-get install -y php-apcu
apt-get install -y php-mcrypt

echo -e "\n--- Installing MySQL... ---\n"
apt-get install debconf-utils -y
debconf-set-selections <<< "mysql-server mysql-server/root_password password 1234"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password 1234"
apt-get install mysql-server -y

echo -e "\n--- Configuring Apache... ---\n"
sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
a2enmod rewrite
a2enmod ssl
a2ensite default-ssl
php5enmod mcrypt

# Setup Xdebug
echo "
xdebug.remote_enable=on
xdebug.remote_connect_back=on
xdebug.idekey=\"vagrant\"
xdebug.max_nesting_level=1024
" >> /etc/php/7.0/mods-available/xdebug.ini

echo -e "--- Restarting Apache... ---\n"
service apache2 restart

echo -e "\n--- Linking folders... ---\n"
# Link apache htdocs folder to shared folder
if ! [ -L /var/www ]; then
  rm -rf /var/www/*
  ln -fs /vagrant /var/www/html
fi

echo -e "\n--- Done. Happy coding! ---\n"
echo -e "\n--- You can reach this webserver at http://localhost:8080/ ---\n"
