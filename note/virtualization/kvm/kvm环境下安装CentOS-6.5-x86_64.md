# 上传ISO文件
```
[root@lvyu1 ~]# pwd
/root

[root@lvyu1 ~]# ls -R
.:
anaconda-ks.cfg  install.log  install.log.syslog  kvm  os

./kvm:

./os:
CentOS-6.5-x86_64-bin-DVD1.iso
```

# 安装CentOS6.5
```
    (1)raw格式磁盘
[root@lvyu1 ~]# mkdir kvm
[root@lvyu1 ~]# cd kvm/
[root@lvyu1 kvm]# vim create_vm.sh
virt-install \
--name cea \
--ram 2048 \
--vcpus=1 \
--disk path=/kvm/vm_img/centiaa.img,size=10 \
--network bridge=br0\
--cdrom=/kvm/os/CentOS-6.5-x86_64-bin-DVD1.iso \
--accelerate \
--vnclisten=0.0.0.0 \
--keymap=en-us\
--vncport=5916 \
--vnc
```
```
virt-install \
--name centos2 \  ##虚拟机名称
--ram 512 \  ##分配内存大小(默认大小MB)
--vcpus=1 \  ##分配CPU核心数,最大与时提及CPU核心数相同
--disk path=/data/img/kvm_centos2.img,size=10 \  ##指定虚拟机镜像(size单位为GB)    
--network bridge=br0 \  ##指定网络
--cdrom=/data/CentOS-6.4-x86_64-bin-DVD1.iso \  ##指定安装镜像
iso--accelerate \  ##加速
--vnclisten=0.0.0.0 \  ##指定VNC绑定IP，默认绑定127.0.0.1，这里改为0.0.0.0
--vncport=5911 \  ##指定VNC监听端口(默认为5900)
--vnc  ##启用VNC管理
注: 每行"\"后面不要带有空格.
```
