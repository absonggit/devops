# 错误报告
mysqlbinlog这个工具是用来查看binlog文件内容的（使用方式man mysqlbinlog查看），但是使用mysqlbinlog时却报错如下：

```
[xxx@dbhost log]$ mysqlbinlog mysql-bin.000004
mysqlbinlog: unknown variable 'default-character-set=utf8'
# 原因是mysqlbinlog这个工具无法识别binlog中的配置中的default-character-set=utf8这个指令。
```

# 错误解决
1. 在MySQL的配置/etc/my.cnf中将default-character-set=utf8 修改为 character-set-server = utf8，但是这需要重启MySQL服务；

2. 使用参数 mysqlbinlog --no-defaults mysql-bin.000001
