# gitlab打标签
```
# 列出已有的标签
git tag [-l v1.1*]

# 打标签
# git tag -a <tag_name> [-m "annotation"]

# 删除标签
git tag | grep "v1" | xargs git tag -d

# 查看指定标签的版本信息以及打标签的提交对象
git show <tag_name>

# 推送标签(--tags 全部标签也可以指定某个标签)
git push -u origin master [tag_name/--tags]

# 注意事项：打标签应该在git commit之后执行git tag命令
```

# jenkins参数化构建(根据git tags)
```
# 首先要安装Git Parameter插件 ---> 配置job ---> 选择参数化构建 ---> Git Parameter ---> 填写Name eg:GITLAB_TAG_OPTION 以及选择Parameter Type为tag
# 源码管理 ---> Repository ---> 填写Repository URl以及Credentials
               Branch Specifier ---> ${GITLAB_TAG_OPTION}

参数说明：
Parameter Type
Tag-为区分版本在代码中打上的标签
Branch-代码分支
Branch or Tag-以上两者的集合
Revision-每个代码提交对应的id
Pull Request- 我修改了你的代码，所以请求（request）你把我修改过的代码拉（pull）回去看看，比较少用到。

高级选项
Branch-指定分支
Branch Filter-分支过滤器，支持正则表达
Tag Filter-标签过滤器
Sort Mode-排序方式，顺序或倒序
Default Value-缺省值，无匹配值时的默认值
Selected Value-NONE，默认不选；TOP，默认选择第一个；DEFAULT，选择默认值
Use repository-指定代码仓库
Quick Filter-勾选之后，在构建时会在右侧显示过滤关键字输入框，输入关键字，可以过滤左侧的选项

# name必须为中文、英文模糊搜索不生效，原因不明
```

> jenkins + gitlab hook:  http://blog.csdn.net/kingboyworld/article/details/54175330

## 自动打标签
```
使用插件：Google Git Notes Publisher

安装好之后 ---> 在构建后操作步骤选择Git Publisher ---> tags/tag to push添加标签：tag-$BUILD_ID(把构建ID作为标签) ---> tag message(注释信息) ---> 勾选 create new tag ---> Target remote name(没有分之默认就是origin)

# 构建之后去gitlab查看标签信息
```

# harbor镜像推送
```
# 生成Dockerfile
cat > Dockerfile <<"EOF"
FROM tomcat:8.5-jre8-alpine

# 旧的修改时区时间相差8小时、后来不生效
#ENV TZ=Asia/Singapore
#RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#RUN echo "*/10 * * * * /usr/sbin/ntpdate time-a.nist.gov > /dev/null 2>&1" >> /var/spool/cron/crontabs/root

# 新的修改时区时间问题
RUN apk update && apk add ca-certificates && \
    apk add tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

RUN /bin/rm -rf /usr/local/tomcat/webapps/*
ADD dc-chain-service.tar.gz /usr/local/tomcat/webapps
ADD server.xml /usr/local/tomcat/conf
ADD context.xml /usr/local/tomcat/conf
EOF

# 生成镜像标签
[ -z `sudo docker images |grep "192.168.153.220/francis/stable"` ] || \
docker rmi 192.168.153.220/francis/stable
docker build -< dockerfile -t 192.168.153.220/francis/stable

# 推送到harbor仓库
docker login -ufrancis -pniHao123! 192.168.153.220
docker image push 192.168.153.220/francis/stable
docker logout 192.168.153.220
```
