#!/bin/bash

sudo rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm
sudo yum -y install php55w php55w-pecl-imagick php55w-pecl-memcache memcached

replace "memory_limit = 128M" "memory_limit = 256M" -- /etc/php.ini
replace ";date.timezone =" "date.timezone = America/New_York" -- /etc/php.ini

sudo yum -y install mysql mysql-server httpd varnish


sudo chkconfig mysqld on
sudo /etc/init.d/mysqld start


sudo /usr/bin/mysqladmin -u root -h vagrant-centos65.vagrantup.com password 'cfrdevops'
sudo echo "127.0.0.1  vagrant-centos65.vagrantup.com devops-test.cfr.dev" >> /etc/hosts

mysql -u root -pcfrdevops --execute="CREATE USER 'cfrtest'@'localhost' IDENTIFIED BY 'cfrtest';"


# httpd config
# cp devops-test.conf to /etc/httpd/conf
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.original
replace "Listen 80" "Listen 8080" -- /etc/httpd/conf/httpd.conf
echo "Include conf/devops-test.conf" >> /etc/httpd/conf/httpd.conf

mkdir -p /var/www/sites/devops-test.cfr.dev
echo "<html><body>CFR Devops Test</body></html>" >> /var/www/sites/devops-test.cfr.dev/index.html

# varnish config
# copy varnish template into /etc/varnish
mv /etc/varnish/default.vcl /etc/varnish/default.vcl.original
ln -s /etc/varnish/default.vcl.cfrdevops /etc/varnish/default.vcl
replace "VARNISH_LISTEN_PORT=6081" "VARNISH_LISTEN_PORT=80" -- /etc/sysconfig/varnish

# memcache2 config
cp /etc/init.d/memcached /etc/init.d/memcached2 -fv
cp /etc/sysconfig/memcached /etc/sysconfig/memcached2 -fv
cp /var/run/memcached/memcached.pid cp /var/run/memcached/memcached2.pid
touch /var/lock/subsys/memcached2

replace "/etc/sysconfig/memcached" "/etc/sysconfig/memcached2" -- /etc/init.d/memcached2
replace "/var/run/memcached/memcached.pid" "/var/run/memcached/memcached2.pid" -- /etc/init.d/memcached2
replace "/var/lock/subsys/memcached2" "/var/lock/subsys/memcached2" -- /etc/init.d/memcached2

replace "11211" "11212" -- /etc/init.d/memcached2
replace "11211" "11212" -- /etc/sysconfig/memcached2

# memcache3 config
cp /etc/init.d/memcached /etc/init.d/memcached3 -fv
cp /etc/sysconfig/memcached /etc/sysconfig/memcached3 -fv
cp /var/run/memcached/memcached.pid cp /var/run/memcached/memcached3.pid
touch /var/lock/subsys/memcached3

replace "/etc/sysconfig/memcached" "/etc/sysconfig/memcached3" -- /etc/init.d/memcached3
replace "/var/run/memcached/memcached.pid" "/var/run/memcached/memcached3.pid" -- /etc/init.d/memcached3
replace "/var/lock/subsys/memcached" "/var/lock/subsys/memcached3" -- /etc/init.d/memcached3

replace "11211" "11213" -- /etc/init.d/memcached3
replace "11211" "11213" -- /etc/sysconfig/memcached3


chkconfig memcached on
/etc/init.d/memcached start
chkconfig memcached2 on
/etc/init.d/memcached2 start
chkconfig memcached3 on
/etc/init.d/memcached3 start

chkconfig httpd on
service httpd restart

chkconfig varnish on
service varnish start

# elasticsearch config
# cp elasticsearch.repo to /etc/yum.repos.d
yum install java-1.7.0-openjdk -y
yum install elasticsearch -y
chkconfig --add elasticsearch
service elasticsearch start 

# composer config
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
ln -s /usr/local/bin/composer /usr/bin/composer

# drush config
curl -sS http://files.drush.org/drush.phar -o /tmp/drush.phar
php /tmp/drush.phar core-status
chmod +x /tmp/drush.phar
sudo mv /tmp/drush.phar /usr/local/bin/drush
ln -s /usr/local/bin/drush /usr/bin/drush
drush init

echo "PATH=/sbin:/bin" > /var/spool/cron/root
echo "*/2 * * * * service memcached restart && service memcached2 restart && service memcached3 restart >/dev/null 2&>1" >> /var/spool/cron/root


yum -y install mod_ssl
