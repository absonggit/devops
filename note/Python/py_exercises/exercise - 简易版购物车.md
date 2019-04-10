```
#!/usr/bin/env python
# Description：打印商品列表、提示退出还是继续购买；根据ID选择商品、如果有这个商品ID、继续购买、余额不够提示、否则购买成功；如果没有这个商品、提示重新选择；购买结束后打印已购买商品和余额；
# Author：
# Date：

commodity_list = [('手机', 1899), ('钢笔', 80), ('钱包', 900), ('橡皮', 8), ('游戏机', 888)]
salary = int(input("Please input your salary："))

for x, y, in enumerate(commodity_list):
    print(x, y[0], y[1])
    # print(type(x), type(y))

buy_cd = []
while True:
    exit_key = input("Press q to exit, any key to continue.")
    if exit_key == 'q':
        break
    else:
        select_cd = int(input("Please select the item you want："))
        count = len(commodity_list)
        if select_cd < count and select_cd >= 0:
            cd_price = int((commodity_list[select_cd][1]))
            if cd_price < salary:
                salary = salary - cd_price
                buy_cd.append([commodity_list[select_cd][0], salary])
                print("购买成功！")
            else:
                print("Your balance is insufficient!")
        else:
            print("没有这个商品、请重新选择~")
print('您购买的商品如下：')
for x, y in buy_cd:
    # print(buy_cd)
    print('\t', x)
print('您的余额为：', buy_cd[-1][1])


您购买的商品如下：
	 手机
	 钱包
	 橡皮
	 橡皮
	 游戏机
您的余额为： 6296
```
