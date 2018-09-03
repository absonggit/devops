#!/bin/bash
idle(){
        wget --quiet -O - http://127.0.0.1:40080/php-fpm_status?auto |grep "idle processes" |awk '{print$3}'
}

total(){
        wget --quiet -O - http://127.0.0.1:40080/php-fpm_status?auto |grep "total processes" |awk '{print$3}'
}

active(){
        wget --quiet -O - http://127.0.0.1:40080/php-fpm_status?auto |grep "active" |awk '{print$3}'|grep -v "process"
}

mactive(){

        wget --quiet -O - http://127.0.0.1:40080/php-fpm_status?auto |grep "max active processes:" |awk '{print$4}'
}

listenqueuelen(){
        wget --quiet -O - http://127.0.0.1:40080/php-fpm_status?auto |grep "listen queue len" |awk '{print$4}'
}

listenqueue(){
        wget --quiet -O - http://127.0.0.1:40080/php-fpm_status?auto |grep "listen queue:"|grep -vE "len|max"|awk '{print$3}'
}

since(){
        wget --quiet -O - http://127.0.0.1:40080/php-fpm_status?auto |grep "start since: " |awk '{print$3}'
}

conn(){
        wget --quiet -O - http://127.0.0.1:40080/php-fpm_status?auto |grep "accepted conn" |awk '{print$3}'
}
max_children(){
        wget --quiet -O - http://127.0.0.1:40080/php-fpm_status?auto |grep "max children reached" |awk '{print$4}'
}
$1

