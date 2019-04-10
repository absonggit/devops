基于各种原因我们的云平台关闭了，那么在这种情况下我们可以按照如下方法重新开启云平台
# 工具/原料
- /admin.php?action=cloud&operation=open
- discuzx_update_sitekey.php

# 方法/步骤
- 第一种情况，您在建站之初没有开通云平台，想在后面开通云平台的话您可以直接在浏览器地址栏输入：域名/admin.php?frames=yes&action=cloud&operation=open按照提示开通

- 第二种情况您已经开通过云平台了，基于各种原因我们的云平台关闭了，那么在这种情况下我们可以按照如下方法重新开启云平台。
    - 下载discuzx_update_sitekey.php到网站根目录（discuzx_update_sitekey.php下载地址见官方提示）
    - 在浏览器地址栏输入如下地址：
      - 域名/discuzx_update_sitekey.php
      - 运行discuzx_update_sitekey.php。
    - 浏览器地址栏输入
      - 域名/admin.php?action=cloud&operation=open
      - 按照提示重新开通云平台

# 注意事项
- discuzx_update_sitekey.php的下载尽量选择官网下载
