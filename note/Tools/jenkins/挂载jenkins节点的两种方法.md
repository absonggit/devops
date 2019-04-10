https://blog.csdn.net/liuchunming033/article/details/52025541

1、挂载slave节点的方法
在Jenkins的Master上，进入Mange node页面，可以管理node节点，例如新加、删除等操作。
新加node节点的页面如下：


其中，
Name是节点名字；
Description是节点描述；
# of executors是该节点可以同时运行job的数量； 
Remote root directory主要是添加了workspace的目录；
Label是该节点的标签名，在运行job的时候，可以使用该标签指定job运行的node；
Usage是你如何使用该节点，通常选择Utilize this node as much as possible，即尽量使用该节点。
Lance method：是将该node挂载到master上的方法。这里有四个选项，常用的是前两选项，即“Launch slave agents on Unix machine via SSH”和“Launch slave agents via Java Web Start”。本文将详细介绍这两种挂载node的方法。
Availability是你何时连接该节点。通常选择一直连接即可，即“Keep this slave on-line as much as possible”。
2、通过SSH连接node
关于SSH连接slave，jenkins有如下描述：

Launch slave agents on Unix machines via SSH
Starts a slave by sending commands over a secure SSH connection. The slave needs to be reachable from the master, and you will have to supply an account that can log in on the target machine. No root privileges are required.

这段描述的意思是说，选择此种方式连接时，master和slave必须是能够通过ssh进行连接的，必须有slave机器的账号才行，但不要求必须是root账号。
这种方式的前提是需要安装SSH Slaves plugin插件。
这种方式的步骤如下：
1、输入slave节点的IP。
2、Add Credentials：
有如下两种方式：
1）通过Username with password方式
需要知道slave机器的用户名和密码，见下图：


2）通过SSH Username with private key方式
需要先在master机器上生成ssh key pair。生成的 public key放到slave机器的 ~/.ssh/authorized_keys里面。然后chmod 600 ~/.ssh/authorized_keys。
然后，添加连接slave的credential，见下图：


这两种方式的Scope选项，我选择的是System，表示这个Credentials仅仅是用来master和node进行连接用的。还有另外一种是“Global（Jenkins、nodes、items、child items）”，这种scope的Credential可以用来连接git等其他机器。具体选择哪种scope，根据自己的需要。就连接slave这个需求来说，哪种scope的credential都可以。
Username填写在master上生成key pair时使用的用户名。
Private key选择From the jenkins master ~/.ssh
【扩展知识】
Jenkins的SSH Credentials Plugin插件，可以集中管理这些ssh 的key。安装完这个插件，可以在Jenkins上看到这样的页面


这个页面可以对credentials进行添加、删除、修改等操作。在这里设置的credentials在jenkins的其他需要credentials的地方，可以通过下拉菜单选择使用，比如添加slave时，可以直接在Credentials下拉菜单里选择对应的credential就行：


还有git clone代码时：

此时一定要把在master上生成的 public key添加到github账号的的Profile setting页面里的SSH Keys Settings中。
3、通过JNLP连接node
关于这种方式jenkins有如下描述：

Launch slave agents via Java Web Start
Starts a slave by launching an agent program through JNLP. The launch in this case is initiated by the slave, thus slaves need not be IP reachable from the master (e.g. behind the firewall.) It is still possible to start a launch without GUI, for example as a Windows service.

这段话的意思是说，JNLP方式连接salve，不需要master必须能够ssh连接到slave，只需要两者能够ping通即可。这种连接方式的slave还可以作为服务运行在slave的机器上。
这种方式连接slave的步骤如下：


按照上面图片的设置方式设置完成后，点击save，就建好了一个slave节点。如下图所示。


接下来的任务是将该节点连到master上。与ssh方式是master主动连接slave不同，这种JNLP方式是slave主动连接master。
登陆到slave机器上，运行上图中的java -jar 命令，即可将slave连接到master上了。
写了一个脚本，功能主要有：1、可以直接启动slave；2、将slave作为服务安装在slave机器上；3、当slave服务停止后，自动重启。
脚本地址：
https://github.com/liuchunming033/setup_jenkins_slave

参考资料
http://www.nerdnuts.com/2014/06/jenkins-managing-ssh-keys/
---------------------
作者：liuchunming033
来源：CSDN
原文：https://blog.csdn.net/liuchunming033/article/details/52025541
版权声明：本文为博主原创文章，转载请附上博文链接！
