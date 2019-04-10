```
Apple   88
Iphone  49999
Pc      5351
Car     100000
Cup     30
Ball    268
Bag     1888
Tea     333
Flower  90
Desk    888
Water   3
Chair   193
```

```
with open("D:\python\exercise_item\D1\context", 'r') as f:
    product = []
    price = []
    for line in f.readlines():
        line_list = line.split()
        print(line_list)
        product.append(line_list[0])
        price.append(line_list[1])
    print(product)
    print(price)
```

```
执行效果如下：
['Apple', 'Iphone', 'Pc', 'Car', 'Cup', 'Ball', 'Bag', 'Tea', 'Flower', 'Desk', 'Water', 'Chair']
['88', '49999', '5351', '100000', '30', '268', '1888', '333', '90', '888', '3', '193']
```
