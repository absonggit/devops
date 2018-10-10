
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

## 安装配置Elasticsearch Logstash Kibana
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
    index => "%{type}-%{+YYYY.MM.dd}"
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
