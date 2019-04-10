https://cloud.tencent.com/developer/article/1115119

1、修改nginx配置文件，proxy_pass不进行前端访问ip进行后转   【临时解决方案】
2、修改/opt/gitlab/embedded/service/gitlab-rails/config/initializers/1_settings.rb添加白名单 【修改源码的方案】
3、在/etc/gitlab/gitlab.rb中添加白名单  【本文采取方案】


查看设置白名单的配置文件
```
    "gitlab-rails": {
      "rack_attack_git_basic_auth": {
        "enabled": true,
        "ip_whitelist": [
          "127.0.0.1"
        ],
        "maxretry": 300,
        "findtime": 5,
        "bantime": 60
      },
```

> 官方：https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/files/gitlab-config-template/gitlab.rb.template
