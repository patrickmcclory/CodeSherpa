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
apt-get install rabbimq-server
git clone git://github.com/vidlalvaro/php-ampqlib.git
cd /~/php-amqplib
curl --silent https://getcomposer.org/installer | php
php composer.phar install
cd /~ 
apt-get install gcc -y
mkdir -p package
chmod 1755 package
cd package
wget http://cr.yp.to/daemontools/daemontools-0.76.tar.gz
gunzup daemontools-0.76.tar.gz
tar -xpf daemontools-0.76.tar
rm -f daemontools-0.76.tar
cd admin/daemontools-0.76
sed -ie 's/^\(gcc.*\)/\1 -include \/usr\/include\/errno.h' src/conf-cc
package/install
echo
echo 'You can SSH into this instance on the address below:'
ifconfig | grep 'inet addr' | grep -v '127.0.'
echo
echo 'Happy sandboxing!'
