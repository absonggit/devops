# 基于docker安装
## 安装软件包
```
yum -y install epel-release
systemctl disable firewalld
systemctl stop firewalld
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
setenforce 0
yum -y install git gettext ansible docker nodejs npm gcc-c++ bzip2 python-docker-py
```

## 启动服务
```
systemctl start docker
systemctl enable docker
```

## clone awx代码
```
$ git clone https://github.com/ansible/awx.git
$ cd awx/installer/
$ vim inventory
# 注意修改一下postgres_data_dir到其他目录比如/data/pgdocker
$ ansible-playbook -i inventory install.yml
```

# 安装错误
```
fatal: [localhost]: FAILED! => {
    "changed": false,
    "module_stderr": "Traceback (most recent call last):\n  File \"/tmp/ansible_jdlYjd/ansible_module_docker_container.py\", line 2081, in <module>\n    main()\n  File \"/tmp/ansible_jdlYjd/ansible_module_docker_container.py\", line 2076, in main\n    cm = ContainerManager(client)\n  File \"/tmp/ansible_jdlYjd/ansible_module_docker_container.py\", line 1703, in __init__\n    self.present(state)\n  File \"/tmp/ansible_jdlYjd/ansible_module_docker_container.py\", line 1723, in present\n    new_container = self.container_create(self.parameters.image, self.parameters.create_parameters)\n  File \"/tmp/ansible_jdlYjd/ansible_module_docker_container.py\", line 825, in create_parameters\n    host_config=self._host_config(),\n  File \"/tmp/ansible_jdlYjd/ansible_module_docker_container.py\", line 931, in _host_config\n    return self.client.create_host_config(**params)\n  File \"/usr/lib/python2.7/site-packages/docker/api/container.py\", line 159, in create_host_config\n    return utils.create_host_config(*args, **kwargs)\nTypeError: create_host_config() got an unexpected keyword argument 'init'\n",
    "module_stdout": "",
    "msg": "MODULE FAILURE",
    "rc": 1
}

解决方法：
pip uninstall docker-py
pip install docker
```

```
pip10包管理导致的install错误

今天安装geoip2（pip install geoip2），遇到了如下的错误信息：

    Cannot uninstall 'requests'. It is a distutils installed project and thus we cannot accurately determine which files belong to it which would lead to only a partial uninstall.

错误的原因是requests 默认版本为2.6.0，而geoip2需要2.9以上版本才支持，但是无法正常卸载2.6.0版本。通过google查找后，发现是pip10对包的管理存在变化。

通过如下方式强制重新安装requests，问题得到解决：

        pip install -I requests==2.9
```
