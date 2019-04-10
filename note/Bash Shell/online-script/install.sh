#!/bin/bash
# Decscription: scripts main entrance
clear

echo -e "
\033[34m============================================================\033[0m
\033[33mcodis_install                    nginx_install\033[0m
    |--> codis-3.2.2                  |--> nginx-1.14.0
    |--> java-1.8.0                   |--> pcre-8.42
    |--> golang-1.9.4                 |--> openssl-1.0.2
    |--> zookeeper-3.4.6

\033[33mdocker_install                   rabbitmq\033[0m
    |--> docker-ce-17.03.2            |--> java-1.8.0
    |--> docker-compose-1.8.0         |--> rabbitmaq-3.7.5

\033[33mftp_install                      redis_install\033[0m
    |--> vsftpd-3.0.2                 |--> redis-4.0.9
    |--> nginx-1.12
\033[33mftp_useradd                      sys_init\033[0m

\033[33mgo_install                       tomcat_install\033[0m
    |--> go-1.9.2                     |--> tomcat-8.5.31

\033[33mjdk_install                      zabbix_install.sh\033[0m
    |--> jdk-1.8.0_144                |--> zabbix-3.4.12

\033[33mjumpserver-agent.sh              zookeeper_install.sh\033[0m
                                      |--> zookeeper-3.4.13
\033[34m============================================================\033[0m
"

scripts=($(ls ./scripts/ | xargs))
PS3="Select the script number to execute:"
select num in ${scripts[*]}
do
  sh ./scripts/$num
  break
done
