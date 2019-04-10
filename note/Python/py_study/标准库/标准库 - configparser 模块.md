# ConfigParser 模块
用于生成和修改常见配置文档
1. 生成文件
```python
import configparser

config = configparser.ConfigParser()
config["DEFAULT"] = {'ServerAliveInterval': '45',
                     'Compression': 'yes',
                     'CompressionLevel': '9'}
config['bitbucket.org'] = {}
config['bitbucket.org']['User'] = 'hg'
config['topsecret.server.com'] = {}
topsecret = config['topsecret.server.com']
topsecret['Host Port'] = '50022'
topsecret['ForwardX11'] = 'no'
config['DEFAULT']['ForwardX11'] = 'yes'
with open("conf.ini", 'w') as configfile:
    config.write(configfile)

output:
[DEFAULT]
compressionlevel = 9
compression = yes
serveraliveinterval = 45
forwardx11 = yes

[bitbucket.org]
user = hg

[topsecret.server.com]
host port = 50022
forwardx11 = no
```

2. 读取文件
```python
import configparser

config = configparser.ConfigParser()
config.read("conf.ini") #读取文件(DEFAULT除外)
print(config.defaults())  #读取默认的DEFAULT
print(config["bitbucket.org"]["User"])

f = config["bitbucket.org"]

for i in f: #循环输出的时候同DEFAULT一同输出，否则不用DEFAULT命名
    print(i)
```
