项目中的css、js在上线前，都需要经过压缩，而这个是通过gulp工具来实现的，这里就介绍下这套工具的下载安装过程。

1、安装node 去官网下载源码包、解压安装（或者直接yum install -y nodejs）
```
wget https://nodejs.org/dist/v4.2.2/node-v4.2.2.tar.gz  
tar xzf node-v4.2.2.tar.gz  cd node-v4.2.2  
./configure  
make && make install  
```

把node置成全局
```
ln -s /data/www/node-v4.2.2/node /usr/sbin/node
node -v  
显示v4.2.2
```

2、安装npm(如果node用yum安装的需要执行 ln -s /usr/local/bin/npm /usr/sbin/npm)
```
curl http://npmjs.org/install.sh | sudo sh  
# 若此步执行不成功，可以把install.sh文件下载下来，再执行  
#wget http://npmjs.org/install.sh
 #sh install.sh  
 npm -v  
 显示版本 3.3.12  
```

3、安装gulp，此步骤去项目里安装（如果安装不上、可以直接拷贝文件夹node_modules扔进去就可以）
```
npm install gulp --save-dev #本地  
npm install gulp --save-g #全局  
gulp -v  
[15:07:09] CLI version 3.9.0  
[15:07:09] Local version 3.9.0  
```

至此，基础工具都安装完成了，若是项目需要模块，可以使用npm下载，之后便使用gulp build命令完成压缩工作了。
