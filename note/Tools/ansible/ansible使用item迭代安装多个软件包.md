{{ item }}是一个占位变量，会被with_items语句中列表的每一个元素分别替代。ansible总是使用item作为循环迭代变量的名字。
```
#!/usr/bin/env ansible-playbook
---
- hosts: all  
  tasks:   
  - name: install vim     
  yum:
    name={{ item  }}
    state=present
  with_items:
     - vim-enhanced
     - wget
     - unzip
     - lsof
     - httpd
```

```
#!/usr/bin/env ansible-playbook
- hosts: all
  tasks:
    - name: install vim
      yum: name=vim-enhanced
    - name: install wget
      yum: name=wget
    - name: install unzip      
      yum: name=unzip
    - name: install telnet
      yum: name=lsof
```
