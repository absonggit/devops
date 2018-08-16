#!/bin/bash
#tomcat_name=`ps -ef | grep java | grep -v grep | awk -F "=" '{print $NF}' | cut -d "/" -f 3`
tomcat_name=`ps -ef | grep java | grep -v grep | grep -v "jvm_status.sh" | awk -F "=" '{print $(NF-1)}' | awk -F / '{print $NF}'|awk '{print $1}'`
flag=0
count=`ps -ef | grep java | grep -v grep | wc -l` 
if [ $count == 0 ];then
exit
fi
echo '{"data":['
echo "$tomcat_name" |while read LINE;do
echo -n '{"{#JVMNAME}":"'$LINE'"}'
flag=`expr $flag + 1`
if [ $flag -lt $count ];then
echo ','
fi
done
echo ']}'
