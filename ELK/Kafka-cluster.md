
# kafka集群
|IP|HOSTNAME|SOFTWARE|
|:--|:--|:--|
|2.2.2.11|node1.com|kafka1 zookeeper1|
|2.2.2.12|node2.com|kafka2 zookeeper2|
|2.2.2.13|node3.com|kafka3 zookeeper3|
---
## 安装配置zookeeper集群
```
all-node# vim /etc/yum.repos.d/mesosphere.repo
[mesosphere]
name=Mesosphere Packages for EL 7 - $basearch
baseurl=http://repos.mesosphere.io/el/7/$basearch/
enabled=1
gpgcheck=0

[mesosphere-noarch]
name=Mesosphere Packages for EL 7 - noarch
baseurl=http://repos.mesosphere.io/el/7/noarch/
enabled=1
gpgcheck=0

[mesosphere-source]
name=Mesosphere Packages for EL 7 - $basearch - Source
baseurl=http://repos.mesosphere.io/el/7/SRPMS/
enabled=0
gpgcheck=0

all-node# yum install java-1.8.0-openjdk -y
all-node# yum install mesosphere-zookeeper -y
all-node# vim /etc/zookeeper/conf/zoo.cfg
maxClientCnxns=50
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/var/lib/zookeeper
clientPort=2181
server.1=2.2.2.11:2888:3888
server.2=2.2.2.12:2888:3888
server.3=2.2.2.13:2888:3888

node1# echo 1 > /var/lib/zookeeper/myid
node2# echo 2 > /var/lib/zookeeper/myid
node3# echo 3 > /var/lib/zookeeper/myid
all-node# systemctl start zookeeper
all-node# lsof -i:2181
COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
java    2017 root   23u  IPv6  22946      0t0  TCP *:eforward (LISTEN)
```
## 安装配置kafka集群
```
rpm版安装:
all-node# wget https://raw.githubusercontent.com/absonggit/devops/master/ELK/kafka-1.0.1-2.x86_64.rpm
all-node# yum install kafka-1.0.1-2.x86_64.rpm -y

默认位置：
二进制文件：/opt/kafka
数据：/var/lib/kafka
logs：/var/log/kafka
configs：/etc/kafka，/etc/sysconfig/kafka

二进制版安装:
all-node# wget http://www-us.apache.org/dist/kafka/2.0.0/kafka_2.12-2.0.0.tgz
all-node# tar xf kafka_2.12-2.0.0.tgz -C /opt
all-node# mv /opt/kafka_2.12-2.0.0/ /opt/kafka
all-node# cd /opt/kafka

配置：
all-node# egrep -v "^#|^$" config/server.properties
broker.id=1  #节点间的数字不一样即可
listeners=PLAINTEXT://2.2.2.11:9092 #IP为本机IP
num.network.threads=3
num.io.threads=8
socket.send.buffer.bytes=102400
socket.receive.buffer.bytes=102400
socket.request.max.bytes=104857600
log.dirs=/opt/kafka/logs/kafka-logs
num.partitions=1
num.recovery.threads.per.data.dir=1
offsets.topic.replication.factor=1
transaction.state.log.replication.factor=1
transaction.state.log.min.isr=1
log.retention.hours=168
log.segment.bytes=1073741824
log.retention.check.interval.ms=300000
zookeeper.connect=2.2.2.11:2181,2.2.2.12:2181,2.2.2.13:2181
zookeeper.connection.timeout.ms=6000
group.initial.rebalance.delay.ms=0


---------------------------
kafka配置详解
#当前机器在集群中的唯一标识，和zookeeper的myid性质一样
broker.id=1
#当前kafka对外提供服务的端口默认是9092
port=19092
#这个参数默认是关闭的，在0.8.1有个bug，DNS解析问题，失败率的问题。
host.name=192.168.1.224
#这个是borker进行网络处理的线程数
num.network.threads=3
#这个是borker进行I/O处理的线程数
num.io.threads=8
#消息存放的目录，这个目录可以配置为“，”逗号分割的表达式，上面的num.io.threads要大于这个目录的个数这个目录，如果配置多个目录，新创建的topic他把消息持久化的地方是，当前以逗号分割的目录中，那个分区数最少就放那一个
log.dirs=/usr/local/kafka/kafka_2.11-0.9.0.1/kafka_log
#发送缓冲区buffer大小，数据不是一下子就发送的，先回存储到缓冲区了到达一定的大小后在发送，能提高性能
socket.send.buffer.bytes=102400
#kafka接收缓冲区大小，当数据到达一定大小后在序列化到磁盘
socket.receive.buffer.bytes=102400
#这个参数是向kafka请求消息或者向kafka发送消息的请请求的最大数，这个值不能超过java的堆栈大小
socket.request.max.bytes=104857600
#默认的分区数，一个topic默认1个分区数
num.partitions=1
#默认消息的最大持久化时间，168小时，7天
log.retention.hours=168
#消息保存的最大值5M
message.max.byte=5242880
#kafka保存消息的副本数，如果一个副本失效了，另一个还可以继续提供服务
default.replication.factor=2
#取消息的最大直接数
replica.fetch.max.bytes=5242880
#这个参数是：因为kafka的消息是以追加的形式落地到文件，当超过这个值的时候，kafka会新起一个文件
log.segment.bytes=1073741824
#每隔300000毫秒去检查上面配置的log失效时间（log.retention.hours=168 ），到目录查看是否有过期的消息如果有，删除
log.retention.check.interval.ms=300000
#是否启用log压缩，一般不用启用，启用的话可以提高性能
log.cleaner.enable=false
#设置zookeeper的连接端口
zookeeper.connect=192.168.1.224:2181,192.168.1.225:2181,192.168.1.226:2181


---------------------------

启动服务
二进制版：
all-node# ./bin/kafka-server-start.sh -daemon /opt/kafka/config/server.properties
rpm版：
all-node# systemctl start kafka

all-node# lsof -i:9092
COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
java    2064 root  100u  IPv6  23904      0t0  TCP kafka.node1:XmlIpcRegSvc (LISTEN)
java    2064 root  116u  IPv6  23911      0t0  TCP kafka.node1:52468->kafka.node1:XmlIpcRegSvc (ESTABLISHED)
java    2064 root  117u  IPv6  23912      0t0  TCP kafka.node1:XmlIpcRegSvc->kafka.node1:52468 (ESTABLISHED)
```
## 测试
```
创建topic
/opt/kafka/bin/kafka-topics.sh --create --zookeeper 2.2.2.11:2181 --replication-factor 3 --partitions 1 --topic test
发送消息，会进入交互模式，可以输入任意的字符
/opt/kafka/bin/kafka-console-producer.sh --broker-list 2.2.2.12:9092 --topic test
消费消息，会得到刚才输入的字符
/opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server 2.2.2.13:9092 --topic test --from-beginning
```
