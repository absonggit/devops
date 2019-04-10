#!/bin/bash
# Description: install zookeeper standalone.
# Date:
# Author:


# version=1.9.2
if [ ! -d "/data/package" ];then mkdir -p /data/package;fi
cd /data/package
wget https://www.golangtc.com/static/go/1.9.2/go1.9.2.linux-amd64.tar.gz
tar -C /data -zxf go1.9.2.linux-amd64.tar.gz
cat >> /etc/profile << "EOF"

# Go环境变量
export PATH=$PATH:/data/go/bin
export GOPATH=/data
EOF
source /etc/profile
echo
go version
echo
cat << EOF
+-----------------------------------------------------------------+
|                      installed successfully!                    |
+-----------------------------------------------------------------+
EOF
