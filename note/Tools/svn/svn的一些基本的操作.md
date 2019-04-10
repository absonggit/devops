检出checkout(co)　　
```
svn co ${url}　　
```

更新update(up)　　
```
svn up　　
```

提交commit(ci)　　
```
svn ci -m " 修改xxx 问题"　　
```

查看当前目录最近5 次提交记录　　
```
svn log -l 5　　
```

查看当前工作拷贝信息　　
```
svn info　　
```

查看当前未提交的文件status(st)　　
```
svn st　
```　
这个命令输出每个添加、修改、删除过的目录和文件，前面的C 表示冲突，要特别注意。linux 下也可以用svn st | grep ^C 来查看冲突项。　　

查看当前修改内容　　
```
svn diff
```

撤销当前修改，覆盖为资源库最新版本　　
```
svn revert path/filename
```　
　
递归撤销当前目录修改，覆盖为资源库最新版本。注意新加的文件不会被删除，这时也可以删除工作拷贝，重新checkout　　
```
svn revert . --recursive     
```

合并　　
```
SVN merge
```
