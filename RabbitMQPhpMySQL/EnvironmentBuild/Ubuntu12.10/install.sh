apt-get install openssh-server -y
export DEBIAN_FRONTEND=noninteractive
echo mysql-server-5.5 mysql-server/root_password password P@ssword1 | debconf-set-selections
echo mysql-server-5.5 mysql-server/root_password_again password P@ssword1 | debconf-set-selections 
apt-get install mysql-server -y
apt-get install apache2 -y
apt-get install php5 libapache2-mod-php5 -y
/etc/init.d/apache2 restart
apt-get install php5-mysql php5-curl php5-cli -y
/etc/init.d/apache2 restart
cd ~
echo -e "<?php\nphpinfo();\n?>" >> info.php
mv info.php /var/www/info.php
apt-get install rabbitmq-server -y
apt-get install git -y
cd ~
git clone git://github.com/videlalvaro/php-amqplib.git
cd ~/php-amqplib
curl --silent https://getcomposer.org/installer | php
php composer.phar install
cp -R ~/php-amqplib/* /var/www/
apt-get install daemontools daemontools-run -y
cd ~
git clone git://github.com/patrickmcclory/CodeSherpa.git
cd CodeSherpa
git config core.sparsecheckout true
echo /RabbitMQPhpMySQL/ > .git/info/sparse-checkout
git read-tree -m -u HEAD
cp -R ~/CodeSherpa/RabbitMQPhpMySQL/DemoApp/* /var/www/
mysql -pP@ssword1 -e "CREATE DATABASE demoDataStore;"
mysql -pP@ssword1 << QUERY_INPUT
use demoDataStore;
CREATE TABLE dataStore(
	uniqueID char(23), 
	randomChar1 char(5),
	randomChar2 char(5)
)
QUERY_INPUT
mysql -pP@ssword1 -e "CREATE USER 'dbUser'@'localhost' IDENTIFIED BY 'P@ssword1';"
mysql -pP@ssword1 -e "GRANT ALL PRIVILEGES ON *.* TO 'dbUser'@'localhost' WITH GRANT OPTION;"
mysql -pP@ssword1 -e "CREATE USER 'dbuser'@'%' IDENTIFIED BY 'P@ssword1';"
mysql -pP@ssword1 -e "GRANT ALL PRIVILEGES ON *.* TO 'dbUser'@'%' WITH GRANT OPTION;"
mkdir /usr/local/bin/daemons
mkdir /usr/local/bin/daemons/supervise
mkdir /usr/local/bin/daemons/supervise/rabbitDBProcessor
mkdir /usr/local/bin/daemons/supervise/rabbitDBProcessor/supervise
mkdir /usr/local/bin/daemons/supervise/rabbitDBProcessor/log
cp -R ~/CodeSherpa/RabbitMQPhpMySQL/Daemon/* /usr/local/bin/daemons/supervise/rabbitDBProcessor
ln -s /usr/local/bin/daemons/supervise/rabbitDBProcessor /etc/service/rabbitDBProcessor
chmod 755 /etc/service/rabbitDBProcessor/run
chmod 755 /etc/service/rabbitDBProcessor/log/run
chmod 755 /var/www/amqp_consumer_non_blocking_mysql.php
cd /etc/service
#svscan &
echo
echo 'You can SSH into this instance on the address below:'
ifconfig | grep 'inet addr' | grep -v '127.0.'
echo
echo 'Happy sandboxing!'
