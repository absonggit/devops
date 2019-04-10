# shutil 模块
高级的文件、文件夹、复制、压缩包处理模块

1. shutil.copyfileobj() 把一个文件的内容复制给另外一个文件
```
shutil.copyfileobj(src, dst)

s_file = open("source_file", encoding="utf-8")
d_file = open("destination_file", 'w', encoding="utf-8")
shutil(s_file, d_file)
```

2. shutil.copyfile() 拷贝文件
```
shutil.copyfile(src, dst)
```

3. shutil.copymode() 仅拷贝权限，内容、组、用户均不变
```
shutil.copymode(src, dst)
```

4. shutil.copystat() 拷贝状态的信息：mode bits, atime, mtime, flags
```
shutil.copystat(src, dst)
```

5. shutil.copy() 拷贝文件和权限
```
shutil.copy(src, dst)
```

6. shutil.copy2() 拷贝文件和状态信息
```
shutil.copy2(src, dst)
```

7. shutil.copytree() 递归的去拷贝文件,目录
```
shutil.copytree(src, dst, symlinks-False, ignore=None)
```

8. shutil.rmtree() 递归的去删除文件，目录
```
shutil.rmtree(path[, ignore_errors[, onerror]])
```

9. shutil.move() 移动文件
```
shutil.move(src, dst)
```

10. shutil.make_archive() 创建压缩包，并返回路径
```
shutil.make_archive(base_name, format, ...)
base_name 压缩的文件名，也可以是路径
format 压缩包类型：zip、tar、bztar、gztar
owner 用户，默认当前用户
group 组，默认当前组
logger 用于记录日志，通常是logging.Logger对象

shutil.make_archive("test_archive.zip", "zip", "/root/python/test_archive")
```
- shutil对压缩包的处理时调用ZipFile和TarFile两个模块来进行的
```
import zipfile

# 压缩
z = zipfile.ZipFile('laxi.zip', 'w')
z.write('a.log')
z.write('data.data')
z.close()

# 解压
z = zipfile.ZipFile('laxi.zip', 'r')
z.extractall()
z.close()

import tarfile

# 压缩
tar = tarfile.open('your.tar','w')
tar.add('/Users/wupeiqi/PycharmProjects/bbs2.zip', arcname='bbs2.zip')
tar.add('/Users/wupeiqi/PycharmProjects/cmdb.zip', arcname='cmdb.zip')
tar.close()

# 解压
tar = tarfile.open('your.tar','r')
tar.extractall()  # 可设置解压地址
tar.close()
```
