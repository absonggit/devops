**默认情况下，登录后台后若管理员的IP发生变化，或超过1800秒（半小时）未操作，需要重新登录**
# 取消IP限制（管理员IP发生变化时，后台无需重新登录
- 打开 config/config_global.php 文件，
- 将 config['admincp']['checkip'] 的值由 1 改为 0

# 修改超时时间。
- 打开 source/class/discus/discuz_admincp.php 文件，将 var $sessionlife = 1800; 中的值修改为您需要的时间（秒），例如超过3小时才需要重新登录，则此处设置为 10800 。
