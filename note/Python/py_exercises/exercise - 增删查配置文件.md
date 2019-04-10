```
#！/usr/bin/env python
# Description: Implement the configuration file to add, delete, search

file_operation = ['search', 'add', 'delete']


def file_search(content):
    """search module"""

    with open('ha_proxy', 'r') as f:
        for i in f:
            content_new = "backend" + " " + content
            # print("content_new", content_new.strip(), type(content_new))
            # print("i：", i.strip(), type(i))
            if content_new.strip() == i.strip():
                print("查询结果".center(50, '-'))
                print(f.readline(), '\n')
                return
        return print("查询结束，没有此内容！")


def file_add(content):
    """add module"""

    content = eval(content)
    # print(content, type(content))
    with open('ha_proxy', 'a') as f:
        content1 = 'backend' + ' ' + content['backend']
        content2 = 'server' + ' ' + content['record']['server'] + ' ' \
                   + 'weight' + ' ' + str(content['record']['weight']) + ' ' \
                   + 'maxconn' + ' ' + str(content['record']['maxconn'])
        f.write('\n\n')
        f.write(content1)
        f.write('\n\t\t')
        f.write(content2)
        f.flush()
        print("添加成功！")


def file_delete(content):
    """delete module"""

    content = eval(content)
    content_delete = "backend" + " " + content["backend"]
    print(content_delete1)
    with open('ha_proxy', 'r+') as f:
        for i in f:
            if content_delete in i:
                i.replace(content_delete, " ")
        return print("已经删除！")


while True:
    for n, i in enumerate(file_operation):
        print(n, i)
    op = input("请选择操作(q退出)：")
    if op == file_operation[0]:
        content_search = input("请输入查询等内容：")
        file_search(content_search)
    elif op == file_operation[1]:
        content_add = input("请输入增加的内容：")
        file_add(content_add)
    elif op == file_operation[2]:
        content_delete = input("请输入删除的内容：")
        file_delete(content_delete)
    else:
        exit()
```
