# 随机模块方法
1. 随机浮点数
```
# 随机0-1之间的浮点数
random.random()
```

2. 随机浮点数(可指定区间)
```
random.uniform(1, 10)
```

3. 随机整数(需指定区间，包含10)
```
random.randint(1, 10)
```

4. 随机整数(可指定步长，不包含10)
```
random.randrange(1, 10, 2)
```

5. 从序列中获取一个随机元素
```
random.choice("asdfasdfasdf")
```

6. 从序列中获取指定随机元素个数
```
random.sample("hello", 2)
```

7. 洗牌功能
```
l = [1,2,3,4,5,6,7,8]
random.shuffle(l)

[1, 7, 5, 3, 8, 4, 6, 2]
```

# 随机模块验证码示例
```
# 随机获取6位(大写、小写、数字)组合验证码
import random
checkcode = ""
for i in range(6):
    current_int = random.randrange(0, 6)
    if current_int == i:
        tmp_capital = chr(random.randint(65, 90))
        tmp_lowercase = chr(random.randint(97, 122))
        tmp_str = tmp_capital + tmp_lowercase
        tmp = random.choice(tmp_str)
    else:
        tmp = str(random.randint(0, 9))
    checkcode += tmp
print(checkcode)
```
