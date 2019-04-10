程序需求：购物车
- 用户启动时先输入工资；  
- 用户启动程序后打印商品列表；       
- 允许用户选择购买商品 购买时用户选择购买数量；
- 允许用户不断的购买各种商品；
- 购买时检测 余额是否足够 如果足够直接扣款 否则打印余额不足；
- 允许用户主动退出程序、退出时打印已购商品列表；
- 允许多用户登录 第二次登录 按照上次余额继续购物 并可以充值
- 允许用户查看之前的购买记录  、记录显示商品购买时间
- 商品列表分级展示 、二级菜单
- 显示已购买商品时、如果有重复商品、不打印多行  变成一行
    - 序号    商品名称    数量    金额

用到文件、datatime模块、json序列化

程序代码：
```
#!/usr/bin/env python
#  -*- coding:utf-8 -*-

goodList = {
    "家用电器":{"洗衣机":"1500","电视":"3000","冰箱":"1312","吸油烟机":"1400",},
    "手机数码":{"笔记本电脑":"5555","手机":"2999","蓝牙耳机":"300","数码相机":"6666",},
    "男装女装":{"西服":"3000","衬衫":"299","连衣裙":"888","超短裙":"666",},
    "酒水饮料":{"啤酒":"25","白酒":"333","红酒":"999","可乐":"3",},
}

#检查登录用户密码是否正确、如果超出3次输入错误给出提示退出（用户密码在UserList表）
exist = 0   #判断用户密码正确退出整个程序
loginCounter = 0   #判断输入用户密码错误次数
while True:
    if loginCounter == 3:
        print("用户或密码输入错误超过3次、退出程序")
        exit()
    user = input("请输入登录用户名: ")
    pwd = input("请输入登录密码：")
    userPwd = user + ':' + pwd
    with open(r"D:\py_test\py_test\userList",'r+') as userListOpen:
        for line in userListOpen:
            if userPwd == line.strip():
                exist = 1
            else:
                pass
        if exist == int(1):
            print('\n',"欢迎登陆购物车程序选购商品：",'\n')
            break
        else:
            loginCounter += 1

#输入工资并打印商品列表
savaClassList = []
saveShopList = []
saveShopPrice = []
salaryTotal = int(input("请输入您的工资："))
while True:
    title = "商品列表"      #打印商品表次
    print(title.center(50,'-'))
    for key1,value1 in enumerate(goodList):       #循环一级菜单
        print(key1,value1)        #输出一级菜单
        savaClassList.append(value1)      #将一级菜单保存为列表、为了索引二级菜单
    control = input("按'q'退出程序，任意键继续选择商品：")
    if control == 'q':
        exit()
    else:
        pass
    selectMeun = int(input("请输入序号、选择对应的商品种类："))      #选择一级菜单种类
    while True:
        print("".center(54,'-'))
        for key2,value2 in enumerate(goodList[savaClassList[selectMeun]]):    #循环二级菜单
        shopPrice = goodList[savaClassList[selectMeun]][value2]
        print('\t',key2,value2,shopPrice)      #打印二级菜单
        saveShopList.append(value2)
        saveShopPrice.append(shopPrice)
    selectShop = int(input("请输入序号、选择商品："))        #选择购买的商品
    selectNum = int(input("请输入商品数量："))        #选择商品数量
    salaryCost = int(saveShopPrice[selectShop]) * selectNum     #购买商品总价
    if salaryTotal >= salaryCost:
        salaryTotal = salaryTotal - salaryCost     #购买商品后的工资余额
    else:
        print("您的工资余额不足购买商品！")
        continue
    print('\t',"扣款成功！现在的工资余额为：",salaryTotal)
    print('\t',user,"购物车以及购买的商品：",saveShopList[selectShop],selectNum)
    print("按'b'返回菜单,按'q'退出程序,按'c'涨工资喽！")
```
