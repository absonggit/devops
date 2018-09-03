#!/bin/sh
jvmname=$1
pid=`ps -ef | grep "$jvmname" | grep -v grep | awk '{print $2}' `
jvm_status=`/usr/java/jdk1.6.0_45/bin/jstack "$pid" > /usr/local/zabbix/bin/jstack.txt`
function all {
    cat /usr/local/zabbix/bin/jstack.txt | grep http|wc -l
         }     
function runnable { 
    cat /usr/local/zabbix/bin/jstack.txt | grep http|grep runnable|wc -l
          }
$2
