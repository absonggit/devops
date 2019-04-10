**Discuz X3.3 的升级安装、HTTPS 部署及提示**
# 前言
Discuz 已经没有曾经的辉煌了，从 14年 发布 DZX 3.2 到 17年发布 DZX 3.3 竟然时隔三年，而且并没有带来新特性、新功能。所以在 2017年 各位门户、论坛站长对于网站的模式都应当进行考虑了。

# DZX3.3

- 一、DiscuzX 3.3 主要的更新就是兼容 PHP 7.0 和 7.1，在条件能及的的情况下尽量将 PHP 版本升高，PHP7.0 的性能提升我就不多阐述了，PHP7.1 相比 PHP 7.0 依旧有可观的性能提升，主要来自 OPcache 拓展，如果不使用 OPcache 则升级意义不大。

- 二、官方的说法，DiscuzX 3.3 本身已经有良好的 HTTPS 支持了，经过测试如果不考虑云平台，的确可以。不过往往一个大论坛会使用多个插件和一些非 DZ 内核的功能，疾病已深修改起来会非常的乏力，不见得就能马上应用，是否升级需要三思。

- 三、目前官方推荐在 PHP7 下使用 Redis 或者 Memcached 作缓存，推荐 Redis。

- 四、DZ 官方的说法是想要新功能请使用 DZF 和 DZLite，官方只会维护核心。

    - 简体中文GBK
http://download.comsenz.com/DiscuzX/3.3/Discuz_X3.3_SC_GBK.zip

    - 繁体中文 BIG5
http://download.comsenz.com/DiscuzX/3.3/Discuz_X3.3_TC_BIG5.zip

    - 简体 UTF8
http://download.comsenz.com/DiscuzX/3.3/Discuz_X3.3_SC_UTF8.zip

    - 繁体 UTF8
http://download.comsenz.com/DiscuzX/3.3/Discuz_X3.3_TC_UTF8.zip

# 注意点

- 一、 要在原 PHP 版本（5.6/5.5/5.4） 下进行升级至 DZX 3.3，再迁移至 PHP7.0/7.1 环境。

- 二、 Discuz 设置 HTTPS 后，如何批量将 http 协议改成 https 协议？执行此 SQL 语句即可批量替换文章内的协议了`UPDATE pre_forum_post SET message=REPLACE(message,’http://旧网址.com’,’https://新网址.com’);`

- 三、升级 PHP7 的话，请考虑第三方应用是否支持PHP7

# 推荐阅读
https://www.mf8.biz/tag/https/ ，包括 Nginx、Apache Httpd、IIS 设置  HTTPS、HTTP/2 的教程和进阶。

# 升级方式

## DiscuzX 程序  3.1， 3.2
- 上传 X3.3 程序（压缩包中 upload 目录中的文件）， 如上传时候提示覆盖目录，请选择“是” 升级完毕，进入后台，更新缓存，并测试功能

## DiscuzX 程序  1.0, 1.5 2.0 ， 2.5Beta， 2.5RC，2.5， 3.0
1. 备份数据库
2. 建立文件夹 old，旧程序除了 data ，  config， uc_client, uc_server 目录以外的程序移动进入 old目录中
上传 X3.3 程序（压缩包中 upload 目录中的文件）， 如上传时候提示覆盖目录，请选择“是” 上传安装包 utility 目录中的 update.php 到论坛 install 目录，删除 install 目录中的index.php 执行 http://你的域名/论坛路径/install/update.php
3. 参照提示进行升级即可。升级时间随着数据的大小和服务器性能而变。
4. 升级完毕，进入后台，更新缓存，并测试功能。
5. 升级成功后，old目录中的文件可以删除了。

## Discuz! 7.2 或以下版本的程序
1. 首先参看我们的转换教程， 将程序转换到 X2.0
2. 上传 X3.3 程序
3. 上传 utility 目录中的 update.php 到 install 目录，删除目录中的index.php
4. 执行 http://你的域名/论坛路径/install/update.php
5. 参照提示进行升级即可
