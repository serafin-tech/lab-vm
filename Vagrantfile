# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/focal64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  config.vm.network "forwarded_port", guest: 80, host: 8765, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 443, host: 8766, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 3306, host: 8767, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false

    vb.name = "lab-vm"

    # Customize the amount of memory on the VM:
    vb.memory = "1024"
    vb.cpus = "2"
  end

  config.vm.hostname = "lab-vm"
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    apt-get -q update
    export DEBIAN_FRONTEND=noninteractive
    cat /vagrant/debconf.txt | debconf-set-selections
    apt-get install -qy mc elinks wget curl net-tools apache2 libapache2-mod-php7.4 mariadb-server php7.4-mysql phpmyadmin
    cp -fv /vagrant/apache-site-default.conf /etc/apache2/sites-available/000-default.conf
    cp -fv /etc/phpmyadmin/apache.conf /etc/apache2/conf-enabled/phpmyadmin.conf
    service apache2 restart
    cat /vagrant/mariadb_root.sql | mysql
    cp -fv /vagrant/my.cnf /root/.my.cnf
    cp -fv /vagrant/mariadb.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
    service mariadb restart
    curl -s -o /home/vagrant/composer-installer.php https://getcomposer.org/installer
    php /home/vagrant/composer-installer.php > /home/vagrant/composer-installer.php.log
    mv -v /home/vagrant/composer.phar /usr/local/bin/composer
    ln -s /vagrant/www /home/vagrant/www
    mv /etc/ssh/sshd_config /etc/ssh/sshd_config.org
    sed -e 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config.org > /etc/ssh/sshd_config
    service ssh restart
  SHELL

end
