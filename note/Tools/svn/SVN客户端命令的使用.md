# 将文件checkout到本地目录
```
# svn co svn://xx.xx.xx.xx/testversion1/ /svndata/ --username=kevin --password=kevin111
```

co即为checkout的缩写，这里也可以直接写checkout，将testversion1版本库的内容检出到svndata目录。默认最新版本。如果要检出指定的revision，加上命令 -r 2 即可检出revision 2.


# 往版本库中添加新文件及提交
## 添加新文件
```
# svn add test.php
# svn add *.php
```

## 提交文件到版本库
```
# svn commit -m "add test file for my test" test.php
简写 svn ci
```

# 更新到某个版本
- svn update     #如果后面没有目录，默认将当前目录以及子目录下的所有文件都更新到最新版本。简写 svn up
- svn update -r 200 test.php     #将版本库中的test.php文件还原到版本200
- svn update test.php     # 更新，与版本库同步。如果在提交的时候提示过期的话，是因为冲突，需要先update，修改文件，然后清除svn resolved，最后再提交commit


问题一
可能会碰到Can't convert string from 'UTF-8' to native encoding的报错

从客户端提交文件到服务器，客户端文件的文件名为中文，这个时候有可能碰到这种情况

解决：
```
# export LC_CTYPE="en_US.UTF-8"
# export LC_ALL=
```
