
# kafka集群
|IP|HOSTNAME|SOFTWARE|
|:--|:--|:--|
|2.2.2.11|node1.com|kafka1 zookeeper1|
|2.2.2.12|node2.com|kafka2 zookeeper2|
|2.2.2.13|node3.com|kafka3 zookeeper3|
---
## 配置zookeeper集群(yum源)
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
## 安装配置kafka
```
all-node# wget http://www-us.apache.org/dist/kafka/2.0.0/kafka_2.12-2.0.0.tgz
all-node# tar xf kafka_2.12-2.0.0.tgz -C /opt
all-node# mv /opt/kafka_2.12-2.0.0/ /opt/kafka
all-node# cd /opt/kafka
all-node# egrep -v "^#|^$" config/server.properties
broker.id=1  #节点间的数字不一样即可
listeners=PLAINTEXT://2.2.2.11:9092 #IP随不同节点的IP变化
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

all-node# ./bin/kafka-server-start.sh -daemon /opt/kafka/config/server.properties

all-node# lsof -i:9092
COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
java    2064 root  100u  IPv6  23904      0t0  TCP kafka.node1:XmlIpcRegSvc (LISTEN)
java    2064 root  116u  IPv6  23911      0t0  TCP kafka.node1:52468->kafka.node1:XmlIpcRegSvc (ESTABLISHED)
java    2064 root  117u  IPv6  23912      0t0  TCP kafka.node1:XmlIpcRegSvc->kafka.node1:52468 (ESTABLISHED)
```
## 测试
```
创建topic
./bin/kafka-topics.sh --create --zookeeper 2.2.2.11:2181 --replication-factor 1 --partitions 1 --topic test
发送消息，会进入交互模式，可以输入任意的字符
./bin/kafka-console-producer.sh --broker-list 2.2.2.12:9092 --topic test
消费消息，会得到刚才输入的字符
./bin/kafka-console-consumer.sh --bootstrap-server 2.2.2.13:9092 --topic test --from-beginning
```
