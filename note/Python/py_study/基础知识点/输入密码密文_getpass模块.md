getpass模块提供了两个函数：
- getpass.getpass()：提示用户输入密码。用户输入的内容并不会在屏幕上显示出来。
- getpass.getuser()：获得登陆的用户名

```
import getpass

pwd = getpass.getpass("请输入密码：")
```


#This function checks the environment variables LOGNAME, USER, LNAME and USERNAME, in order, and returns the value of the first one which is set to a non-empty string. If none are set, the login name from the password database is returned on systems which support the pwd module, otherwise, an exception is raised


这个函数会按顺序检查环境变量：LOGNAME,USER,LNAME,USERNAME
```
>>> import os
>>> os.system('echo $LOGNAME')
root
0
>>> os.system('echo $USER')
root
0
>>> os.system('echo $LNAME')
0
```
