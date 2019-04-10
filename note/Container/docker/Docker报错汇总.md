# Docker报错 WARNING: IPv4 forwarding is disabled. Networking will not work.
```
创建容器的时候报错WARNING: IPv4 forwarding is disabled. Networking will not work.

sysctl net.ipv4.ip_forward
如果返回为“net.ipv4.ip_forward = 0” 则需要修改次值为1.

$ vim /usr/lib/sysctl.d/00-system.conf
net.ipv4.ip_forward=1

$ systemctl restart network
完成以后，删除错误的容器，再次创建新容器，就不再报错了。
```

# 在Centos7的docker里装好了httpd，运行报错：Failed to get D-Bus connection: Operation not permitted  
```
systemctl start httpd.service  
Failed to get D-Bus connection: Operation not permitted  
必须提权才可以：

$ docker run --privileged -d -p 10080:80 centos /sbin/init  
```
