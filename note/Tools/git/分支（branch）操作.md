# 列出所有本地分支
```
$ git branch
```

# 列出所有远程分支
```
$ git branch -r
```

# 列出所有本地分支和远程分支
```
$ git branch -a
```

# 新建一个分支，但依然停留在当前分支
```
$ git branch [branch-name]

例如，创建名称为dev的分支：
$ git branch dev
```

# 新建一个分支，并切换到该分支
```
$ git checkout -b [branch]

例如，创建名称为dev的分支并切换到该分支上
$ git checkout -b dev
```

# 切换到指定分支，并更新工作区
```
$ git checkout [branch-name]

例如，切换到dev分支上
$ git checkout dev
```

# 合并指定分支到当前分支
```
$ git merge [branch]

例如，当前在master分支上，将dev分支合并到当前master分支上来
$ git merge dev
```

# 删除分支
```
$ git branch -d [branch-name]

例如，删除本地dev分支
$ git branch -d dev
```

# 将本地分支推送到远程服务器

# 删除远程分支
```
$ git push origin --delete <branchName>

例如，删除远程的dev分支
$ git push origin --delete dev
否则，可以使用这种语法，推送一个空分支到远程分支，其实就相当于删除远程分支：

$ git branch -d <branchName>
$ git push origin :<branchName>
```
