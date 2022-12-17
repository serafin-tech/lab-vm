# -*- mode: ruby -*-
# vi: set ft=ruby :

post_up_msg = <<MSG
----------------------------------------------------------------
środowisko laboratoryjne do ćwiczeń z baz danych

  - konsola graficzna: http://localhost:8765/phpmyadmin/
  - konsola znakowa 'waniliowa': vagrant ssh
  - konsola znakowa przez przeglądarkę: http://localhost:2022/
  
----------------------------------------------------------------
MSG



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
  #config.vm.box = "ubuntu/focal64"
  config.vm.box = "debian/bullseye64"
  config.vm.post_up_message = $post_up_msg

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  config.vm.network "forwarded_port", guest: 80, host: 8765, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 443, host: 8766, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 3306, host: 8767, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 3306, host: 3306, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 8080, host: 8080, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 2022, host: 2022, host_ip: "127.0.0.1"

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
  config.vm.provision "shell", inline: "apt-get -q update", run: "once"

  config.vm.provision "shell", path: "provision_script.sh"


end
