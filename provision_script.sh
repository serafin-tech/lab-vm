#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

cat /vagrant/debconf.txt | debconf-set-selections

apt-get install -qy \
    mc elinks wget curl net-tools vim \
    apache2 libapache2-mod-php7.4 \
    mariadb-server php7.4-mysql phpmyadmin mycli

update-alternatives --set editor /usr/bin/vim.basic
echo "SELECTED_EDITOR=\"/usr/bin/vim.basic\"" > /root/.selected_editor

cp -fv /vagrant/apache-site-default.conf /etc/apache2/sites-available/000-default.conf
cp -fv /etc/phpmyadmin/apache.conf /etc/apache2/conf-enabled/phpmyadmin.conf
service apache2 restart
echo "apache2 restart status $?"

cat /vagrant/mariadb_root.sql | mysql
cp -fv /vagrant/my.cnf /root/.my.cnf
cp -fv /vagrant/my.cnf /home/vagrant/.my.cnf
cp -fv /vagrant/mariadb-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
cp -fv /vagrant/mysql-clients.cnf /etc/mysql/mariadb.conf.d/50-mysql-clients.cnf
openssl req -new -x509 -newkey rsa:2048 -keyout /etc/mysql/server-key.pem -nodes -subj "/CN=dummy/" -batch -out /etc/mysql/server-cert.pem
chgrp -v mysql /etc/mysql/server-key.pem
chmod -v 640 /etc/mysql/server-key.pem
service mariadb restart
echo "mariadb restart status $?"

ln -sv /vagrant/www /home/vagrant/www

mv -v /etc/ssh/sshd_config /etc/ssh/sshd_config.org
sed -e 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config.org > /etc/ssh/sshd_config
service ssh restart
echo "ssh restart status $?"

usermod -aG mysql vagrant

