#!/usr/bin/env bash

echo -e "\n--- Start the provisioning magic ---\n"

echo -e "\n--- Updating packages list... ---\n"
aptitude -q9 update > /dev/null 2>&1

echo -e "\n--- Installing Apache and its modules... ---\n"
aptitude install -y apache2 > /dev/null 2>&1
aptitude install -y php5 > /dev/null 2>&1
aptitude install -y libapache2-mod-php5 > /dev/null 2>&1
aptitude install -y php5-cli > /dev/null 2>&1
aptitude install -y php5-mysql > /dev/null 2>&1
aptitude install -y php5-curl > /dev/null 2>&1
aptitude install -y php5-gd > /dev/null 2>&1
aptitude install -y php5-xdebug > /dev/null 2>&1
aptitude install -y php5-apcu > /dev/null 2>&1
aptitude install -y php5-mcrypt > /dev/null 2>&1

echo -e "\n--- Installing MySQL... ---\n"
apt-get install debconf-utils -y > /dev/null 2>&1
debconf-set-selections <<< "mysql-server mysql-server/root_password password 1234"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password 1234"
apt-get install mysql-server -y > /dev/null 2>&1

echo -e "\n--- Configuring Apache... ---\n"
sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
a2enmod rewrite > /dev/null 2>&1
a2enmod ssl > /dev/null 2>&1
a2ensite default-ssl > /dev/null 2>&1
php5enmod mcrypt > /dev/null 2>&1

# Setup Xdebug
echo "
xdebug.remote_enable=on
xdebug.remote_connect_back=on
xdebug.idekey=\"vagrant\"
" >> /etc/php5/mods-available/xdebug.ini

echo -e "--- Restarting Apache... ---\n"
service apache2 restart > /dev/null 2>&1

echo -e "\n--- Linking folders... ---\n"
# Link apache htdocs folder to shared folder
if ! [ -L /var/www ]; then
  rm -rf /var/www/*  > /dev/null 2>&1
  ln -fs /vagrant /var/www/html  > /dev/null 2>&1
fi

echo -e "\n--- Done. Happy coding! ---\n"
