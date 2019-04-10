默认ansible将会到与playbook并列的roles目录下查找、不过没指定也会在/etc/ansible/roles中查找系统级别的role

通过ansible.cfg自定义role路径：
```
[defaults]
roles_path= /root/ansible/playbook/roles
或者通过变量ANSIBLE_ROLES_PATH设置
```
```
ansible roles的组成（每个文件都是可选的）：
$ansible/database/tasks            #task    main.yml
$ansible/database/files            #需要上传主机的文件
$ansible/database/handlesr         #handler    mail.yml
$ansible/database/templates        #保存Jinja2模板文件
$ansible/database/vars             #不应该被覆盖的变量     main.yml
$ansible/database/defaults         #可以被覆盖的变量    main.yml
$ansible/database/meta             #role的依赖信息    main.yml
```
