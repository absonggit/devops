1. 在linux mysql下通过md5生成想要的密码；
```mysql
mysql ­uuser ­ppassword
$select md5("password");
```

2. 客户端连接数据库;根据UID找出相关记录；修改密码；
```mysql
SELECT * FROM p_ucenter_members WHERE uid = "37391";
```
