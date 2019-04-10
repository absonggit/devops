192.168.209.11    ansible管理主机
192.168.209.12    ansible控制主机
192.168.209.13    ansible控制主机

# ansible安装(采用pip方式)
```
yum install -y gcc* libffi-devel python-devel openssl-devel
python get-pip.py
pip install ansible
```
ansible和被管理主机做SSH互信任
```
ssh-keygen
ssh-copy-id -i ~/.ssh/id_rsa.pub root@192.168.209.12
ssh-copy-id -i ~/.ssh/id_rsa.pub root@192.168.209.13
```

# ansible命令参数介绍
Ansible中的临时命令的执行是通过Ad-Hoc来完成，能够快速执行，而且不需要保存执行的命令，例如：
```
ansible -i /etc/ansible/hosts all -m command -a ‘who’ -u root
```
主要参数如下：
- -u username          指定ssh连接的用户名，即执行后面命令的用户
- -i inventory_file       指定所使用的inventory文件的位置，默认为/etc/ansible/hosts
- -m module              指定使用的模块，默认为command
- -f 10                        指定并发数，并发量大的时候，提高该值
- --sudo [-k]               当需要root权限执行的化，-k参数用来输入root密码


## ansible管理哪些主机
- Host Inventory（主机目录、主机清单)
- Host Inventory 是配置文件，用来告诉Ansible需要管理哪些主机。并且把这些主机根据按需分类。
- 可以根据用途分类：数据库节点，服务节点等；根据地点分类：中部，西部机房。
默认的文件是：/etc/ansible/hosts(如果没有可以创建同名文件)

```
不分组：    ansible -i /etc/ansible/hosts all
192.168.209.12
192.168.209.13


分组：    ansible -i /etc/ansible/hosts WebServer
[WebServer]
192.168.209.12
[AppServer]
192.168.209.13
```

## Ansible用命令管理主机
Ansible提供了一个命令行工具，在官方文档中起给命令行起了一个名字叫Ad-Hoc Commands。

ansible命令的格式是：`ansible <host-pattern> [options]`
```
拷贝文件
拷贝文件/etc/host到远程机器（组）WebServer，位置为/tmp/hosts
$ ansible WebServer -m copy -a "src=/etc/hosts dest=/tmp/hosts"
```

## Ansible用脚本管理主机
只有脚本才可以重用，避免总敲重复的代码。Ansible脚本的名字叫Playbook，使用的是YAML的格式，文件 以yml结尾。
> 注解：YAML和JSON类似，是一种表示数据的格式。

- playbook 每个关键字的含义：
    - hosts：为主机的IP，或者主机组名，或者关键字all
    - remote_user: 以哪个用户身份执行。
    - vars： 变量
    - tasks: playbook的核心，定义顺序执行的动作action。每个action调用一个ansbile module。
    - action 语法： module： module_parameter=module_value
        - 常用的module有yum、copy、template等，module在ansible的作用，相当于bash脚本中yum，copy这样的命令。
    - handers： 是playbook的event，默认不会执行，在action里触发才会执行。多次触发只执行一次。


## Ansible模块Module
- module就是Ansible的“命令”，module是ansible命令行和脚本中都需要调用的。常用的Ansible module有ls、cd、yum、copy、template等。

- ansible中调用module也可以跟不同的参数，每个module的参数也都是由module自定义的。

- 每个module的用法可以查阅文档。http://docs.ansible.com/ansible/modules_by_category.html


### Ansible在命令行里使用Module
```
-m后面接调用module的名字
-a后面接调用module的参数
# 使用module copy拷贝管理员节点文件/etc/hosts到所有远程主机/tmp/hosts
$ ansible all -m copy -a "src=/etc/hosts dest=/tmp/hosts"
```

### Ansilbe在Playbook脚本使用Module
在playbook脚本中，tasks中的每一个action都是对module的一次调用。在每个action中：
- 冒号:前面是module的名字
- 冒号:后面是调用module的参数
```
---
  tasks:
  - name: ensure apache is at the latest version
    yum: pkg=httpd state=latest
  - name: write the apache config file
    template: src=templates/httpd.conf.j2 dest=/etc/httpd/conf/httpd.conf
```

Module的特性
- Module是通过命令或者Playbook可以执行的task的插件
- Module是用Python写的。
- Ansible提供一些常用的Module http://docs.ansible.com/ansible/modules_by_category.html
- 通过命令ansible-doc可以查看module的用法
- Ansible提供API，用户可以自己写Module
