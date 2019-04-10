# 安装python3.5

## 准备编译环境
```
yum groupinstall 'Development Tools'
yum install zlib-devel bzip2-devel  openssl-devel ncurses-devel
```

## 下载Python3.5代码包
```
wget  https://www.python.org/ftp/python/3.5.0/Python-3.5.0.tar.xz
```

## 编译
```
tar Jxvf  Python-3.5.0.tar.xz
cd Python-3.5.0
./configure --prefix=/usr/local/python3
make && make install
```

## 设置环境变量
```
echo 'export PATH=$PATH:/usr/local/python3/bin' >> ~/.bashrc
```

# python3直接替换python2

## 安装python3同上

## 替换python2
```
rm   /usr/bin/python
ln -sv  /usr/local/bin/python3.5 /usr/bin/python
这样做的目的是在系统任意目录敲入python调用的是python3的命令，而非系统默认2.6.6的
但是这样同时这会导致依赖python2.6的yum不能使用，因此还要修改yum配置
```

## 更新yum配置。
```
ll /usr/bin | grep python
这时/usr/bin目录下面是包含以下几个文件的（ll |grep python），其中有个python2.6，只需要指定yum配置的python指向这里即可
vim /usr/bin/yum
通过vim修改yum的配置
#!/usr/bin/python改为#!/usr/bin/python2.6，保存退出。
完成了python3的安装。
```
# 安装pip
```
wget https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
```

# 安装git：
```
yum install git
```

#安装django
```
pip install django
ln -s /var/python3/lib/python3.3/site-packages/django/bin/django-admin.py    /usr/bin/django-admin.py
#这里视你的django安装位置而定——一般是python的site-packages下。
如果pip没法执行，直接去官方下载Django最新版，编译安装。
它会安装在你的python3目录里面，所以需要配置环境变量。
```

# 修复python2
```
如果不小心误删除了/usr/bin/python2这个文件，导致yum不能使用。
解决办法——重装相关的rpm文件。
所有的rpm文件可以在网易提供的景象中下载，应该是国内比较快的地方了，
地址：http://mirrors.163.com/centos/6.5/os/i386/Packages/。
rpm列表如下：
python-2.6.6-29.el6.x86_64.rpm
python-devel-2.6.6-29.el6.x86_64.rpm
python-iniparse-0.3.1-2.1.el6.noarch.rpm
python-setuptools-0.6.10-3.el6.noarch.rpm
python-urlgrabber-3.9.1-8.el6.noarch.rpm
rpm-python-4.8.0-19.el6.x86_64.rpm
yum-3.2.29-22.el6.centos.noarch.rpm
yum-metadata-parser-1.1.2-16.el6.x86_64.rpm
python-pycurl-7.19.0-8.el6.x86_64.rpm

注意rpm命令，必须要追加 –replacepkgs 参数，强制其重新安装，否则rpm会报告说package已安装。

rpm -Uvh --replacepkgs ***.rpm
```
