hosts文件内部支持的一些特定指令(inventory参数)

`ansible_ssh_host`：指定主机别名对应的真实IP，如：251ansible_ssh_host=183.60.41.251，随后连接该主机无须指定完整IP，只需指定251就行

`ansible_ssh_port`：指定连接到这个主机的ssh端口，默认22

`ansible_ssh_user`：连接到该主机的ssh用户

`ansible_ssh_pass`：连接到该主机的ssh密码（连-k选项都省了），安全考虑还是建议使用私钥或在命令行指定-k选项输入

`ansible_sudo_pass`：sudo密码

`ansible_sudo_exe`(v1.8+的新特性):sudo命令路径

`ansible_connection`：连接类型，可以是local、ssh或paramiko，ansible1.2之前默认为paramiko

`ansible_ssh_private_key_file`：私钥文件路径

`ansible_shell_type`：目标系统的shell类型，默认为sh,如果设置csh/fish，那么命令需要遵循它们语法

`ansible_python_interpreter`：python解释器路径，默认是/usr/bin/python，但是如要要连*BSD系统的话，就需要该指令修改python路径

`ansible_*_interpreter`：这里的*可以是ruby或perl或其他语言的解释器，作用和ansible_python_interpreter类似
