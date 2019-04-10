# GRANT命令使用
`grant all privileges on *.* to 'db_user'@'localhost' identified by "passwd" with grant option;`
- ALL PRIVILEGES 是表示所有权限，你也可以使用select、update等权限。
- ON 用来指定权限针对哪些库和表。
- *.* 中前面的*号用来指定数据库名，后面的*号用来指定表名。
- TO 表示将权限赋予某个用户。
- 'db_user'@'localhost' 表示db_user用户，@后面接限制的主机，可以是IP、IP段、域名以及%，%表示任何地方。
- IDENTIFIED BY 指定用户的登录密码。
- WITH GRANT OPTION 这个选项表示该用户可以将自己拥有的权限授权给别人。
> 可以使用GRANT重复给用户添加权限，权限叠加，比如你先给用户添加一个select权限，然后又给用户添加一个insert权限，那么该用户就同时拥有了select和insert权限。

# 刷新权限
`flush privileges;`

# 查看权限
```
show grants;
# 查看当前用户权限

show grants for 'da_user'@'%';
# 查看某个用户的权限
```

# 回收权限
`revoke delete on *.* from 'db_user'@'%';`

# 删除用户
`drop user 'db_user'@'%'; `

# 对账户重命名
`rename user 'db_user1'@'%' to 'db_user2'@'%';`

# 修改密码
## 用mysqladmin
`mysqladmin -u用户名 password 密码`

## 用set password命令
`SET PASSWORD FOR 'root'@'localhost' = PASSWORD('123456');`

## 用update直接编辑user表
`update mysql.user set password=PASSWORD('123456') where User='root'; `

## 丢失root密码时
### 命令行的方式修改密码
```
# 需要先停库
mysql> service mysqld stop
mysql> mysqld_safe --skip-grant-tables &
mysql> mysql -uroot
mysql> \s
mysql> use mysql
mysql> update user set password = PASSWORD('123456') where user='root';
mysql> flush privileges;
```
### 修改数据库配置文件的方式修改密码
1. 修改数据库配置文件my.cnf(增加skip-grant-tables)
2. 重启数据库直接无密码进入修改

# MySQL权限列表
| 权限 | 权限级别 | 权限说明 |
| :--- | :------ | :------ |。 
| CREATE | 数据库、表或索引| 创建数据库、表或索引权限 |
| DROP | 数据库或表 | 删除数据库或表权限 |
| GRANT OPTION | 数据库、表或保存的程序 | 赋予权限选项 |
| REFERENCES | 数据库或表 |
| ALTER | 表 | 更改表，比如添加字段、索引等 |
| DELETE | 表 | 删除数据权限 |
| INDEX | 表 | 索引权限 |
| INSERT | 表 | 插入权限 |
| SELECT | 表 | 查询权限 |
| UPDATE | 表 | 更新权限 |
| CREATE VIEW | 视图 | 创建视图权限 |
| SHOW VIEW | 视图 | 查看视图权限 |
| ALTER ROUTINE | 存储过程 | 更改存储过程权限 |
| CREATE ROUTINE | 存储过程 | 创建存储过程权限 |
| EXECUTE | 存储过程 | 执行存储过程权限 |
| FILE | 服务器主机上的文件访问 | 文件访问权限 |
| CREATE TEMPORARY TABLES | 服务器管理 | 创建临时表权限 |
| LOCK TABLES | 服务器管理 | 锁表权限 |
| CREATE USER | 服务器管理 | 创建用户权限 |
| PROCESS | 服务器管理 | 查看进程权限 |
| RELOAD | 服务器管理 | 执行flush-hosts, flush-logs, flush-privileges, flush-status, flush-tables, flush-threads, refresh, reload等命令的权限 |
| REPLICATION CLIENT | 服务器管理 | 复制权限 |
| REPLICATION SLAVE | 服务器管理 | 复制权限 |
| SHOW DATABASES | 服务器管理 | 查看数据库权限 |
| SHUTDOWN | 服务器管理 | 关闭数据库权限 |
| SUPER | 服务器管理 | 执行kill线程权限 |

# MYSQL的权限分布
| 权限分布 | 可能的设置的权限 |
| :----- | :--------------- |
| 表权限 | 'Select', 'Insert', 'Update', 'Delete', 'Create', 'Drop', 'Grant', 'References', 'Index', 'Alter' |
| 列权限 | 'Select', 'Insert', 'Update', 'References' |
| 过程权限 | 'Execute', 'Alter Routine', 'Grant' |
