# 检出是否安装VNC
```
rpm -q tigervnc tigervnc-server
```

# 安装安装X-Window
```
yum check-update
yum groupinstall "X Window System"
yum install gnome-classic-session gnome-terminal nautilus-open-terminal control-center liberation-mono-fonts
unlink /etc/systemd/system/default.target
ln -sf /lib/systemd/system/graphical.target /etc/systemd/system/default.target
reboot #重启机器
```

# 安装VNC
```
yum install tigervnc-server -y
```

# 从VNC备份库中复制service文件到系统service服务管理目录下
```
cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service      #复制并被重命名为vncserver@:1.service

修改vncserver@:1.service文件
# grep -n "^[^#]" /etc/systemd/system/vncserver@\:1.service
33:[Unit]
34:Description=Remote desktop service (VNC)
35:After=syslog.target network.target
37:[Service]
38:Type=forking
39:User=root
42:ExecStartPre=-/usr/bin/vncserver -kill %i
43:ExecStart=/sbin/runuser -l root -c "/usr/bin/vncserver %i"
44:PIDFile=/root/.vnc/%H%i.pid
45:ExecStop=-/usr/bin/vncserver -kill %i
47:[Install]
48:WantedBy=multi-user.target

# systemctl daemon-reload
```

# 为vncserver@:1.service设置密码
```
vncpasswd
```

# 启动VNC
```
# systemctl enable vncserver@:1.service #设置开机启动
# systemctl start vncserver@:1.service #启动vnc会话服务
# systemctl status vncserver@:1.service #查看nvc会话服务状态
# systemctl stop vncserver@:1.service #关闭nvc会话服务
# netstat -lnt | grep 590*      #查看端口
tcp        0      0 0.0.0.0:5901            0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:5901            0.0.0.0:*               LISTEN
```
