
## ELK + Filebeat + Kafka 日志收集分析系统

- Elasticsearch 是基于 JSON 的分布式搜索和分析引擎，专为实现水平扩展、高可用和管理便捷性而设计。
- Logstash 是动态数据收集管道，拥有可扩展的插件生态系统，能够与 Elasticsearch 产生强大的协同作用。
- Kibana 能够以图表的形式呈现数据，并且具有可扩展的用户界面，供您全方位配置和管理Elastic Stack 。
- Filebeat 将为您提供一种轻量型方法，用于转发和汇总日志与文件，让简单的事情不再繁杂。
- Kafka是一个分布式发布 - 订阅消息系统和一个强大的队列，可以处理大量的数据，并使您能够将消息从一个端点传递到另一个端点。
--------------

#### Filebeat(日志收集) ---> Kafka(日志接收) ---> Logstash(日志过滤) ---> Elasticsearch(日志分析) ---> Kibana(日志展现)


## 配置清华镜像站yum源
```
[root@elk ~]# ntpdate 0.centos.pool.ntp.org
[root@elk ~]# vim /etc/yum.repos.d/elk.repo
[elk]
name=elk
baseurl=https://mirrors.tuna.tsinghua.edu.cn/elasticstack/yum/elastic-6.x/
enable=1
gpgcheck=0
```
## 环境配置
```
[root@elk ~]# vim /etc/security/limits.conf
* hard nofile 65536
* soft nofile 65536
* soft nproc  65536
* hard nproc  65536

[root@elk ~]# vim /etc/sysctl.conf
vm.max_map_count = 262144
net.core.somaxconn=65535
net.ipv4.ip_forward = 1

[root@elk ~]# sysctl -p
[root@elk ~]# systemctl disable firewalld
[root@elk ~]# systemctl stop firewalld
[root@elk ~]# iptables -F
[root@elk ~]# yum install java-1.8.0-openjdk -y
```

