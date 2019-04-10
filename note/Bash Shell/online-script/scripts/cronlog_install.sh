#!/bin/bash
# Description: 通过cronlog切割tomcat按天切割tomcat日志
# Notice: 基于tomcat8的配置、其他版本不适用


# install crontab
#tar zxvf ./package/cronolog-1.6.2.tar.gz -C ./package/
#cd ./package/cronolog-1.6.2
#./configure && make && make install

# config tomcat catalina.sh
echo "\033[31m请手动替换下面的<tomcat/bin/catalina.sh>配置：\033[0m"
cat << EOF
--------------------------------------------------------------------------------------------
280     UMASK="0027"
替换 ===============>
280     UMASK="0022"

454   touch "$CATALINA_OUT"
替换 ===============>
454   #touch "$CATALINA_OUT"


468       org.apache.catalina.startup.Bootstrap "$@" start \
469       >> "$CATALINA_OUT" 2>&1 "&"
替换 ===============>
469       org.apache.catalina.startup.Bootstrap "$@" start 2>&1 | /usr/local/sbin/cronolog "    $CATALINA_BASE"/logs/catalina.%Y-%m-%d.out >> /dev/null &


478       org.apache.catalina.startup.Bootstrap "$@" start \
479       >> "$CATALINA_OUT" 2>&1 "&"
替换 ===============>
479       org.apache.catalina.startup.Bootstrap "$@" start 2>&1 | /usr/local/sbin/cronolog "    $CATALINA_BASE"/logs/catalina.%Y-%m-%d.out >> /dev/null &
--------------------------------------------------------------------------------------------
EOF
