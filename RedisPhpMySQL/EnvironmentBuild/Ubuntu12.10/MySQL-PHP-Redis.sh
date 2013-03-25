export DEBIAN_FRONTEND=noninteractive
echo mysql-server-5.5 mysql-server/root_password password P@ssword1 | sudo debconf-set-selections
echo mysql-server-5.5 mysql-server/root_password_again password P@ssword1 | sudo debconf-set-selections
sudo apt-get install mysql-server -y
sudo apt-get install make gcc -y
wget http://redis.googlecode.com/files/redis-2.6.11.tar.gz
sudo tar xzf redis-2.6.11.tar.gz -C /usr/lib
cd /usr/lib/redis-2.6.11
sudo make
sudo ln -s /usr/lib/redis-2.6.11/src/redis-server /usr/local/bin/redis-server
sudo ln -s /usr/lib/redis-2.6.11/src/redis-cli /usr/local/bin/redis-cli
cd /usr/lib/redis-2.6.11/utils
echo '' | sudo ./install_server.sh
apt-get install apache2 -y
apt-get install php5 libapache2-mod-php5 -y
/etc/init.d/apache2 restart
apt-get install php5-mysql php5-curl php5-xcache -y
/etc/init.d/apache2 restart
cd ~
echo -e "<?php\nphpinfo();\n?>" >> info.php
mv info.php /var/www/info.php