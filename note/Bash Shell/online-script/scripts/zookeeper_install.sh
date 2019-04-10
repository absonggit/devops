#!/bin/bash
# Description: install zookeeper standalone.
# Date:
# Author:

# version=zookeeper-3.4.13
app_dir=/data/zookeeper
tar zxvf ./package/zookeeper-3.4.13.tar.gz -C ./package/
if [ ! -d "/data" ];then mkdir -p /data/package;fi
mv ./package/zookeeper-3.4.13/ /data/zookeeper
chown -R root:root ${app_dir}

# copy configuration file.
mkdir ${app_dir}/logs
mkdir ${app_dir}/data
cat > ${app_dir}/conf/zoo.cfg << "EOF"
tickTime=2000
initLimit=10
syncLimit=5
clientPort=2181
dataLogDir=/data/zookeeper/logs
dataDir=/data/zookeeper/data
# 1. 如果开启集群，在关闭zk服务器、打开以下注释即可。
# server.1= 192.168.211:2888:3888
# server.2= 192.168.212:2888:3888
# server.3= 192.168.213:2888:3888
EOF

# 2. 若果开启集群、还需要创建ServerID标识
# server.A= B:C:D echo A到每个节点服务器数据目录下的myid文件中
# echo "1" > ${app_dir}/data/myid

# configuration enviromment.
cat >> /etc/profile << 'EOF'

# zookeeper环境变量
export PATH=/data/zookeeper/bin:$PATH
EOF
source /etc/profile

cd ${app_dir}
./bin/zkServer.sh start
./bin/zkServer.sh status

cat << EOF
+-----------------------------------------------------------------+
|                      installed successfully!                    |
+-----------------------------------------------------------------+
EOF
