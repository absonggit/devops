# 解决Discuz打开应用中心插件慢的问题
1. 打开$discuz/source/admincp/admincp_plugins.php文件
搜索`dsetcookie('addoncheck_plugin', 1, 3600);`
修改为`dsetcookie('addoncheck_plugin', 1, 43200);`
- `55 dsetcookie('addoncheck_plugin', 1, 43200);`

2. 搜索`cloudaddons_validator($plugin['identifier'].'.plugin');`将其删除
- `632 cloudaddons_validator($plugin['identifier'].'.plugin');`
