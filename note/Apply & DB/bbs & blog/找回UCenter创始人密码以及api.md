# 找回UCenter创始人密码
1. 打开$bbs/uc_server/data/config.inc.payshop 找到类似以下代码：
```php
define('UC_FOUNDERPW', '256955f2e034sad74f0e2953572ea360');
define('UC_FOUNDERSALT', '217804');
```
2. 然后用以下代码替换
```
define('UC_FOUNDERPW', '047099adb883dc19616dae0ef2adc5b6');
define('UC_FOUNDERSALT', '311254');
```
3. 最后登录后台ucenter创使用 使用密码：123456789 登录进去修改密码即可；

# 修改api:
`vim bbs/config/config_ucenter.php`
