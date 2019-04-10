# 错误信息：
```
Warning: 3.0.x versions of yum would erroneously match against filenames.
You can use "*/linux.so.2" and/or "*bin/linux.so.2" to get that behaviour
No Matches found

解决办法:
yum install -y *linux.so.2*
```

#　错误信息：
```
libgcc_s.so.1 must be installed for pthread_cancel to work
libgcc_s.so.1 must be installed for pthread_cancel to work
libgcc_s.so.1 must be installed for pthread_cancel to work
Neither host 'ntp-server' nor 'localhost' could be looked up with
./bin/resolveip
Please configure the 'hostname' command to return a correct
hostname.
If you want to solve this at a later stage, restart this script
with the --force option

解决办法:
yum install -y libgcc.i686
```

# 错误信息：
```
./bin/mysqld: error while loading shared libraries: libstdc++.so.5: cannot open shared object file: No such file or directory

解决办法:
yum -y install *libstdc++*
```

# 错误信息：
```
./bin/mysqld: error while loading shared libraries: libstdc++.so.6: cannot open shared object file: No such file or directory

解决办法:
yum whatprovides ibstdc++.so.6
yum install -y libstdc++-4.4.7-11.el6.i686
```

# 错误信息：
```
Installing MySQL system tables..../bin/mysqld: error while loading shared libraries:
libaio.so.1: cannot open shared object file: No such file or directory

解决办法：
yum install -y libaio-devel
```

如果此上办法不能解决所出现的问题  检查一下mysql版本32  64的版本错误会导致不能解决问题！