## 安装配置Elasticsearch Logstash Kibana Filebeat
```
[root@elk ~]# yum install elasticsearch logstash kibana nodejs filebeat -y

配置并启动服务

**Elasticsearch**

[root@elk ~]# grep -v ^# /etc/elasticsearch/elasticsearch.yml
cluster.name: elk-stack
node.name: elk.node1
path.data: /var/lib/elasticsearch
path.logs: /var/log/elasticsearch
network.host: 0.0.0.0
http.port: 9200
discovery.zen.ping.unicast.hosts: ["2.2.2.10:9300"]
discovery.zen.minimum_master_nodes: 1

[root@elk ~]# systemctl start elasticsearch
[root@elk ~]# ss -ntlup| grep -E "9200|9300"
tcp    LISTEN     0      65535    :::9200                 :::*                   users:(("java",pid=1624,fd=184))
tcp    LISTEN     0      65535    :::9300                 :::*                   users:(("java",pid=1624,fd=183))

**Kibana**

[root@elk ~]# egrep -v "^#|^$" /etc/kibana/kibana.yml
server.port: 5601
server.host: "0.0.0.0"
elasticsearch.url: "http://2.2.2.10:9200"
kibana.index: ".kibana"

**汉化Kibana**
[root@elk ~]# yum install -y git
[root@elk ~]# git clone https://github.com/anbai-inc/Kibana_Hanization.git
[root@elk ~]# cd Kibana_Hanization
[root@elk ~]# python main.py /usr/share/kibana

[root@elk ~]# systemctl restart kibana
[root@elk ~]# ss -ntlup| grep 5601
tcp    LISTEN     0      511       *:5601                  *:*                   users:(("node",pid=1885,fd=12))

**Logstash**

[root@elk ~]# echo 'path.config: /etc/logstash/conf.d' >>/etc/logstash/logstash.yml

添加日志处理文件
[root@elk ~]# vim /etc/logstash/conf.d/local_syslog.conf
input {
#filebeat客户端
  beats {
     port => 5044
  }
}

 #筛选
#filter { }

output {
# 输出到es
  elasticsearch {
    hosts => ["http://2.2.2.10:9200"]
    index => "syslog-%{+YYYY.MM.dd}"
  }

}

[root@elk ~]# systemctl start logstash
[root@elk ~]# lsof -i:5044
COMMAND  PID     USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
java    2427 logstash   88u  IPv6  27356      0t0  TCP *:lxi-evntsvc (LISTEN)

**Filebeat**

[root@elk ~]# vim /etc/filebeat/filebeat.yml
filebeat.inputs:
- type: log
  enabled: true
  paths:
    - /var/log/messages
filebeat.config.modules:
  path: ${path.config}/modules.d/*.yml
  reload.enabled: false
setup.template.settings:
  index.number_of_shards: 3
output.logstash:
  hosts: ["2.2.2.10:5044"]

[root@elk ~]# systemctl start filebeat
```
## 配置zookeeper yum源
```
[root@kafka ~]# vim /etc/yum.repos.d/mesosphere.repo
[mesosphere]
name=Mesosphere Packages for EL 7 - $basearch
baseurl=http://repos.mesosphere.io/el/7/$basearch/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mesosphere

[mesosphere-noarch]
name=Mesosphere Packages for EL 7 - noarch
baseurl=http://repos.mesosphere.io/el/7/noarch/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mesosphere

[mesosphere-source]
name=Mesosphere Packages for EL 7 - $basearch - Source
baseurl=http://repos.mesosphere.io/el/7/SRPMS/
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mesosphere

[root@kafka ~]# yum install java-1.8.0-openjdk -y
[root@kafka ~]# yum install mesosphere-zookeeper -y
[root@kafka ~]# vim /etc/zookeeper/conf/zoo.cfg
maxClientCnxns=50
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/var/lib/zookeeper
clientPort=2181

[root@kafka ~]# systemctl start zookeeper
[root@kafka ~]# lsof -i:2181
COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
java    2017 root   23u  IPv6  22946      0t0  TCP *:eforward (LISTEN)
```
## 安装配置kafka
```
[root@kafka ~]# wget http://www-us.apache.org/dist/kafka/2.0.0/kafka_2.11-2.0.0.tgz

[root@kafka ~]# tar xf kafka_2.11-2.0.0.tgz -C /usr/local/
[root@kafka ~]# mv /usr/local/kafka_2.11-2.0.0/ /usr/local/kafka
[root@kafka ~]# cd /usr/local/kafka
[root@kafka kafka]# egrep -v "^#|^$" config/server.properties
broker.id=0
port=9092
host.name=kafka.node1
num.network.threads=3
num.io.threads=8
socket.send.buffer.bytes=102400
socket.receive.buffer.bytes=102400
socket.request.max.bytes=104857600
log.dirs=/tmp/kafka-logs
num.partitions=1
num.recovery.threads.per.data.dir=1
offsets.topic.replication.factor=1
transaction.state.log.replication.factor=1
transaction.state.log.min.isr=1
log.retention.hours=168
log.segment.bytes=1073741824
log.retention.check.interval.ms=300000
zookeeper.connect=2.2.2.11:2181
zookeeper.connection.timeout.ms=6000
group.initial.rebalance.delay.ms=0

[root@kafka kafka]# grep -v ^# config/zookeeper.properties
dataDir=/var/lib/zookeeper
clientPort=2181
maxClientCnxns=0

[root@kafka kafka]# ./bin/kafka-server-start.sh config/server.properties &

[root@kafka kafka]# lsof -i:9092
COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
java    2064 root  100u  IPv6  23904      0t0  TCP kafka.node1:XmlIpcRegSvc (LISTEN)
java    2064 root  116u  IPv6  23911      0t0  TCP kafka.node1:52468->kafka.node1:XmlIpcRegSvc (ESTABLISHED)
java    2064 root  117u  IPv6  23912      0t0  TCP kafka.node1:XmlIpcRegSvc->kafka.node1:52468 (ESTABLISHED)

创建topic
./bin/kafka-topics.sh --create --zookeeper 2.2.2.11:2181 --replication-factor 1 --partitions 1 --topic test
发送消息
./bin/kafka-console-producer.sh --broker-list 2.2.2.11:9092 --topic test
消费消息
./bin/kafka-console-consumer.sh --bootstrap-server 2.2.2.11:9092 --topic test --from-beginning

配置ELK上的logstash
[root@elk ~]# vim /etc/logstash/conf.d/logstash-kafka.conf
input {
    kafka {
        type => "kafka-logs"
        bootstrap_servers => "2.2.2.11:9092"
        group_id => "logstash"
        auto_offset_reset => "earliest"
        topics => "test"
        consumer_threads => 5
        decorate_events => true
        }
}

output {
    elasticsearch {
    index => 'kafka-log-%{+YYYY.MM.dd}'
    hosts => ["2.2.2.10:9200"]
}

[root@elk ~]# systemctl restart logstash

配置kafka上的filebeat
[root@kafka ~]# vim /etc/filebeat/filebeat.yml
output.kafka:
  enabled: true
  hosts: ["2.2.2.11:9092"]
  topic: test

[root@kafka ~]# systemctl restart filebeat
```

自此部署完成，浏览器访问 Kibana serverIP 来查看日志
！[](./001.png)
