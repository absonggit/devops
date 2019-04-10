# 主机目录(Host Inventory)
什么叫主机目录管理,告诉ansible需要管理哪些server，和server的分类和分组信息。可以根据你自己的需要根据地域分类，也可以按照功能的不同分类。

主机目录的配置文件
默认文件/etc/ansible/hosts


## 修改主机目录的配置文件
```
$ vim /etc/ansible/ansible.cfg
...........................

inventory  = /etc/ansible/hosts
...........................
```

## 命令行中传递主机目录配置文件
```
$ ansible-playbook -i hosts site.yml
或者参数--inventory-file
$ ansible-playbook --inventory-file hosts site.yml
```

## 远程主机的分组
### 简单的分组：[组名]
```
[g1]
www.a.com
172.16.24.85
```

### 父组和子组
```
[g1]
www.a.com
www.b.com

[g2]
192.168.209.12

[g3:children]   固定格式：[groupname:children]
g1
g2
```

## 指定连接的参数
### 参数
指定Server的连接参数，其中包括连接方法，用户等。
```
[group1]
web-[a-z].example.com ansible_connection=ssh ansible_user=user1

[group2]
web[01:50].server ansible_connection=ssh ansible_user=user1
```

- `ansible_host` #用于指定被管理的主机的真实IP
- `ansible_port` #用于指定连接到被管理主机的ssh端口号，默认是22
- `ansible_user` #ssh连接时默认使用的用户名
- `ansible_pass` #ssh连接时的密码
- `ansible_sudo_pass` #使用sudo连接用户时的密码
- `ansible_sudo_exec` #如果sudo命令不在默认路径，需要指定sudo命令路径
- `ansible_private_key_file` #秘钥文件路径，秘钥文件如果不想使用ssh-agent管理时可以使用此选项
- `ansible_shell_type` #目标系统的shell的类型，默认sh
- `ansible_connection` #SSH 连接的类型： local , ssh , paramiko，在 ansible 1.2 之前默认是 paramiko ，后来智能选择，优先使用基于 ControlPersist 的 ssh （支持的前提）
- `ansible_python_interpreter` #用来指定python解释器的路径，默认为/usr/bin/python 同样可以指定ruby 、perl 的路径
- `ansible_*_interpreter` #其他解释器路径，用法与ansible_python_interpreter类似，这里*可以是ruby或才perl等

> 所有可以指定的参数在文档中 http://docs.ansible.com/ansible/intro_inventory.html#list-of-behavioral-inventory-parameters


### 变量
**注意：hosts和groups变量只能被playbook使用，不能被ansible直接调用**
```
为一个组指定变量
[atlanta]
host1
host2

[atlanta:vars]
ntp_server=ntp.atlanta.example.com
proxy=proxy.atlanta.example.com
```

## 按目录结构存储变量
假设inventory文件为/etc/ansible/hosts，那么相关的hosts和group变量可以放在下面的目录结构下
```
/etc/ansible/group_vars/raleigh # can optionally end in '.yml','.yaml', or'.json'
/etc/ansible/group_vars/webservers
/etc/ansible/host_vars/foosball
```

/etc/ansible/group_vars/raleigh 文件内容可以为
```
ntp_server: acme.example.org
database_server: storage.example.org
```

如果对应的名字为目录名，ansible会读取这个目录下面所有文件的内容
```
/etc/ansible/group_vars/raleigh/db_settings/
etc/ansible/group_vars/raleigh/cluster_settings
```
**group_vars/ 和 host_vars/ 目录可放在 inventory 目录下,或是 playbook 目录下. 如果两个目录下都存在,那么 playbook 目录下的配置会覆盖 inventory 目录的配置.**
