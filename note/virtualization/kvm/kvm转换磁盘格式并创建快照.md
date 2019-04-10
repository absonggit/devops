kvm虚拟机默认使用raw格式的镜像格式，性能最好，速度最快，它的缺点就是不支持一些新的功能，如支持镜像,zlib磁盘压缩,AES加密等。要使用镜像功能，磁盘格式必须为qcow2。下面开始kvm虚拟机快照备份的过程。

>进一步的学习参考：kvm+libvirt虚拟机快照浅析： http://itxx.sinaapp.com/blog/content/130

# 查看现有磁盘镜像格式与转换
## 查看磁盘格式
```
[root@lvyu1 preb]# pwd
/kvm/vm_img/preb
[root@lvyu1 preb]# qemu-img info centos65.img
image: centos65.img
file format: raw
virtual size: 50G (53687091200 bytes)
disk size: 2.4G

# raw格式需要转换成qcow2
```

## 关闭虚拟机并转换磁盘
```
[root@lvyu1 preb]# yum -y install acpid    ##安装电源服务
[root@lvyu1 preb]# virsh shutdown preb
```

## 转换磁盘格式并查看
```
[root@lvyu1 preb]# qemu-img convert -f raw -O qcow2 centos65.img centos65.qcow2.img
-f  源镜像的格式
-O 目标镜像的格式   (o为大写)

查看转换后磁盘大小
[root@lvyu1 preb]# qemu-img info centos65.qcow2.img
image: centos65.qcow2.img
file format: qcow2
virtual size: 50G (53687091200 bytes)
disk size: 1.6G
cluster_size: 65536
```

## 删除rwq格式的磁盘文件、并赋予qcow2磁盘文件755权限
```
[root@lvyu1 preb]# rm -rf centos65.img [root@lvyu1 preb]# chmod 755 centos65.qcow2.img [root@lvyu1 preb]# ll总用量 1719124-rwxr-xr-x 1 root root 1760559616 4月  18 23:13 centos65.qcow2.img
```

# 修改虚拟机配置文件
```
[root@lvyu1 preb]# virsh edit preb
<disk type='file' device='disk'>
  <drive name='qeum' type='qcow2' cache='none'/> **
  <source file='/kvm/vm_img/preb/centos65.qcow2.img'/> **
```

# 对虚拟机进行快照管理
## 对preb虚拟机创建快照并给个别名
```
[root@lvyu1 preb]# virsh snapshot-create-as preb preb_snapshot.init
Domain snapshot preb_snapshot.init created
也可以virsh snapshot-create pbeb直接创建
```

## 查看虚拟机镜像快照的版本
```
[root@lvyu1 preb]# virsh snapshot-list preb
名称               Creation Time             状态
------------------------------------------------------------ preb_snapshot.init   2016-04-18 23:13:17 +0800 shutoff
```

## 查看当前虚拟机镜像快照的版本
```
[root@lvyu1 preb]# virsh snapshot-current preb
<domainsnapshot>
  <name>preb_snapshot.init<name/> **
  ...
  ...
```

## 查看当前虚拟机镜像快照的版本
```
[root@lvyu1 preb]# virsh snapshot-info preb preb_snapshot.init
名称：       preb_snapshot.init
Domain:         preb
Current:        yes
状态：       shutoff
Location:       internal
Parent:         -
Children:       0
Descendants:    0
Metadata:       yes    
```

## 查看当前虚拟机镜像文件
```
[root@lvyu1 preb]# ll /var/lib/libvirt/qemu/snapshot/
总用量 8
drwxr-xr-x 2 root root 4096 4月  18 22:48 prea
drwxr-xr-x 2 root root 4096 4月  18 23:23 preb
[root@lvyu1 preb]# ll /var/lib/libvirt/qemu/snapshot/preb
总用量 4
-rw------- 1 root root 3417 4月  18 23:23 preb_snapshot.init.xml
```

# 恢复虚拟机快照
## 恢复虚拟机快照必须关闭虚拟机
```
[root@lvyu1 preb]# virsh shutdown preb
#确认虚拟机是关机状态
```

## 确认需要恢复的快照时间，这里恢复到preb_snapshot.init
## 执行恢复，并确认恢复版本
```
[root@lvyu1 preb]# virsh snapshot-revert preb preb_snapshot.init
```

# 删除虚拟机快照
## 查看虚拟机快照
```
[root@lvyu1 preb]# qemu-img info preb_snapshot.init   
```

## 删除快照
```
[root@lvyu1 preb]# virsh snapshot-delete preb preb_snapshot.init
```
