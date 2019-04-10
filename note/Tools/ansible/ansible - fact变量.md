ansible在运行playbook的时候、开始执行第一个task之前需要先连接到主机收集详细信息：CPU架构、操作系统、IP地址、内存、磁盘信息等。这些信息被保存到fact变量中。

```
[root@test1 playbook]# ansible h3 -m setup | grep "ansible_distribution"
/usr/lib64/python2.6/site-packages/cryptography/__init__.py:26: DeprecationWarning: Python 2.6 is no longer supported by the Python core team, please upgrade your Python. A future version of cryptography will drop support for Python 2.6  
  DeprecationWarning
      "ansible_distribution": "CentOS",
      "ansible_distribution_major_version": "6",
      "ansible_distribution_release": "Final,
      "ansible_distribution_version": "6.5",
```
```
- name: print out operating system
  hosts: allgroup
  gather_facts: True
  tasks:
  - debug: var=ansible_distribution
```

- 内置变量：
    - hostvars ----- 相当于setup模块 所有host的所有信息
    - inventory_hostname ----- hosts文件里边定义的别名
    - groups ----- 输出字典 key为群组名  value为 群组成员的主机名
    - group_names ----- 列表 成员由当前主机和群组组成
    - play_hosts ----- 列表 成员由play涉及到的主机和inventory的主机名组成
    - ansible_version ----- 字典 由ansible版本信息组成




- 优先级：
    1. ansible-playbook -e var=value (最高优先级)
    2. 这个优先级列表中没有提到的其他方法
    3. 通过invertory文件或者YAML文件定义的主机变量或群组变量
    4. Fact
    5. 在role的defaults/main.yml文件中
