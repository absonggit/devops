# 问题描述
k8s 1.11版本centos下使用ipvs模式会出问题 65461
```
Jun 25 20:50:00 VM_3_4_centos kube-proxy[3828]: E0625 20:50:00.312569    3828 ipset.go:156] Failed to make sure ip set: &{{KUBE-LOOP-BACK hash:ip,port,ip inet 1024 65536 0-65535 Kubernetes endpoints dst ip:port, source ip for solving hairpin purpose} map[] 0xc42073e1d0} exist, error: error creating ipset KUBE-LOOP-BACK, error: exit status 2

主要是ipset不支持comment:

$ ipset create foo hash:ip comment
ipset v6.19: Unknown argument: `comment'
Try `ipset help' for more information.

升级ipset问题仍然不能解决、在不改kubernetes情况下可以通过升级内核和ipset解决
```

# 升级内核和ipset
## 升级内核
```
rpm地址: https://github.com/sealyun/kernel/releases/tag/v4.14.49
rpm -ivh kernel-4.14.49-1.x86_64.rpm
rpm -ivh kernel-devel-4.14.49-1.x86_64.rpm

修改grub配置，默认启动新内核
$ vim /etc/default/grub
修改成 GRUB_DEFAULT=0
$ grub2-mkconfig -o /boot/grub2/grub.cfg
```

## 升级ipset
```
yum install -y kernel-devel
yum install -y bzip2
wget http://ipset.netfilter.org/ipset-6.38.tar.bz2
cd ipset-6.38
bzip2 -d ipset-6.38.tar.bz2
tar xvf ipset-6.38.tar
cd /lib/modules/3.10.0-693.2.2.el7.x86_64
ln -s /usr/src/kernels/3.10.0-862.3.3.el7.x86_64 build
./configure && make && make install
```

# kubernetes启用ipvs
```
确保内核开启了ipvs模块
$ lsmod|grep ip_vs
ip_vs_sh               12688  0
ip_vs_wrr              12697  0
ip_vs_rr               12600  16
ip_vs                 141092  23 ip_vs_rr,ip_vs_sh,xt_ipvs,ip_vs_wrr
nf_conntrack          133387  9 ip_vs,nf_nat,nf_nat_ipv4,nf_nat_ipv6,xt_conntrack,nf_nat_masquerade_ipv4,nf_conntrack_netlink,nf_conntrack_ipv4,nf_conntrack_ipv6
libcrc32c              12644  3 ip_vs,nf_nat,nf_conntrack

没开启加载方式:
modprobe -- ip_vs
modprobe -- ip_vs_rr
modprobe -- ip_vs_wrr
modprobe -- ip_vs_sh
modprobe -- nf_conntrack_ipv4
```

>> https://sealyun.com/post/k8s-ipvs/
