#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

debconf-set-selections <<EOT
dbconfig-common	dbconfig-common/mysql/admin-pass	password	Som3Passw0rd
dbconfig-common	dbconfig-common/mysql/admin-user	string	root
dbconfig-common	dbconfig-common/mysql/app-pass	password	Som3Passw0rd
phpmyadmin	phpmyadmin/mysql/app-pass	password	Som3Passw0rd
phpmyadmin	phpmyadmin/app-password-confirm	password	Som3Passw0rd
phpmyadmin	phpmyadmin/password-confirm	password	Som3Passw0rd
phpmyadmin	phpmyadmin/mysql/admin-pass	password	Som3Passw0rd
phpmyadmin	phpmyadmin/dbconfig-install	boolean	        true
phpmyadmin	phpmyadmin/reconfigure-webserver        multiselect     apache2
EOT

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

cp -fv /vagrant/mariadb-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
cp -fv /vagrant/mysql-clients.cnf /etc/mysql/mariadb.conf.d/50-mysql-clients.cnf
openssl req -new -x509 -newkey rsa:2048 -keyout /etc/mysql/server-key.pem -nodes -subj "/CN=dummy/" -batch -out /etc/mysql/server-cert.pem
chgrp -v mysql /etc/mysql/server-key.pem
chmod -v 640 /etc/mysql/server-key.pem
service mariadb restart
echo "mariadb restart status $?"

#cat /vagrant/mariadb_root.sql | mysql
mysql <<EOT
ALTER USER 'root'@'localhost' IDENTIFIED BY 'Som3Passw0rd';
CREATE OR REPLACE USER 'root'@'%' IDENTIFIED BY 'Som3Passw0rd';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
FLUSH PRIVILEGES;
EOT

#cp -fv /vagrant/my.cnf /root/.my.cnf
cat <<EOT > /root/.my.cnf
[client]
user=root
password=Som3Passw0rd
EOT

#cp -fv /vagrant/my.cnf /home/vagrant/.my.cnf
cat <<EOT > /home/vagrant/.my.cnf
[client]
user=root
password=Som3Passw0rd
EOT

ln -sv /vagrant/www /home/vagrant/www

mv -v /etc/ssh/sshd_config /etc/ssh/sshd_config.org
sed -e 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config.org > /etc/ssh/sshd_config
service ssh restart
echo "ssh restart status $?"

usermod -aG mysql vagrant

# student
useradd -m -s /bin/bash student
echo student:Som3Passw0rd | chpasswd
usermod -aG mysql student
echo "student ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/student

cat <<EOT > /home/student/.my.cnf
[client]
user=root
password=Som3Passw0rd
EOT

mysql < /vagrant/lab_db_v3.sql
