# 修改配置文件
修改配置文件config/config_global.php 和 config_global_default.php
```
$_config['cookie']['cookiedomain'] = 'new_domain';
$_config['admincp']['runquery'] = 1;  // 是否允许后台运行 SQL 语句 1=是 0=否[安全]
```

# 请直接使用 http://new_domain/admin.php 登录后台。

# 修改后台设置
1. 后台==>全局==>站点信息==>网站url
2. 后台==>全局==>域名设置==>应用域名==>论坛和根域名设置手机版访问设置：--- 手机发帖来源自定义:
3. 后台==>界面==>导航==>链接里面使用了绝对地址需要修改为新域名
4. 后台==>运营==>关联连接，没有设置就不用修改，在这里主要涉及优化  （站点宣传广告、友情链接）
5. 后台==>云平台==>同步站点信息   后台—工具—去平台诊断工具 （可能要手动设置IP）
6. 后台==>站长==>ucernter设置==>ucenter访问地址
7. ucenter==>应用管理==>应用的主urlBBS导航---顶部、底部  （版规网址要更新），论坛格子广告，贴间广告，列表广告全部要更新。

- 修改遇到的问题解答：
    - 如果您已经修改了域名解析请直接使用http://新域名/admin.php登录之后，进行上述修改
    - 后台登陆不了，被自动退出
    ```
    请把config/config_global.php中的$_config['admincp']['checkip'] = 1;
    修改为$_config['admincp']['checkip'] = 0;
    ```


- 完成以上工作后，您已经可以正常访问新域名了，但是原来已经发贴的内容网址没有变化，要执行下面的步骤才会变新网址。

1. 进入DZ后台：站长 – 数据库 – 升级

2. 使用批量替换--贴子网址
`UPDATE pre_forum_post SET message=REPLACE(message,'dqgcw.com','rdzjw.com');`

3. 批量替换--标题网址
`UPDATE pre_forum_thread SET subject=REPLACE(subject,'dqgcw.com','rdzjw.com');`
