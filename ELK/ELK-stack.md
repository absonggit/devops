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
