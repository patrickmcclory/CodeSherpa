apt-get install git -y
git clone git://github.com/patrickmcclory/RandomResearchAndDevelopment /~
cd /~
git config core.sparsecheckout true
echo /RedisPhpMySQL/ > .git/info/sparse-checkout
echo /RandomDataSets/2013flightdata.tgz >> .git/info/sparse-checkout
git read-tree -m -u HEAD
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
cd /~
echo -e "<?php\nphpinfo();\n?>" >> info.php
mv info.php /var/www/info.php
cp -R /~/RedisPhpMySQL/DemoApp/* /var/www/ 
apt-get install php-pear -y
pear channel-discover pear.nrk.io
pear install nrk/Predis
cd /usr/src
[ -d Rediska ] || git clone git://github.com/Shumkov/Rediska.git
cd Rediska && git pull && rsync -a ./library/ /usr/share/php
cd /~/RandomDataSets
tar xvf 2013flightdata.tgz
mysql -pP@ssword1 -e "CREATE DATABASE flightStats;"
mysql -pP@ssword1 << QUERY_INPUT
USE flightStats; 
CREATE TABLE ontimeData (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	YEAR int,
	UNIQUE_CARRIER varchar(2),
	AIRLINE_ID varchar(6),
	TAIL_NUM varchar(6),
	FL_NUM int,
	ORIGIN_AIRPORT int,
	ORIGIN_CITY int,
	DEST_AIRPORT int, 
	DEST_CITY int, 
	DEP_DELAY int, 
	DEP_DELAY_NEW int, 
	DEP_DEL15 bit,
	DEP_DELAY_GROUP int, 
	TAXI_OUT int,
	WHEELS_OFF varchar(4),
	WHEELS_ON varchar(4),
	TAXI_IN int, 
	ARR_TIME varchar(4),
	ARR_DELAY int, 
	ARR_DELAY_NEW int, 
	ARR_DEL15 bit, 
	CANCELLED bit, 
	CANCELLATION_CODE varchar(1), 
	DIVERTED bit
);
QUERY_INPUT
mysql -pP@ssword1 -e "CREATE USER 'dbUser'@'localhost' IDENTIFIED BY 'P@ssword1';"
mysql -pP@ssword1 -e "GRANT ALL PRIVILEGES ON *.* TO 'dbUser'@'localhost' WITH GRANT OPTION;"
mysql -pP@ssword1 -e "CREATE USER 'dbuser'@'%' IDENTIFIED BY 'P@ssword1';"
mysql -pP@ssword1 -e "GRANT ALL PRIVILEGES ON *.* TO 'dbUser'@'%' WITH GRANT OPTION;"