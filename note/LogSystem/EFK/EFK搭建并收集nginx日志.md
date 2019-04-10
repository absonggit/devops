http://blog.csdn.net/gsying1474/article/details/52426366

$ yum install -y java-1.8.0-openjdk.i686

## elasticsearch
```
$ wget -c https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/rpm/elasticsearch/2.3.3/elasticsearch-2.3.3.rpm
$ rpm -ivh elasticsearch-2.3.3.rpm
$ systemctl enable elasticsearch
$ systemctl start elasticsearch
$ firewall-cmd --permanent --add-port={9200/tcp,9300/tcp}
$ firewall-cmd --reload
$ firewall-cmd  --list-all
```

## kibana
```
$ wget https://download.elastic.co/kibana/kibana/kibana-4.5.1-1.x86_64.rpm
$ rpm -ivh kibana-4.5.1-1.x86_64.rpm
$ systemctl enable kibana
$ systemctl start kibana
$ firewall-cmd --permanent --add-port=5601/tcp
$ firewall-cmd --reload
$ firewall-cmd --list-all
$ http://192.168.153.200:5601
```

## fluent
```
$ ulimit -n
$ vim /etc/security/limits.conf
root soft nofile 65536
root hard nofile 65536
* soft nofile 65536
* hard nofile 65536
$ vim /etc/sysctl.conf
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.ip_local_port_range = 10240    65535
$ init 6
$ curl -L https://toolbelt.treasuredata.com/sh/install-redhat-td-agent2.sh | sh
$ systemctl start td-agent
$ systemctl enable td-agent
$ systemctl status td-agent
$ curl -X POST -d 'json={"json":"message"}' http://localhost:8888/debug.test
$ tail -f /var/log/td-agent/td-agent.log
$ /usr/sbin/td-agent-gem install fluent-plugin-elasticsearch
$ /usr/sbin/td-agent-gem install fluent-plugin-typecast
$ /usr/sbin/td-agent-gem install fluent-plugin-secure-forward
$ systemctl restart td-agent
```

## 新建td-agent.conf文件
```
$ vim /etc/td-agent/td-agent.conf
<source>
  @type tail
  path /var/log/nginx/access.log
  pos_file /var/log/nginx/access.log.pos
  format /^(?<remote>[^ ]*) (?<user>[^ ]*) \[(?<time>[^\]]*)\] (?<code>[^ ]*) "(?<method>\S+)(?: +(?<path>[^\"]*) +\S*)?" (?<size>[^ ]*)(?: "(?<referer>[^\"]*)" "(?<agent>[^\"]*)")?$/
  time_format %d/%b/%Y:%H:%M:%S %z
  tag nginx.access
</source>

<match nginx.access>
  @type elasticsearch
  #path /var/log/nginx/access.log
  host localhost
  port 9200
# index_name fluentd
  flush_interval 10s
# typename fulentd
</match>

$ systemctl restart td-agent
```

## 修改nginx日志格式
```
$ vim /etc/nginx/nginx.conf
log_format main '$remote_addr $remote_user [$time_local] $status "$request" $body_bytes_sent "$http_referer" "$http_user_agent"';
$ systemctl restart nginx
```

## 访问nginx 查看数据是否获取数据
```
http://ip:80
$ curl localhost:9200/_search?pretty  查看elasticsearch是否存储到数据
```

## 打开kibana查看数据
