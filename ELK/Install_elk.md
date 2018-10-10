
###配置清华镜像站yum源
```
[root@elk ~]# ntpdate 0.centos.pool.ntp.org
[root@elk ~]# vim /etc/yum.repos.d/elk.repo
[elk]
name=elk
baseurl=https://mirrors.tuna.tsinghua.edu.cn/elasticstack/yum/elastic-6.x/
enable=1
gpgcheck=0
```
