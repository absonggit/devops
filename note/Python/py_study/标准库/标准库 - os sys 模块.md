# os 模块
| 序号 | 方法或属性 | 功能说明 | 示例 |
| :--- | :-------- | :------- | :-- |
| 1 | os.getcwd() | 获取当前路径 | os.getcwd() |
| 2 | os.chdir() | 切换目录 | os.chdir(r"/tmp") |
| 3 | os.curdir | 当前目录和 | os.curdir output: '.' |
| 4 | os.pardir | 上一级目录 | os.pardir  output: '..'|
| 5 | os.makedirs() | 递归创建目录 | os.makedirs("/tmp/123/123/123") |
| 6 | os.removedirs() | 递归删除目录 | os.removedirs("/tmp/123/123") |
| 7 | os.mkdir() | 创建指定目录 | os.mkdir("/dirname") |
| 8 | os.rmdir() | 删除指定空目录 | os.rmdir("/dirname") |
| 9 | os.listdir() | 列出指定目录下的所有文件和子目录（包含隐藏文件） | os.listdir(".") |
| 10 | os.remove() | 删除一个文件 | os.remove("/tmp/123") |
| 11 | os.rename() | 重命名文件/目录 | os.rename("oldname", "newname") |
| 12 | os.stat() | 查看文件属性 | os.stat(r"/tmp/123") |
| 13 | os.sep | 查看当前系统使用的目录分隔符 | os.sep "/" |
| 14 | os.linesep | 查看当前系统使用的换行符 | os.linesep "\n" |
| 15 | os.pathsep | 查看用于分割文件路径的字符串 | os.pathsep  ":" |
| 16 | os.name | 查看用字符串表示的系统平台 | os.name win-->"nt",linux-->"posix" |
| 17 | os.system() | 运行系统shell命令、仅执行不保存结果 | os.system("ls -l") |
| 18 | os.environ | 获取系统环境变量 | os.environ |
| 19 | os.path.abspath(path) | 返回path规范化的绝对路径 | os.path.abspath("tab.py") |
| 20 | os.path.split(path) | 将path分割成目录和文件名二元组返回 | os.path.split("/root/tab.py") |
| 21 | os.path.dirname(path) | 返回path的目录 |  |
| 22 | os.path.basename(path) | 返回path的文件名 |  |
| 23 | os.path.exists(path) | 如果path存在返回True，否则返回False |  |
| 24 | os.path.isabs(path) | 如果path是绝对路径返回True，否则返回False |  |
| 25 | os.path.isfile(path) | 判断是否是文件 |  |
| 26 | os.path.isdir(path) | 判断是否是目录 |  |
| 27 | os.path.join(path1[, path2[, ...]]) | 将多个路径组合返回，第一个绝对路径之前的参数将被忽略 |  |
| 28 | os.path.getatime(path) | 返回指定文件的atime |  |
| 29 | os.path.getmtime(path) | 返回制定文件的mtime |  |
| 30 | os.popen |  运行系统shell命令、获取返回结果 | os.popen().read()  |

```
cmd_res = os.popen('df -h').read()
print(cmd_res)
```

# sys 模块
| 序号 | 方法或属性 | 功能说明 | 示例 |
| :--- | :-------- | :------- | :-- |
| 1 | sys.argv | 返回命令行参数列表，第一个元素是程序本身路径 |  |
| 2 | sys.argv[n] | 返回命令行第n个参数列 |  |
| 3 | sys.exit(n) | 退出程序，正常退出exit(0) |  |
| 4 | sys.version | 获取python解释程序的版本信息 |  |
| 5 | sys.maxint | 最大int值 |  |
| 6 | sys.path | 返回模块的搜索路径，初始化时用py环境变量的值 |  |
| 7 | sys.platform | 返回操作系统平台名称 |  |
| 8 | sys.stdout.write() |  |  |

## sys.stdout实例 进度条
```
import sys, time
for i in range(50):
    sys.stdout.write("#")
    sys.stdout.flush()
    time.sleep(0.3)
```
