#!/bin/bash
t=$1
jvm_key=$2
cat /usr/local/zabbix/txt/"$t".gc | grep -w "$jvm_key" | awk '{print $2}'
