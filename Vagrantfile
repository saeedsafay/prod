# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "hashicorp/bionic64"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  config.vm.network "forwarded_port", guest: 80, host: 9092, host_ip: "127.0.0.1"
  
  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder '.', '/var/www/'

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Customize the amount of memory on the VM:
    vb.memory = "1024"
	
	vb.name = "Novin-Dashboard-box"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
	sudo apt-get install -y apache2 php7.2 php-pear php7.2-curl php-memcached memcached libmemcached-tools php7.2-mbstring php7.2-gd mysql-server php7.2-mysql zip unzip php-zip

	#Setup xDebug
    sudo apt-get install php7.2-xdebug
    echo "
    zend_extension=xdebug.so
    xdebug.remote_enable=true
    xdebug.remote_connect_back=true
    xdebug.idekey=PHPSTORM
    " > /etc/php/7.2/apache2/conf.d/20-xdebug.ini

    # Configure Apache
    echo "<VirtualHost *:80>
         ServerName test
         DocumentRoot /var/www/public/
         SetEnv "APP_ENV" "test"

         <Directory /var/www/public/>
           AllowOverride All
         </Directory>

         ErrorLog ${APACHE_LOG_DIR}/error.log
         CustomLog ${APACHE_LOG_DIR}/access.log combined

    </VirtualHost>" > /etc/apache2/sites-available/000-default.conf

    a2enmod rewrite
    sudo systemctl restart memcached
    service apache2 restart
	
	if [ -e /usr/local/bin/composer ]; then
		/usr/local/bin/composer self-update
	else
		curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
	fi

    # Reset home directory of vagrant user
    if ! grep -q "cd /var/www" /home/vagrant/.profile; then
    echo "cd /var/www" >> /home/vagrant/.profile
    fi

    sudo mysql -u root -p -e "SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));"

	echo "** Run the following command to install the dependencies, if you haven't already:"
	echo "    vagrant ssh -c 'composer install'"
	echo "** Novin-Naghsh: Visit http://localhost:9092 in your browser to view the application **"

  SHELL
end
