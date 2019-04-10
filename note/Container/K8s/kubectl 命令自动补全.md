```
在k8s 1.3版本之前，设置kubectl命令自动补全是通过以下的方式：

source ./contrib/completions/bash/kubectl
```
```
但是在k8s 1.3版本，源码contrib目录中已经没有了completions目录，无法再使用以上方式添加自动补全功能。1.3版本中，kubectl添加了一个completions的命令， 该命令可用于自动补全

$ yum install -y bash-completion
# locate bash_completion
/usr/share/bash-completion/bash_completion
$ source /usr/share/bash-completion/bash_completion


# 默认1.9版本自带completion，如果没有在去安装
$ source <(kubectl completion bash)
$ echo "source <(kubectl completion bash)" >> ~/.bashrc
```

> https://github.com/evanlucas/fish-kubectl-completions

kube-shell
> https://github.com/cloudnativelabs/kube-shell
> centos7中必须Python1.7.10+版本或者py3
