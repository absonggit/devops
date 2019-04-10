1、ansible -vvvv            //查看错误的详细信息

2、playbook.yml文件首行添加`#!/usr/bin/evn ansible-playbook`就可以直接运行`$./playbook.yml`
当类UNIX操作系统中的文本文件第一行前两个字符为#!时，这种语法特性叫做“shebang”特性。运行时程序载入器会分析#!后边的内容，将这些内容作为解释器指令并输出如下内容:
```
"Gathering Facts ******************************************************************"
```

3、YAML文件开头的三个减号 ---  标记文档的开始   如果不写不影响程序运行

4、YAML字符串可以不用引号、即便有空格

5、YAML内置常用布尔类型 True False

6、YAML列表使用 - 作为分隔符
```
- My Fair Lady    
- The Pirates  
等同于 YAML内联格式  [My Fair Lady,The Pirates]
```

7、YAML字典
```
address: 742 Evergreen
city: Wkiokd
等同于 YAML内联格式 {address: 742 Evergreen,city: Wkiokd}
```

8、YAML字典折行(用>标记折行)
```
address: >
      742 Evergreen,
      Oilsiijfee ksdl jji,
      Ajioo ijls
city: Wkiokd
```

9、task handlers区别：handlersshi ansible提供的条件机制之一、需要task通知时才运行（**task讲handler的name作为参数传递来通知handler**）
在需要通知条件的task中定义notify：
```
tasks:
- name: copy blacklist
  copy: src= desc=
  nofity: restart nginx   *
- name : copy whilelist
  copy: src= desc=
handers:
- name: restart nginx
  service: name=nginx state=restarted            //只有当copy blacklist 事件触发时 才会触发通知
```
10、handers 只有在所有任务执行完后才会执行、即使被通知多次、它也只会执行一次、handers按照play中定义的顺序执行、而不是被通知的顺序。
handers常见用途就是重启服务

11、ansible默认使用SSH客户端、可以识别hosts别名、如果修改配置链接插件为Paramiko、别名不能被识别
