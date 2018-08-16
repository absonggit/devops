#!/bin/bash  
#date 2016-8-16

Zabbix_versoin="zabbix-3.4.11"
_PWD=$(pwd)
_CONF="$_PWD/conf"
_CMD_SHELL="$_PWD/conf/shell"
_Items="$_PWD/conf/items"
_Install_Dir="/usr/local/zabbix"

read -p "please input the zabbix server IP:" SERIP
read -p "please input your hostname:" Client


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

echo "######################################################################################################################"
echo "###                                       ZABBIX MONITORING ITEMS CHOOSE                                           ###"
echo "######################################################################################################################"                         

while :; do echo
    read -p "Do you want to monitoring TCP status,disk io? [y/n]: " TCP_yn
    if [[ ! $TCP_yn =~ ^[y,n]$ ]];then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        if [ "$TCP_yn" == 'y' ];then
	cp  $_CMD_SHELL/tcp_status $_Install_Dir/bin/
	cp  $_CMD_SHELL/discover_disk.pl $_Install_Dir/bin/

	cp  $_Items/tcp $_Install_Dir/etc/zabbix_agentd.conf.d/
	cp  $_Items/diskio $_Install_Dir/etc/zabbix_agentd.conf.d/

	chmod 755 /$_Install_Dir/bin/tcp_status 
	chmod 755 $_Install_Dir/bin/discover_disk.pl
         fi
        break
    fi
done

while :; do echo
    read -p "Do you want to monitoring TCP port and services? [y/n]: " TCP_port
    if [[ ! $TCP_port =~ ^[y,n]$ ]];then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        if [ "$TCP_port" == 'y' ];then
	cp  $_CMD_SHELL/ports.py $_Install_Dir/bin/

	cp  $_Items/check_port $_Install_Dir/etc/zabbix_agentd.conf.d/
        #sed -i '/root    ALL=(ALL)       ALL/azabbix ALL=NOPASSWD: \/usr\/bin\/python' /etc/sudoers
	chmod 755 /$_Install_Dir/bin/ports.py 
         fi
        break
    fi
done

while :; do echo
    read -p "Do you want to monitoring mysql master ? [y/n]: " sqlm_yn
    if [[ ! $sqlm_yn =~ ^[y,n]$ ]];then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        if [ "$sqlm_yn" == 'y' ];then
	cp  $_Items/mysql $_Install_Dir/etc/zabbix_agentd.conf.d/

         fi
        break
    fi
done

while :; do echo
    read -p "Do you want to monitoring mysql slave ? [y/n]: " sa_yn
    if [[ ! $sa_yn =~ ^[y,n]$ ]];then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        if [ "$sa_yn" == 'y' ];then
	cp  $_Items/mysql_rep $_Install_Dir/etc/zabbix_agentd.conf.d/

         fi
        break
    fi
done

while :; do echo
    read -p "Do you want to monitoring nginx ? [y/n]: " ng_yn
    if [[ ! $ng_yn =~ ^[y,n]$ ]];then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        if [ "$ng_yn" == 'y' ];then
	cp  $_Items/nginx $_Install_Dir/etc/zabbix_agentd.conf.d/
	cp  $_CMD_SHELL/nginx_status.sh $_Install_Dir/bin/

	chmod 755 $_Install_Dir/bin/nginx_status.sh
         fi
        break
    fi
done

while :; do echo
    read -p "Do you want to monitoring tomcat state ? [y/n]: " tomcat_yn
    if [[ ! $ng_yn =~ ^[y,n]$ ]];then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        if [ "$ng_yn" == 'y' ];then
	cp  $_Items/jvm $_Install_Dir/etc/zabbix_agentd.conf.d/
	cp  $_CMD_SHELL/jstat.sh $_Install_Dir/bin/
	cp  $_CMD_SHELL/jvm_status.sh $_Install_Dir/bin/
	cp  $_CMD_SHELL/jvm_name.sh $_Install_Dir/bin/
	cp  $_CMD_SHELL/jvm_thread_num.sh $_Install_Dir/bin/

	chmod 755 $_Install_Dir/bin/j*.sh
         fi
        break
    fi
done

while :; do echo
    read -p "Do you want to monitoring php ? [y/n]: " php_yn
    if [[ ! $php_yn =~ ^[y,n]$ ]];then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        if [ "$php_yn" == 'y' ];then
	cp  $_Items/php $_Install_Dir/etc/zabbix_agentd.conf.d/
	cp  $_CMD_SHELL/php-fpm_status.sh $_Install_Dir/bin/
	
	chmod 755 $_Install_Dir/bin/php-fpm_status.sh
         fi
        break
    fi
done

while :; do echo
    read -p "Do you want to monitoring apache ? [y/n]: " ap_yn
    if [[ ! $ap_yn =~ ^[y,n]$ ]];then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        if [ "$ap_yn" == 'y' ];then
	cp  $_Items/apache $_Install_Dir/etc/zabbix_agentd.conf.d/
	cp  $_CMD_SHELL/apache_status.sh $_Install_Dir/bin/
	
	chmod 755 $_Install_Dir/bin/apache_status.sh
         fi
        break
    fi
done


while :; do echo
    read -p "Do you want to monitoring memcached ? [y/n]: " me_yn
    if [[ ! $me_yn =~ ^[y,n]$ ]];then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        if [ "$me_yn" == 'y' ];then
	cp  $_CMD_SHELL/memcached_stats.pl $_Install_Dir/bin/
	cp  $_Items/memcached $_Install_Dir/etc/zabbix_agentd.conf.d/
	
	chmod 755 $_Install_Dir/bin/memcached_stats.pl
         fi
        break
    fi
done

while :; do echo
    read -p "Do you want to monitoring redis ? [y/n]: " red_yn
    if [[ ! $red_yn =~ ^[y,n]$ ]];then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        if [ "$red_yn" == 'y' ];then
    cp $_CMD_SHELL/redis.sh $_Install_Dir/bin/redis.sh
	cp $_Items/redis $_Install_Dir/etc/zabbix_agentd.conf.d/
    chmod 755 $_Install_Dir/bin/redis.sh
	fi
        break
    fi
done


/etc/init.d/zabbix_agentd restart
