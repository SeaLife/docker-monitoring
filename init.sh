#!/bin/bash

# Monitoring INIT

cd /var/www/html

if [ ! -d /data ]; then
	mkdir /data
	chmod 777 /data
fi

if [ ! -f /sbin/sendmail ]; then
	apt-get install sendmail -y
fi

a2enmod rewrite

# timezone (Europe/Berlin)
unlink /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime

if [ -f /var/www/html/index.php ]; then
	git pull
else
	rm -rf *

	git clone https://git.r3ktm8.de/php-framework/Core.git .

	git submodule init
	git submodule update

	chmod +w .
	chmod +x .
fi

ln -s /data/config.ini config.ini

cd /var/www/html/addons

if [ ! -d Monitoring ]; then
	git clone https://git.r3ktm8.de/php-framework/Monitoring.git
else
	cd Monitoring
	git pull
fi

cd /var/www/html/addons

if [ ! -d PermissionSystem ]; then
        git clone https://git.r3ktm8.de/php-framework/PermissionSystem.git
else
        cd PermissionSystem
        git pull
fi

echo "$(date) - Updated System ...."

cd /var/www/html
sh setup.sh

# Start System ...

if [ ! -f /var/www/html/index.php ]; then
	exit 1
fi

/start.sh
