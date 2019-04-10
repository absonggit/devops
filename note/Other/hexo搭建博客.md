### 一、搭建流程：
hexo是个博客框架，编辑好博客后，用在git shell上，gitshell上有个 hexo generate 命令就能生成一个静态页面。这个网站可以在本地看也可以在网上看，如果在网上看就需要上传到网站上，github上刚好有个github pages就有这个功能。新建一个yourname.github.io仓库、这个特殊仓库会自动把github pages功能打开，也就是说会自动把这个仓库中的master里的html静态文件显示到 http://yourname.github.io 这个网站上。

Gighub Pages介绍：<br>
Gighub Pages是一个免费的静态网站托管平台，但是由于他的空间免费稳定、免流量费、所以做博客也不是不错的。每个账号只能有一个仓库来存放个人主页、而且仓库的名字必须是yourname.github.io这个特殊的命名约定。个人主页的网站内容还必须放在mster分之下，创建之后可以通过 http://yourname.github.io 来访问。

### 二、准备工作：
##### 1、下载 Git 并安装
- 登录github https://github.com/ 注册一个账号。注册账号时候起的名字就是你的【yourname】，以后会经常用到。

- 下载桌面端github https://desktop.github.com/ 下一步安装即可。安装结束后，空白桌面右键会多出两个Git  GUI Here和Git Bash Here。
<br> # 在Git Bash 中  可以使用 `$ git --version` 查看安装版本

##### 2、下载 Node.JS 并安装
- 下载Node.JS LTS稳定版https://nodejs.org/en/。 默认会安装npm。
<br> # Node.JS是Javascrip运行环境，npm是Nodj.JS包管理和分发工具
<br> # `node -v`  #查看node版本
<br> # `npm -v`   #查看npm版本

##### 3、下载 hexo 并安装
- 空白桌面右键打开Git Bash、输入 `$ npm install -g hexo-cli` 回车。
(使用npm包管理工具安装hexo)

### 三、使用hexo搭建本地博客
- 新建一个文件夹、eg：d:\MyBlog

- 进入该文件夹、右键Git Bash Here 在弹出的命令行输入 `$ hexo init`  或者 直接在D:\下 右键Git Bash Here，输入  `$ hexo init MyBlog`。
<br> # 这个MyBlog就是博客的根目录、初始化生成模板之后会多出一些文件)

- 为hexo安装插件 "hexo-deployer-git"，输入 `$ npm install hexo-deployer-git --save`。
<br> # 这个插件是用来向github中上传html时用到的、安装好之后可以在$blog\node_modules中看到。不安装直接`$ hexo d` 会弹出"error deployer not found:git"这个错误。
- 生成静态页面 `$ hexo g`。
<br> # 执行此命令会在根目录下生成一个新的public的文件夹。

- 启动服务 `$ hexo s`。同时会在当前目录生成一个新的叫public的文件夹。

- 本地预览 http://localhost:4000

### 四、主题设置
这里以主题yilia为例说明：
- 安装主题 <br>
`$ hexo clean` <br>
`git clone https://github.com/litten/hexo-theme-yilia.git themes/yilia`

- 启用主题 <br>
修改根目录下的_config.yml配置文件中的theme属性，将其设置为yilia。

- 更新主题
```
$ cd themes/yilia
$ git pull
$ hexo g
$ hexo s
```

###### 补充命令
``` Bash
hexo常用命令：
$ hexo new "PostName"           #新建文章
$ hexo new pate "PageName"      #新建页面

hexo常用简写：
$ hexo n == hexo new
$ hexo g == hexo generate
$ hexo s == hexo server
$ hexo d == hexo deploy

常用组合：
$ hexo d -g     #生成部署
$ hexo s -g     #生成预览
```

### 五、部署/发布到github
##### 1、配置github
- 注册并登录到github之后、在主页面选择"New repository"

- 进入仓库创建页面、输入"yourname".github.io (这个github.io官方规定格式、必须这样写。)
- 检查SSH Keys的设置、一般在c:\用户\用户名\. ssh这个文件夹(id_rsa、id_rsa.pub)

- 如果有忽略此步骤、没有.ssh这个文件、那么需要生成新的key：`$ ssh-keygen -t rsa -C "name@mail.com"`

- 添加ssh key到GitHub：打开id_rsa.pub文件、复制全部内容

- 登录Github。View profile and more--->Settings--->SSH and GPG keys--->New SSH key 将刚才复制的内容粘贴到文本框中、写个标题、确认即可。
- 测试连接：`$ ssh -T git@github.com`、如果成功的话会弹出确认连接信息、选择yes即可、测试连接后再c:\用户\用户名\. ssh文件夹会多出一个known-hosts信任文件。

- 配置hexo deploy部署到github：打开根目录_config.yml文件最顶端如下修改并保存
```
deploy:
  type: git
  repository: https://github.com/francis19870605/francis19870605.github.io.git
  branch: master
# :号后边一定要加空格。
```
- 现在就可以` $hexo d -g`直接推代码到github中了

### 六、用markdown写文章
##### 1、使用atom工具并安装如下插件
- markdown-scroll-sync
- linter-markdown
- markdown-writer
- markdown-toc
- markdown-pdf
- markdown-preview

##### 2、为hexo安装插件
- markdown是纯文本标记语言，需要解析器来渲染。前面的markdown-preview是atom里的解析器。现在我们在hexo生成html博客的时候还需要自己的解析器。

- hexo知道的hexo-renderer-marked解析器，不够吊，要换成hexo-renderer-markdown-it。
```
$ npm un hexo-renderer-marked -save
$ npm i hexo-renderer-markdown-it
```

##### 3、编辑文章
- 使用atom打开$blog\source\_posts\下的hello-world.md文档进行编辑。

- `$ hexo g`    # 生成静态html文件

- `$ hexo s`    # 本地查看效果

- `$ hexo d`    # 发布到github

### 七、绑定域名
- 搭建好博客后、可以用GitHub的二级域名访问、但是终归没有自己的域名舒服、所以需要设置自己的域名绑定到这个博客上。
  - 域名服务商的设置
    - 添加2条A记录
      - @--->192.30.252.154
      - @--->192.30.252.153
    - 添加一条CNAME
      - CNAME--->francis19870605.github.io
  - 博客添加CNAME文件
    - 进入博客目录、在source目录下新建CNAME文件、写入域名即可
  - `$ hexo d -g`
