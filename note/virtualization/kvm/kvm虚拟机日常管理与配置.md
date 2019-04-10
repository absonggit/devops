virsh
        start           开始一个（以前定义的）非活跃的域
        shutdown        关闭一个域
        reboot          重新启动一个域
        suspend         挂起一个域
        resume          重新恢复一个域
        edit            编辑某个域的 XML 配置
        vncdisplay      vnc 显示
        domstate        域状态
        list            列出域
        dominfo         域信息
        quit            退出子命令界面
        dominfo         查看系统信息
        setmem          修改内存
        destroy         停掉一个域
        undefine        彻底删除域


virt-manager       开启图形管理界面

qemu-img info /kvm/vm_img/prea/centos65.img     查看磁盘格式

virsh autostart 名称      开机自动启动虚拟机

## 克隆
### kvm宿主机操作(关机状态)
```
virt-clone -o 虚拟机名字或者ID -n 新的虚拟机名字 -f 指定新克隆虚拟机路径
```

### 复制配置文件与磁盘文件(开机状态)


## 修改cpu和内存
```
virsh dominfo 虚拟机名字或ID |grep memory
virsh setmem  虚拟机名字 1024
virsh edit 虚拟机名字
```
