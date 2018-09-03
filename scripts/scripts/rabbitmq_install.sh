#!/bin/bash
# Description: make install rabbitmq.
# Date: 2018/8/20
# Author: francis

# 安装依赖
yum install -y gcc gcc-c++ glibc-devel make ncurses-devel openssl-devel autoconf java-1.8.0-openjdk-devel xmlto

# 增加rabbitmq的yum源
cat >> /etc/yum.repos.d/rabbitmq-erlang.repo << "EOF"
[rabbitmq-erlang]
name=rabbitmq-erlang
baseurl=https://dl.bintray.com/rabbitmq/rpm/erlang/20/el/7
gpgcheck=1
gpgkey=https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc
repo_gpgcheck=0
enabled=1
EOF

# 安装erlang
$ yum install -y erlang socat

# 下载rabbitmq并安装启动
if [ ! -d "/data/package"];then mkdir -p /data/package;fi
cd /data/package
wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.7.5/rabbitmq-server-generic-unix-3.7.5.tar.xz
tar xvf rabbitmq-server-generic-unix-3.7.5.tar.xz
mv rabbitmq_server-3.7.5 ../rabbitmq

cat >> /etc/profile << 'EOF'

# rabbitmq
export PATH=$PATH:/data/rabbitmq/sbin
EOF
source /etc/profile

# 启动rabbitmq
rabbitmq-server -detached
