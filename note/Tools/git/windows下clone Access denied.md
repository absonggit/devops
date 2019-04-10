
# 报错
```
Cloning into 'static-resource'...
remote: HTTP Basic: Access denied
fatal: Authentication failed for
```

# 解决
## 第一步
清除用户密码信息、重新填写
```
git config --system --unset credential.helper
```

## 不行、继续第二步
修改.gitconfig、删除其他信息、如下：
```
[user]
    name = test
    email = test@test.com
```

> https://www.jianshu.com/p/8a7f257e07b8
