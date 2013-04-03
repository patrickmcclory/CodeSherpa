apt-get install openssh-server -y
export DEBIAN_FRONTEND=noninteractive
echo mysql-server-5.5 mysql-server/root_password password P@ssword1 | debconf-set-selections
echo mysql-server-5.5 mysql-server/root_password_again password P@ssword1 | debconf-set-selections 
apt-get install mysql-server -y
apt-get install apache2 -y
apt-get install php5 libapache2-mod-php5 -y
/etc/init.d/apache2 restart
apt-get install php5-mysql php5-curl php5-xcache php5-cli -y
/etc/init.d/apache2 restart
cd /~
echo -e "<?php\nphpinfo();\n?>" >> info.php
mv info.php /var/www/info.php
apt-get install rabbitmq-server -y
git clone git://github.com/vidlalvaro/php-ampqlib.git
cd /~/php-amqplib
curl --silent https://getcomposer.org/installer | php
php composer.phar install
cd /~ 
apt-get install daemontools daemontools-run -y
cd /~
git clone git://github.com/patrickmcclory/CodeSherpa.git
cd /~
git config core.sparsecheckout true
echo /RabbitMQPhpMySQL/ > .git/info/sparse-checkout
git read-tree -m -u HEAD
mysql -pP@ssword1 -e "CREATE DATABASE demoDataStore;"
mysql -pP@ssword1 << QUERY_INPUT
use demoDataStore;
CREATE TABLE dataStore(
	uniqueID char(23), 
	randomChar1 char(5),
	randomChar2 char(5)
)
QUERY_INPUT
echo
echo 'You can SSH into this instance on the address below:'
ifconfig | grep 'inet addr' | grep -v '127.0.'
echo
echo 'Happy sandboxing!'
