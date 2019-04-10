# elk简介
- ELK Stack 是 Elasticsearch、Logstash、Kibana 三个开源软件的组合。在实时数据检索和分析场合，三者通常是配合共用，而且又都先后归于 Elastic.co 公司名下，故有此简称。

- 工作原理：通过filebeat收集日志，缓存到redis，logstash从redis里取出数据发送给elasticsearch分析、存储，通过kibana显示。

# 安装配置
## 所需安装包
```
$ wget / curl -L -O
https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.1.2.tar.gz
https://artifacts.elastic.co/downloads/kibana/kibana-6.1.2-linux-x86_64.tar.gz
https://artifacts.elastic.co/downloads/logstash/logstash-5.5.1.tar.gz
http://download.redis.io/releases/redis-4.0.7.tar.gz
https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.5.1-linux-x86_64.tar.gz
$ yum install  -y java
# java1.8+
```

## 优化系统配置
```
$ vim /etc/security/limits.conf
* soft nofile 65536
* hard nofile 65536
* soft nproc 2048
* hard nproc 4096

$ vim /etc/sysctl.conf
vm.max_map_count = 262144
net.ipv6.conf.all.disable_ipv6 = 1
$ sysctl -p
$ ulimit -n 65536
```

## elasticsearch
### 安装配置
```
$ cd /home/elk/package
$ rpm -ivh elasticsearch-6.1.2.rpm

$ mkdir -p /home/elk/es/data
$ mkdir -p /home/elk/es/logs
$ groupadd elasticsearch
$ useradd -g elasticsearch elasticsearch
$ chown -R elasticsearch:elasticsearch /home/elk/es/
# es不能用root启动、所以必须给elasticsearch权限

$ cd /home/elk/elasticsearch/config
$ vim jvm.options
-Xms10g
-Xmx15g
# 正常为内存的一半

$ grep "^[^#]" /etc/elasticsearch/elasticsearch.yml
path.data: /home/elk/es/data
path.logs: /home/elk/es/logs
network.host: 0.0.0.0
http.port: 9200


# 切换elasticsearch用户启动
nohup /home/elk/node1-es/bin/elasticsearch > /dev/null 2>&1 &
69.172.86.130   node1
113.10.193.68   node2 node3 node4 node5 node6
```

> 默认elasticsearch账号：elastic 密码：changeme

- 默认开启2个端口：
    - 9200 ---> http协议的RESTful接口
    - 9300 ---> tcp通讯端口，集群间和TCPClient接口

## kibana
```
$ rpm -ivh kibana-6.1.2-x86_64.rpm
$ grep "^[^#]" /etc/kibana/kibana.yml
server.port: 5601
server.host: 0.0.0.0
elasticsearch.url: "http://localhost:9200"

nohup /home/elk/kibana/bin/kibana > /dev/null 2>&1 &
```
> 以下根据需要自行配置：

> server.port: 对外端口, 默认5601

> server.host: 对外监听ip, 如果有nginx代理, 可以设置成127.0.0.1

> elasticsearch.url: es地址, 默认http://127.0.0.1:9200

> elasticsearch.username: elastic账号

> elasticsearch.password: elastic密码

- 默认开启端口：5601

## logstash
### 常用命令
- -f: 指定配置文件
- -e: 后跟字符串、该字符串可以背当做logstash的配置(如果是"" 则默认是stdin输入、stdout输出)
- -l: 日志输出的地址(默认stdout直接在控制台中输出)
- -t: 测试配置文件是否正确、然后退出
- 示例：
```
$ ./bin/logstash -e ""
123
{
    "@timestamp" => 2018-01-29T02:25:45.078Z,
      "@version" => "1",
          "host" => "localhost.localdomain",
       "message" => "123",
          "type" => "stdin"
}
```

