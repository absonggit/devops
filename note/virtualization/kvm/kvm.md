# 安装CentOS6.5，使用最小化的minimal安装
# 安装完CentOS后，使用root登录配置网卡，使虚拟机可以使用外网上网
```
vi /etc/sysconifg/network-scripts/ifcfg-eth0
HWADDR=40:F2:E9:9E:E4:4A
TYPE=Ethernet
UUID=e507c0b1-4e2f-49c6-a13c-82dc3d1b1ada
ONBOOT=yes
NM_CONTROLLED=yes
BOOTPROTO=static
IPADDR=192.168.6.251
NETMASK=255.255.255.0
GATEWAY=192.168.6.1
DNS1=8.8.8.8
DNS2=8.8.8.8

保存后，重启网络服务
service network restart


然后测试是否能联网
ping www.baidu.com
```

# 关闭selinux和清空iptables
```
修改selinux配置文件
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
设置当前selinux
setenforce 0


清空iptables
iptables -F
保存iptables规则
service iptables save
```

# 安装KVM
```
使用yum安装：
yum -y install qemu-kvm libvirt python-virtinst bridge-utils avahi dmidecode
安装完成后重启虚拟机
init 6


重启完成后，测试kvm是否安装成功
stat /dev/kvm
执行结果:
File: "/dev/kvm"
Size: 0 Blocks: 0 IO Block: 4096 字符特殊文件
Device: 5h/5d Inode: 9503 Links: 1 Device type: a,e8
Access: (0666/crw-rw-rw-) Uid: ( 0/ root) Gid: ( 36/ kvm)
Access: 2015-06-28 16:56:11.463134124 +0800
Modify: 2015-06-28 16:56:11.463134124 +0800
Change: 2015-06-28 16:56:11.463134124 +0800  

在vb上执行这个命令不会有结果, 我这个是在真机上执行的结果


测试libvirtd是否可以正常启动
service libvirtd start
service libvirtd restart
```

# 配置网络桥接
```
检查系统中是否启用了NetworkManager，最好关闭该服务，因为该服务与network有冲突。
chkconfig |grep NetworkManager
如果存在NetworkManager
chkconfig NetworkManager off
service NetworkManager stop


从ifcfg-eth0复制现有网卡的配置文件，改名为ifcfg-br0：
cp /etc/sysconfig/network-scripts/ifcfg-eth0 /etc/sysconfig/network-scripts/ifcfg-br0


修改ifcfg-br0，注意红色的两行，其他部分基本上不用改。
vi /etc/sysconfig/network-scripts/ifcfg-br0
DEVICE=br0
HWADDR=08:00:27:1D:26:B2
UUID=251576f1-0ae3-4a52-b0e1-9343a7ad936d
TYPE=Bridge

ONBOOT=yes
NM_CONTROLLED=yes
BOOTPROTO=stataic
IPADDR=10.0.0.156
NETMASK=255.255.255.0
GATEWAY=10.0.0.1
DNS1=202.96.64.68
DNS2=202.96.69.38

修改ifcfg-eth0，仅保存以下几行。
vi /etc/sysconfig/network-scripts/ifcfg-eth0
DEVICE=eth0
HWADDR=08:00:27:1D:26:B2
UUID=251576f1-0ae3-4a52-b0e1-9343a7ad936d

TYPE=Ethernet
ONBOOT=yes
NM_CONTROLLED=yes
BRIDGE=br0



重启network服务
service network restart
正在关闭接口 eth0： bridge br0 does not exist!
[确定]
关闭环回接口： [确定]
弹出环回接口： [确定]
弹出界面 eth0： [确定]
弹出界面 br0： Determining if ip address 10.0.0.156 is already in use for device br0...
[确定]



执行ifconfig
br0 Link encap:Ethernet HWaddr 08:00:27:1D:26:B2
inet addr:10.0.0.156 Bcast:10.0.0.1 Mask:255.255.255.0
inet6 addr: fe80::ba97:5aff:feb7:98b5/64 Scope:Link
UP BROADCAST RUNNING MULTICAST MTU:1500 Metric:1
RX packets:1210 errors:0 dropped:0 overruns:0 frame:0
TX packets:40 errors:0 dropped:0 overruns:0 carrier:0
collisions:0 txqueuelen:0
RX bytes:74677 (72.9 KiB) TX bytes:7509 (7.3 KiB)
eth0 Link encap:Ethernet HWaddr 08:00:27:1D:26:B2
inet6 addr: fe80::ba97:5aff:feb7:98b5/64 Scope:Link
UP BROADCAST RUNNING MULTICAST MTU:1500 Metric:1
RX packets:5625 errors:0 dropped:0 overruns:0 frame:0
TX packets:359 errors:0 dropped:0 overruns:0 carrier:0
collisions:0 txqueuelen:1000
RX bytes:425234 (415.2 KiB) TX bytes:65054 (63.5 KiB)
lo Link encap:Local Loopback
inet addr:127.0.0.1 Mask:255.0.0.0
inet6 addr: ::1/128 Scope:Host
UP LOOPBACK RUNNING MTU:16436 Metric:1
RX packets:0 errors:0 dropped:0 overruns:0 frame:0
TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
collisions:0 txqueuelen:0
RX bytes:0 (0.0 b) TX bytes:0 (0.0 b)
virbr0 Link encap:Ethernet HWaddr 52:54:00:CA:22:F4
inet addr:192.168.122.1 Bcast:192.168.122.255 Mask:255.255.255.0
UP BROADCAST RUNNING MULTICAST MTU:1500 Metric:1
RX packets:0 errors:0 dropped:0 overruns:0 frame:0
TX packets:11 errors:0 dropped:0 overruns:0 carrier:0
collisions:0 txqueuelen:0
RX bytes:0 (0.0 b) TX bytes:2449 (2.3 KiB)



配置转发
执行以下命令：
echo 1 > /proc/sys/net/ipv4/ip_forward
这一步虽然只有简单的一条命令，但却很关键。如果不执行这一步，所有的虚拟机将无法上网。
另外，上一步配置完桥接之后重启network，会自动将ip_forward改为0，所以重新配置网络后，不要忘了执行该命令。发现虚拟机无法上网的时候，也可以检查一下ip_forward值。
```

