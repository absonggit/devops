官网：http://ipset.netfilter.org/

# 介绍
- iptables是在linux内核里配置防火墙规则的用户空间工具,它实际上是netfilter框架的一部分.可能因为iptables是netfilter框架里最常见的部分,所以这个框架通常被称为iptables,iptables是linux从2.4版本引入的防火墙解决方案.
- ipset是iptables的扩展,它允许你创建 匹配整个地址sets（地址集合） 的规则。而不像普通的iptables链是线性的存储和过滤,ip集合存储在带索引的数据结构中,这种结构即时集合比较大也可以进行高效的查找.

# 安装
## yum安装
```
$ yum install -y ipset
```

## 源码编译
```
$ rpm -ivh libmnl-devel-1.0.2-3.el6.x86_64.rpm libmnl-1.0.2-3.el6.x86_64.rpm
$ tar xvf ipset-6.24.tar.bz2
$ cd ipset-6.24
$ ./configure
$ make
$ make install
```

> #注意：如果在centos6.6或其他情况下安装时候，configure报错如下configure: error: Invalid kernel source directory /lib/modules/2.6.32-358.el6.x86_64/source 需要安装内核源包kernel-devel-2.6.32-358.el6.x86_64.rpm

# 使用
## 创建一个新的ipset
```
$ ipset create SETNAME TYPENAME

# SETNAME：创建的ipset的名称
# TYPENAME：TYPENAME = method:datatype[,datatype[,datatype]]   
# method 可用： bitmap, hash, list
# datatype 可用： ip, net, mac, port, iface

# ipset默认可以存储65536个element，使用maxelem指定数量 ipset create test hash:ip maxelem 1000
```

## 删除一个ipset
```
$ ipset destroy SETNAME
```

## 添加记录
### 命令添加
```
$ ipset add SETNAME TYPENAME

# TYPENAME格式和设置的相同 ipset add test 192.168.1.2,80
```

### 直接修改文件
```
$ service ipset save        //保存为ipset文件
$ vim /etc/sysconfig/ipset        //修改ipset文件
$ service ipset reload        //载入文件

# 如果文件与 ipset list 不同、那么需要清缓存  ipset flush
```

## 创建防火墙规则
```
$ iptables -A INPUT -p tcp -m set --match-set test src -m tcp --dport 11 -j ACCEPT
$ service iptables save

# 执行iptables -A后 保存在iptables的文件
-A INPUT -p tcp -m set --match-set test src -m tcp --dport 11 -j ACCEPT
```

## 查看记录
```
$ ipset list SETNAME
```

## 删除记录
```
$ ipset del SETNAME 192.168.1.2,80
```

## 导入导出ipset
```
$ ipset save SETNAME
$ ipset restore SETNAME
```

```
ipset [ OPTIONS ] COMMAND [ COMMAND-OPTIONS ]
COMMANDS := { create | add | del | test | destroy | list | save | restore | flush | rename | swap | help | version | - }
OPTIONS := { -exist | -output { plain | save | xml } | -quiet | -resolve | -sorted | -name | -terse | -file filename }
ipset create SETNAME TYPENAME [ CREATE-OPTIONS ]
ipset add SETNAME ADD-ENTRY [ ADD-OPTIONS ]
ipset del SETNAME DEL-ENTRY [ DEL-OPTIONS ]
ipset test SETNAME TEST-ENTRY [ TEST-OPTIONS ]
ipset destroy [ SETNAME ]
ipset list [ SETNAME ]
ipset save [ SETNAME ]
ipset restore
ipset flush [ SETNAME ]
ipset rename SETNAME-FROM SETNAME-TO
ipset swap SETNAME-FROM SETNAME-TO
ipset help [ TYPENAME ]
ipset version
```
