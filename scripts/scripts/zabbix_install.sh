#!/bin/bash


Zabbix_versoin="zabbix-3.4.12"
_PWD=$(pwd)
_CONF="$_PWD/conf/zabbix"
_CMD_SHELL="$_PWD/conf/zabbix/shell"
_Items="$_PWD/conf/zabbix/items"
_Install_Dir="/usr/local/zabbix"
Client="$(echo -n `curl ip.cn | egrep -o "[0-9]{1,3}"` |tr " " ".")"
SERIP="2.2.2.128"

groupadd zabbix
useradd -g zabbix -s /sbin/nologin zabbix

yum install gcc wget pcre-devel -y

tar xvf ${_PWD}/package/${Zabbix_versoin}.tar.gz
cd $(pwd)/$Zabbix_versoin
./configure --prefix=/usr/local/zabbix --enable-agent
make
make install


cd ../
\cp -rf $_CONF/zabbix_agentd.conf /usr/local/zabbix/etc/
cp $_CONF/zabbix_agentd /etc/init.d/

sed -i "s/Server=172.0.0.1/Server=$SERIP/g" /usr/local/zabbix/etc/zabbix_agentd.conf
sed -i "s/Hostname=test/Hostname=$Client/g" /usr/local/zabbix/etc/zabbix_agentd.conf
sed -i "s/ServerActive=172.0.0.1/ServerActive=$SERIP:10051/g" /usr/local/zabbix/etc/zabbix_agentd.conf
chmod a+x /etc/init.d/zabbix_agentd
chkconfig --add zabbix_agentd
chkconfig zabbix_agentd on

/etc/init.d/zabbix_agentd start
netstat -tunlp | grep zabbix

# COPY ZABBIX MONITORING ITEMS
for file in `ls $_CMD_SHELL`;do
	cp  $_CMD_SHELL/* $_Install_Dir/bin/
	chmod 755 /$_Install_Dir/bin/$file
done
cp  $_Items/* $_Install_Dir/etc/zabbix_agentd.conf.d/

/etc/init.d/zabbix_agentd restart
