#!/bin/bash
#Description: tomcat切割脚本

log_path=/data/WebServer/dc-chain-service/logs
log_date=catalina.out.`date +%Y-%m-%d-%s`

#创建目录并切割日志
cd ${log_path}
if [ ! -d "./old_log" ];then mkdir ./old_log;fi
/bin/cp catalina.out ${log_date}
echo : > catalina.out

#把7天前的所有日志移到old_log下
/bin/find ${log_path} -maxdepth 1 -type f -name "manager.*.log" -mtime +7 -exec mv {} old_log/ \;
/bin/find ${log_path} -maxdepth 1 -type f -name "localhost_access_log.*.txt" -mtime +7 -exec mv {} old_log/ \;
/bin/find ${log_path} -maxdepth 1 -type f -name "localhost.*.log" -mtime +7 -exec mv {} old_log/ \;
/bin/find ${log_path} -maxdepth 1 -type f -name "host-manager.*.log" -mtime +7 -exec mv {} old_log/ \;
/bin/find ${log_path} -maxdepth 1 -type f -name "catalina.*.log" -mtime +7 -exec mv {} old_log/ \;
/bin/find ${log_path} -maxdepth 1 -type f -name "catalina.out.*" -mtime +7 -exec mv {} old_log/ \;
/bin/find ${log_path} -maxdepth 1 -type f -name "spring-boot-logging.log.*" -mtime +7 -exec mv {} old_log/ \;

#把3个月前的所有日志删除
/bin/find ${log_path}/old_log -type f -mtime +90 | xargs rm -rf
