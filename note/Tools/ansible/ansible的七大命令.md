ansible、ansible-doc、ansible-galaxy、ansible-lint、ansible-playbook、ansible-pull、ansible-vault 。这里我们只查看usage部分，详细部分可以通过 “指令 -h”  的方式获取。

# ansible
ansible是指令核心部分，其主要用于执行ad-hoc命令，即单条命令。默认后面需要跟主机和选项部分，默认不指定模块时，使用的是command模块。

# ansible-doc
该指令用于查看模块信息，常用参数有两个-l 和 -s ，具体如下：
//列出所有已安装的模块

# ansible-doc  -l
//查看具体某模块的用法，这里如查看command模块
```
$ ansible-doc  -s command
```

# ansible-galaxy
ansible-galaxy 指令用于方便的从https://galaxy.ansible.com/ 站点下载第三方扩展模块，我们可以形象的理解其类似于centos下的yum、python下的pip或easy_install 。如下示例：
```
$ ansible-galaxy install aeriscloud.docker
```
这个安装了一个aeriscloud.docker组件，前面aeriscloud是galaxy上创建该模块的用户名，后面对应的是其模块。在实际应用中也可以指定txt或yml 文件进行多个组件的下载安装。这部分可以参看官方文档

# ansible-lint
ansible-lint是对playbook的语法进行检查的一个工具。用法是
```
$ ansible-lint playbook.yml
```

# ansible-playbook
该指令是使用最多的指令，其通过读取playbook 文件后，执行相应的动作，这个后面会做为一个重点来讲

# ansible-pull
该指令使用需要谈到ansible的另一种模式－－－pull 模式，这和我们平常经常用的push模式刚好相反，其适用于以下场景：你有数量巨大的机器需要配置，即使使用非常高的线程还是要花费很多时间；你要在一个没有网络连接的机器上运行Anisble，比如在启动之后安装。这部分也会单独做一节来讲。

# ansible-vault
ansible-vault主要应用于配置文件中含有敏感信息，又不希望他能被人看到，vault可以帮你加密/解密这个配置文件，属高级用法。主要对于playbooks里比如涉及到配置密码或其他变量时，可以通过该指令加密，这样我们通过cat看到的会是一个密码串类的文件，编辑的时候需要输入事先设定的密码才能打开。这种playbook文件在执行时，需要加上 –ask-vault-pass参数，同样需要输入密码后才能正常执行。
