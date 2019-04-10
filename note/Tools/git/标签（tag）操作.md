# 列出所有tag
```
$ git tag
```

# 打轻量标签
```
$ git tag [tag name]
```

# 附注标签
```
$ git tag -a [tag name] -m [message]

例如，打v1.0标签
$ git tag -a v1.0 -m 'v1.0 release'
```

# 后期打标签tag
```
$ git tag -a [tag name] [version]
```

# 删除本地tag
```
$ git tag -d [tag]

例如，删除本地v1.0 标签0
$ git tag -d v1.0
```
# 删除远程tag
```
$ git push origin --delete tag <tagname>
还有另外一种方式来删除，推送一个空tag到远程
$ git tag -d <tagname>
$ git push origin :refs/tags/<tagname>
```

# 查看tag信息
```
$ git show [tag]
```

# 提交指定tag
```
$ git push [remote] [tag]

例如，将v1.0标签推送到远程服务器上
$ git push origin v1.0
```
# 提交所有tag
```
$ git push [remote] --tags
```

# 如何检出git仓中最新的tag的代码
```
# Get new tags from remote  
git fetch --tags  

# Get latest tag name  
LatestTag=$(git describe --tags `git rev-list --tags --max-count=1`)  

# Checkout latest tag  
git checkout $LatestTag  
```
