# vagrant-lamp

This is my minimal vagrant LAMP stack configuration.

# Installed software

* Apache
* php5 with essential modules (look on `bootstrap.sh` for details)
* MySQL
* Xdebug

# Requirements

* Vagrant
* VirtualBox

# Usage

Clone this repository 

`git clone git@github.com:salvozappa/vagrant-lamp.git`

Run the vagrant machine

`vagrant up`

You're ready to go! The webserver will be available at [http://localhost:8080/](http://localhost:8080/)


# Notes

The MySQL user is `root` and the password is `1234`