# 安装虚拟机
```
修改 qemu.conf 配置
vi /etc/libvirt/qemu.conf
vnc_listen = "0.0.0.0"
user = "root"
group = "root"
dynamic_ownership = 0


重启libvirtd服务
service libvirtd restart


新建用于存放虚拟机相关文件的目录
mkdir /kvm


使用winscp将centos6.5的安装光盘镜像复制到/kvm


新建用于存放虚拟机的目录
mkdir /kvm/vm


安装虚拟机
virt-install --name centos --ram 1024 --vcpus=1 --disk path=/kvm/vm/vm1.img,size=10 --network bridge=br0 --os-variant=rhel6 --cdrom /kvm/CentOS-6.5-x86_64-bin-DVD1.iso --vnclisten=10.0.0.156 --vncport=6900 --vnc


参数详解：
--vcpus 分配给虚拟机CPU个数
--disk path 虚拟磁盘所在的路径
--size 虚拟磁盘大小，单位是GB
--network bridge 指定虚拟机使用的桥接网卡
--os-variant 虚拟机的操作系统类型
--cdrom 安装虚拟机操作系统的光盘镜像的路径
--vnclisten vnc的监听IP
--vncport vnc的监听端口
--vnc 使用vnc进行连接


然后使用vnc-viewer连接虚拟机 ,
如果用VNC VIEWER连接虚拟机一闪而过,设置vnc的 ColourLevel=rgb222
使用vnc-viewer连接10.0.0.156:6900就可以远程安装这台虚拟机了


在kvm虚拟机中安装操作系统和在其他虚拟机上没有什么不同的地方
安装完成后, 在kvm虚拟机中进行网卡配置后,就可以使用putty进行远程连接了


把raw格式转换为qcow格式（其实是复制了一份）：
qemu-img convert -f raw -O qcow2 /data/centos6.6_1.img /data/centos6.6_1.qcow2
qemu-img info /data/centos6.6_1.qcow2 //再次查看格式，结果如下
image: /data/centos6.6_1.qcow2
file format: qcow2
virtual size: 30G (32212254720 bytes)
disk size: 1.1G
cluster_size: 65536
现在我们还需要编辑子机配置文件，让它使用新格式的虚拟磁盘镜像文件
virsh edit centos6.6_1 //这样就进入了该子机的配置文件（/etc/libvirt/qemu/centos6.6_1.xml），跟用vim编辑这个文件一样的用法
需要修改的地方是：
<driver name='qemu' type='raw' cache='none'/>
<source file='/data/centos6.6_1.img'/>
改为：
<driver name='qemu' type='qcow2' cache='none'/>
<source file='/data/centos6.6_1.qcow2'/>
然后重启libvirtd
service libvirtd restart


如果需要虚拟机随系统启动,就执行
virsh autostart centos


克隆虚拟机
virt-clone --original PosHA1 --name PosHA3 --file /kvm/disk/PosHA3Disk.qcow2


生成快照
virsh snapshot-create PosHA2


在VirtualBox中嵌套安装kvm时, 使用vnc远程安装系统是没有问题的, 但是在启动kvm虚拟机的过程中,非常非常的慢, 我等了二十几分钟也没有启动成功. 而且cpu的负载很高
所以在有条件的情况下, 可以使用真机进行实验.
```

Virsh语法参考
virsh list 列出运行中的虚拟机
virsh list --all 列出所有的虚拟机,包括未启动的
virsh start centos 启动centos虚拟机
virsh shutdown centos 关闭centos虚拟机
virsh destroy centos 强制关闭centos虚拟机
virsh autostart[--disable] centos 设置centos自动启动
virsh undefine centos 删除centos虚拟机
virsh suspend centos 暂停centos虚拟机
vrish resume centos 恢复centos虚拟机
virsh reboot centos 重启centos虚拟机
virsh edit centos 编辑centos虚拟机
virsh vncdisplay centos vnc显示

删除虚拟机的话,需要先destroy 然后再 undefine 最后删除虚拟磁盘文件

>> http://note.youdao.com/share/iframe.html                   