### 安装配置
```
$ tar zxf logstash-6.1.2.tar.gz
$ mv logstash-6.1.2 ../logstash
$ cd ../logstash/conf

# 单机多实例启动
```
#### 从filebeat获取数据
```
input {
    beats {
        port => 5044
        codec => "json"
    }
}
output {
    elasticsearch {
        hosts => ["127.0.0.1:9200"]
        index => "logstash-nginx-error-%{+YYYY.MM.dd}"
        user => "elastic"
        password => "changeme"
    }
    stdout {codec => rubydebug}
}


```
#### 从redis获取数据
本次试验采用此配置
```

input {
  redis {
    host => "192.168.86.130"
    password => "1maegvxQxgA6vdgn"
    port => 6379
    threads => 5
    codec => "json"
  }
}

input {
  redis {
    data_type => "list"
    key => "tw_yc_zb_web_105"
    host => "192.168.86.130"
    password => "1maegvxQxgA6vdgn"
    port => 6379
    threads => 5
    codec => "json"
  }
}

filter {
}

output {
    if [type] == "zb_web_54" {
        elasticsearch {
            hosts => ["69.172.86.130:9200", "113.10.193.68:9200", "113.10.193.68:9201", "113.10.193.68:9202", "113.10.193.68:9203", "113.10.193.68:9204"]
            index => "zb_web_54-%{+YYYYMMdd}"
            flush_size => 100
            idle_flush_time => 10
            workers => 1
        }
    }
        stdout { codec => rubydebug }

    if [type] == "zb_web_105" {
        elasticsearch {
            hosts => ["69.172.86.130:9200", "113.10.193.68:9200", "113.10.193.68:9201", "113.10.193.68:9202", "113.10.193.68:9203", "113.10.193.68:9204"]
            index => "zb_web_105-%{+YYYYMMdd}"
            flush_size => 100
            idle_flush_time => 10
            workers => 1
        }
    }
        stdout { codec => rubydebug }
}
```

### 启动
```
$ cd /home/elk/logstash/config

nohup ../bin/logstash --node.name web --path.data /home/elk/ls/web/data --path.logs /home/elk/ls/web/logs --path.config ./111.conf > /dev/null 2>&1 &

```

## redis
```
$ cd /home/elk/package
$ tar zxvf redis-4.0.7.tar.gz
$ mv redis-4.0.7 ../redis
$ cd /home/elk/redis
$ make

$ grep "^[^#]" redis.conf
bind 0.0.0.0
logfile "/home/elk/redis/logs/redis.log"
requirepass "123456"

./src/redis-server redis.conf
```

## filebeat
### 安装filebeat
```
$ cd /home/elk
$ tar zxf filebeat-5.5.1-linux-x86_64.tar.gz
$ mv zxf filebeat-5.5.1 filebeat
```

### 配置文件
$ vim filebeat/filebeat.yml
```
filebeat.prospectors:
- input_type: log
  paths:
    - /home/webserver/logs/catalina.out
  document_type: "tomcat_web_01"
  fields:
    log_source: "1.1.1.1"

  encoding: plain
  tail_files: true
  scan_frequency: 1s
  close_older: 1h
  max_bytes: 10485760

  #multiline:
    #pattern: ^\[
    #negate: false
    #max_lines: 500
    #timeout: 5s

output.redis:
  enabled: true
  hosts: ["192.168.1.1"]
  prot: 6379
  password: "123456"
  dataytpe: list
  key: "%{[fields.log_source]}"
  #db: 0

loggging:
  to_syslog: true
```

### 启动监听模式
```
nohup ./filebeat -e -c filebeat.yml > /dev/null 2>&1 &
```

## grafana
```
$ wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-4.6.3-1.x86_64.rpm
$ rpm -ivh grafana-4.6.3-1.x86_64.rpm

$ yum install -y initscripts fontconfig freetype* urw-fonts
$ systemctl enable grafana-server.service
$ systemctl start grafana-server.service

安装包详细信息
$ rpm -qc grafana
/etc/grafana/grafana.ini
/etc/grafana/ldap.toml
/etc/init.d/grafana-server
/etc/sysconfig/grafana-server
/usr/lib/systemd/system/grafana-server.service

二进制文件 /usr/sbin/grafana-server
服务管理脚本 /etc/init.d/grafana-server
安装默认文件 /etc/sysconfig/grafana-server
配置文件 /etc/grafana/grafana.ini
安装systemd服务(如果systemd可用 grafana-server.service
日志文件 /var/log/grafana/grafana.log

# 访问URL：http://172.16.8.209:3000/
#配置数据源添加仪表盘即可
```
