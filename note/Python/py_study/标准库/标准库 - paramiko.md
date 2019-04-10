# 简介
paramiko是用python语言写的一个模块，遵循SSH2协议，支持以加密和认证的方式，进行远程服务器的连接。

# 安装
linux && windows 直接通过pip安装即可
- `pip3 install paramiko`

# 使用
## 基于SSH用户密码远程连接示例
```python
#!/usr/bin/evn python
import paramiko

ssh = paramiko.SSHClient()    #创建SSH对象
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())    #允许连接不在know_hosts文件中的主机
ssh.connect("192.168.153.199", 22, "root", "nihao123!")    #连接服务器
#ssh.connect(hostname="192.168.153.199", port=22, username="root", password="nihao123!")    $hostname port username password写不写都可以
stdin, stdout, stderr = ssh.exec_command("ip addr")    #执行命令
result = stdout.read()
print(result.decode())
ssh.close()
```

## 基于公钥私钥远程连接示例
```python
#!/usr/bin/env python
import paramiko

private_key = paramiko.RSAKey.from_private_key_file("/root/.ssh/id_rsa.txt")    #指定私钥
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(hostname="192.168.153.199", port=22, username="root", pkey=private_key)
stdin, stdout, stderr = ssh.exec_command("df -h")
result = stdout.read()
print(result.decode())
ssh.close()
```

## 上传文件到远程服务器示例
```python
#!/usr/bin/evn python
import paramiko

t = paramiko.Transport(("192.168.153.199", 22))
t.connect(username="root", password="nihao123!")
sftp = paramiko.SFTPClient.from_transport(t)
remotepath = "/root/python/pip-9.0.1.tar.gz"
localpath = "D:\python\pip-9.0.1.tar.gz"
sftp.put(localpath, remotepath)
t.close()
```

## 从远程下载文件示例
```python
#!/usr/bin/evn python
import paramiko

t = paramiko.Transport(("192.168.153.199", 22))
t.connect(username="root", password="nihao123!")
sftp = paramiko.SFTPClient.from_transport(t)
remotepath = "/root/python/test_get.txt"
localpath = "D:\python\\test_get.txt"
sftp.get(remotepath, localpath)
t.close()
```
