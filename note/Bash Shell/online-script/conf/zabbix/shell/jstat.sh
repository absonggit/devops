#!/bin/bash
tomcat_name=`ps -ef | grep java | grep -v grep | grep -v "jvm_status.sh" | awk -F "=" '{print $(NF-1)}' | awk -F / '{print $NF}'|awk '{print $1}'`

for t in ${tomcat_name[@]};do
        t_id=`ps -ef | grep  "$t/" | grep -v "grep" | awk '{print $2}'`
        /usr/java/jdk1.6.0_45/bin/jstat -gc $t_id | awk 'BEGIN{FS=" "}{for(i = 1;i <= NF;i++) {array[i,NR]=$i}}END {for(i = 1;i <= NF;i++) {for(j = 1;j <= NR;j++) {printf "%s ",array[i,j]}printf "\n"}}' > /usr/local/zabbix/txt/"$t".gc
done

