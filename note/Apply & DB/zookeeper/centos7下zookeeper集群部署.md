# 单节点部署
## 安装
zookeeper需要java支持、所以提前在各节点装好jdk、本实验采用jdk1.8。
```
$ wget http://mirror.rise.ph/apache/zookeeper/zookeeper-3.4.13/zookeeper-3.4.13.tar.gz
$ tar zxvf ./package/zookeeper-3.4.13.tar.gz -C /data/zookeeper
$ mv /data/zookeeper-3.4.13/ /data/zookeeper
$ chown -R root:root /data/zookeeper
$ mkdir /data/zookeeperlogs
$ mkdir /data/zookeeper/data
$ cat >  /data/zookeeper/conf/zoo.cfg << "EOF"
tickTime=2000
initLimit=10
syncLimit=5
clientPort=2181
dataLogDir=/data/zookeeper/logs
dataDir=/data/zookeeper/data
# 如果开启集群，在关闭zk服务器、打开以下注释即可。
# server.1= 192.168.211:2888:3888
# server.2= 192.168.212:2888:3888
# server.3= 192.168.213:2888:3888
EOF

$ cat >> /etc/profile << 'EOF'

# zookeeper环境变量
export PATH=/data/zookeeper/bin:$PATH
EOF
$ source /etc/profile
```

## 启动
```
$ /data/zookeeper/bin/zkServer.sh start
$ /data/zookeeper/bin/zkServer.sh status
```

# 分布式集群部署
## 部署
首先打开配置文件的集群节点server.A=B:C:D
```
# 若果开启集群、还需要创建ServerID标识
# server.A= B:C:D echo A到每个节点服务器数据目录下的myid文件中
$ echo "1" > ${app_dir}/data/myid  //节点1
$ echo "2" > ${app_dir}/data/myid  //节点2
$ echo "3" > ${app_dir}/data/myid  //节点3
```

## 启动测试
```
$ /data/zookeeper/bin/zkServer.sh start
$ /data/zookeeper/bin/zkServer.sh status

# 启动第一台zk服务器可能会报错，等3等3个节点都启动后就不会报错了
# 可以看到主和从的状态
$ /data/zookeeper/bin/zkServer.sh status
ZooKeeper JMX enabled by default
Using config: /data/zookeeper/bin/../conf/zoo.cfg
Mode: follower

$ bin/zkServer.sh status
ZooKeeper JMX enabled by default
Using config: /data/zookeeper/bin/../conf/zoo.cfg
Mode: leader
```

```
# 集群搭建完成后通过客户端脚本，在任意节点建立集群的链接。同时可以看到当前路径为zookeeper.
$ bin/zkCli.sh -server 192.168.153.211

[zk: 192.168.153.211(CONNECTED) 2] ls /
[zookeeper]
```

# 介绍
## zookeeper介绍
zookeeper是一个分布式的开源框架，它能很好的管理集群，而且提供协调分布式应用的基本服务。

它向外部应用暴露一组通用服务——分布式同步（Distributed Synchronization）、命名服务（Naming Service）、集群维护（Group Maintenance）等，简化分布式应用协调及其管理的难度，提供高性能的分布式服务。

zookeeper本身可以以standalone模式（单节点状态）安装运行，不过它的长处在于通过分布式zookeeper集群（一个leader，多个follower），基于一定的策略来保证zookeeper集群的稳定性和可用性，从而实现分布式应用的可靠性。

## zookeeper集群角色介绍
zookeeper集群中主要有两个角色：leader和follower。

领导者（leader）,用于负责进行投票的发起和决议,更新系统状态。

学习者（learner）,包括跟随者（follower）和观察者（observer）。

其中follower用于接受客户端请求并想客户端返回结果,在选主过程中参与投票。

而observer可以接受客户端连接,将写请求转发给leader,但observer不参加投票过程,只同步leader的状态,observer的目的是为了扩展系统,提高读取速度。

## zookeeper集群节点个数
如果要运行zookeeper集群的话，最好部署3，5，7个zookeeper节点。

zookeeper节点部署的越多，服务的可靠性也就越高。当然建议最好是部署奇数个，偶数个不是不可以。但是zookeeper集群是以宕机个数过半才会让整个集群宕机的，所以奇数个集群更佳。

你需要给每个zookeeper 1G左右的内存，如果可能的话，最好有独立的磁盘，因为独立磁盘可以确保zookeeper是高性能的。如果你的集群负载很重，不要把zookeeper和RegionServer运行在同一台机器上面，就像DataNodes和TaskTrackers一样。
