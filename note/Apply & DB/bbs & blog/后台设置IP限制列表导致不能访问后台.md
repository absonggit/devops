- 后台设置了IP限制列表导致访问不了后台
- 首先就是进入数据库之后，在 common_setting 表中搜索 skey 为 adminipaccess ，然后删除svalue中的值就搞定了
`select * FROM pre_common_setting where skey = "adminipaccess";`
