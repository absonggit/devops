#!/bin/bash

Zabbix_versoin="zabbix-3.4.11"
_PWD=$(pwd)
_CONF="$_PWD/conf"
_CMD_SHELL="$_PWD/conf/shell"
_Items="$_PWD/conf/items"
_Install_Dir="/usr/local/zabbix"
Client="$(echo -n `curl ip.cn | egrep -o "[1-9]{1,3}"` |tr " " ".")"
SERIP="27.111.239.84"

groupadd zabbix
useradd -g zabbix -s /sbin/nologin zabbix

cd $(pwd)
yum install gcc wget pcre-devel -y
wget http://nchc.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/3.4.11/$Zabbix_versoin.tar.gz
tar xvf $Zabbix_versoin.tar.gz
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
