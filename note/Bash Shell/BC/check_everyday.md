```Shell
#!/bin/bash
#check other item

c_time=`date +%Y:%m:%d-%H:%M:%S`

########## System load average、memory、disk ##########

#check code of bbs directory
server_ip=`ip addr |grep "scope global" |head -1 |awk '{print $2}' |awk -F '/' '{print $1}'`

dic=("113.10.193.50|论坛-千亿|/home/WebSer/bbs/bbs.qy8.us|/home/BACKUP/code/bbs.qy8.us*|/home/BACKUP/db/qy8bbs*"
     "113.10.193.51|论坛-乐虎|/home/WebSer/bbs.lehubbs.com|/home/BACKUP/code/bbs.le*|/home/BACKUP/db/lehubbs*"
     "113.10.193.25|博客-武松|/home/wwwroot/blog.wusong123.com|/home/BACKUP/code/blog.wu*|/home/BACKUP/db/ws*")

     for info in ${dic[@]};do
             dic_ip=`echo $info |awk -F '|' '{print $1}'`
             if [ $server_ip == $dic_ip ];then
                     dic_name=`echo $info |awk -F '|' '{print $2}'`
                     dic_code=`echo $info |awk -F '|' '{print $3}'`
                     dic_code_bak=`echo $info |awk -F '|' '{print $4}'`
                     dic_db_bak=`echo $info |awk -F '|' '{print $5}'`
                     echo -e "\033[33m$dic_name:线上代码\033[0m"
                     ls -lh $dic_code && echo
                     echo -e "\033[33m$dic_name:代码备份\033[0m"
                     du -sh $dic_code_bak && echo
                     if [[ $dic_db_bak == "80.12" ]];then
                             echo -e "\033[31m数据库备份在80.12上\033[0m" && echo
                     else
                             echo -e "\033[33m$dic_name:数据库备份\033[0m"
                             du -sh $dic_db_bak && echo
                     fi
             fi
     done

     ########## System load average、memory、disk ##########

     #System load average
     sys_processor=`cat /proc/cpuinfo |grep "processor" |wc -l`
     load_1=`/usr/bin/uptime |awk -F ':' '{print $5}' |awk -F ',' '{print $1}'`
     load_5=`/usr/bin/uptime |awk -F ':' '{print $5}' |awk -F ',' '{print $2}'`
     load_15=`/usr/bin/uptime |awk -F ':' '{print $5}' |awk -F ',' '{print $3}'`

     echo -e "\033[33m系统1/5/15分钟负载: \033[0m"
     printf "%-19s %-10s \n" "processor: " $sys_processor
     printf "%-19s %-10s \n" "load_1: "$load_1
     printf "%-19s %-10s \n" "load_5: "$load_5
     printf "%-19s %-10s \n" "load_15: "$load_15
     echo

     #System memory
     mem_total=`free -m |grep "Mem:" |awk '{print $2}'`
     mem_use=`free -m |grep "buffers\/cache" |awk '{print $3}'`
     mem_free=`free -m |grep "buffers\/cache" |awk '{print $4}'`

     echo -e "\033[33m系统内存使用情况: \033[0m"
     printf "%-20s %-10s \n" "Memory Total：" $mem_total"M"
     printf "%-20s %-10s \n" "Memory Used：" $mem_use"M"
     printf "%-20s %-10s \n" "Memory Free：" $mem_free"M"
     echo

     #System disk
     #disk_total=0
     #disk_space=`f -h|awk '{print $5}'|sed 's/%//g'|sed '/[a-zA-Z]/d'`
     #for spa in ${disk_space};do
     #       disk_total=$[$disk_total+$spa]
     #done

     echo -e "\033[33m系统磁盘使用情况: \033[0m"
     df -h && echo

     echo "---------------------------------------------$c_time"

```
