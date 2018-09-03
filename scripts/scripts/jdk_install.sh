#!/bin/bash


tar zxvf ./package/jdk-8u144-linux-x64.tar.gz -C ./package/
if [ ! -d "/data" ];then mkdir -p /data/package;fi
cp -r ./package/jdk1.8.0_144/ /data/jdk8

cat >> /etc/profile << 'EOF'

# jdk环境变量
export JAVA_HOME=/data/jdk8
export JRE_HOME=/data/jdk8
export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib
EOF

source /etc/profile
echo
java -version
echo
