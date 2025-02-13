
# update to latest version of ubuntu.
https://ubuntu.com/tutorials/upgrading-ubuntu-desktop#1-before-you-start


# allow ip4:
https://askubuntu.com/questions/1123177/sudo-add-apt-repository-hangs


#########################################
# BASICS
#########################################



# get latest and greatest
sudo apt -y update

# Installing the necessary packages
# add nomodeset to grub loader
# this may help with getting the screens working.


#########################################
# UTILS
#########################################

#########################################
# install vs code
https://code.visualstudio.com/download

#########################################
# install chrome
https://www.google.com/chrome/
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt -y install ./google-chrome-stable_current_amd64.deb

#########################################
# install git
sudo apt -y install git
git config --global corsudo e.filemode false

#########################################
# install meld - for git merges
sudo apt -y install meld
	
#########################################
# install curl
sudo apt -y install curl

#########################################
# install gimp
sudo snap install gimp --channel=edge

#########################################
# install npm
sudo apt -y install nodejs
sudo apt -y install npm

# install nvm
# https://www.freecodecamp.org/news/node-version-manager-nvm-install-guide/
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

#########################################
# install slack
sudo snap install slack --classic




#########################################
# LAMP
#########################################

#########################################
# install apache
sudo apt -y install apache2

# install additional apache modules
sudo a2enmod rewrite
sudo a2enmod vhost_alias
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo service apache2 restart
# set php settings
sudo echo "date.timezone = 'Pacific/Auckland'" >> /etc/php/7.4/apache2/php.ini
sudo service apache2 restart

#########################################
# install mysql
sudo apt -y  install mysql-server
sudo /usr/bin/mysql_secure_installation
# https://stackoverflow.com/questions/39281594/error-1698-28000-access-denied-for-user-rootlocalhost
# login as root to mysql then ... 
sudo mysql -u root -p
mysql> UNINSTALL COMPONENT 'file://component_validate_password';
mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'new-password';
mysql> exit;

#Use phpmyadmin as user if root user not set up

sudo service mysql restart

# mysql -u root -p[as you set it]
# see: https://linuxconfig.org/how-to-reset-root-mysql-password-on-ubuntu-18-04-bionic-beaver-linux

#########################################
# install phpmyadmin
sudo apt -y install phpmyadmin	

#########################################
# install php versions
git clone https://github.com/sunnysideup/silverstripe-switch-php-versions.git
sudo bash silverstripe-switch-php-versions/install.sh
rm silverstripe-switch-php-versions -rf



#########################################
# COMPOSER
#########################################

# install composer
sudo apt -y install composer
nano ~/.bashrc 
# add one of these: 
# - PATH=~/.composer/vendor/bin:$PATH
# - PATH=~/.config/composer/vendor/bin:$PATH
# reload ~/.bashrc
source ~/.bashrc

#https://getcomposer.org/download/
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer

composer -v
# install linter
composer global require sunnysideup/easy-coding-standards:dev-master
composer global update


#########################################
# SETTINGS
#########################################

# set up public key and create aliases
ssh-keygen
sudo nano ~/.ssh/config 
	


#########################################
# SILVERSTRIPE
#########################################



# set up sites-enables - see default.conf
sudo nano /etc/apache2/sites-enabled/sites-enabled.conf

sudo chown ssu:www-data . -R
# create folders for silverstripe
sudo mkdir /var/www/ss3
sudo mkdir /var/www/ss4
sudo mkdir /var/www/ss5

# set up aliases
sudo ln -s /var/www/ss3 /ss3
sudo ln -s /var/www/ss4 /ss4
sudo ln -s /var/www/ss5 /ss5

# sspak
cd /usr/local/bin
curl -sS https://silverstripe.github.io/sspak/install | sudo php


# test up test site. 
cd /var/www/ss4
echo "127.0.0.1 test.ss4" | sudo tee -a /etc/hosts
sudo chown www-data /var/www/ss4 -R #must be all www-data
composer create-project silverstripe/installer test 4.7
cd test
ls
# install sake
cd /var/www/ss4/test
sudo ./vendor/bin/sake installsake


