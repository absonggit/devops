# ipset介绍
---
	ipset是iptables的扩展,它允许你创建 匹配整个地址集合的规则。而不像普通的iptables链只能单IP匹配, ip集合存储在带索引的数据结构中,这种结构即时集合比较大也可以进行高效的查找，除了一些常用的情况,比如阻止一些危险主机访问本机，从而减少系统资源占用或网络拥塞,IPsets也具备一些新防火墙设计方法,并简化了配置.

	官网：url http://ipset.netfilter.org/
# ipset安装
```
yum安装： yum install ipset
```
# 创建一个ipset
```
ipset create xxx hash:net （也可以是hash:ip ，这指的是单个ip,xxx是ipset名称）
ipset默认可以存储65536个元素，使用maxelem指定数量

ipset create blacklist hash:net maxelem 1000000 #黑名单
ipset create whitelist hash:net maxelem 1000000 #白名单
```
# 查看已创建的ipset
```
ipset list
```
# 加入一个名单ip
```
ipset add blacklist 10.60.10.xx
```
# 去除名单ip
```
ipset del blacklist 10.60.10.xx
```
# 创建防火墙规则，与此同时，allset这个IP集里的ip都无法访问80端口（如：CC攻击可用）
```
iptables -I INPUT -m set –match-set blacklist src -p tcp -j DROP
iptables -I INPUT -m set –match-set whitelist src -p tcp -j DROP
service iptables save
iptables -I INPUT -m set –match-set setname src -p tcp –destination-port 80 -j DROP
```
# 将ipset规则保存到文件
```
ipset save blacklist -f blacklist.txt
ipset save whitelist -f whitelist.txt
```
# 删除ipset
```
ipset destroy blacklist
ipset destroy whitelist
```
#导入ipset规则
```
ipset restore -f blacklist.txt
ipset restore -f whitelist.txt
```


ipset的一个优势是集合可以动态的修改，即使ipset的iptables规则目前已经启动，新加的入ipset的ip也生效
屏蔽一组地址


	先创建一个新的网络地址的“集合”。下面的命令创建了一个新的叫做“myset”的“net”网络地址的“hash”集合。

	# ipset create myset hash:net

	把你希望屏蔽的IP地址添加到集合中。

	# ipset add myset 14.144.0.0/12
	# ipset add myset 27.8.0.0/13
	# ipset add myset 58.16.0.0/15

	最后，配置iptables来屏蔽这个集合中的所有地址。这个命令将会向“INPUT”链顶端添加一个规则来从ipset中“-m”匹配名为“myset”的集合，当匹配到的包是一个“src”包时，“DROP”屏蔽掉它。

	# iptables -I INPUT -m set --match-set myset src -j DROP

使ipset持久化

	你创建的ipse存在于内存中，重启后将会消失。要使ipset持久化，你要这样做：

	首先把ipset保存到/etc/ipset.conf:

	# ipset save > /etc/ipset.conf
	# systemctl start ipset.service
	然后启用 ipset.service,这个服务与用于恢复iptables rules的iptables.service相似。

查看集合。
	# ipset list

删除名为“myset”的集合。
	# ipset destroy myset

删除所有集合。
	# ipset destroy
