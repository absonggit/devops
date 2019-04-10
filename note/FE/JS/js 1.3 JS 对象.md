# JS 对象
JS中的所有事物都是对象：字符串、数值、数组、函数...此外、JS允许自定义对象，对象只是带有属性和方法的特殊数据类型。
## JS对象的属性和方法
- 访问对象的属性 objectName.propertyName
```
var message="Hello world!";
var x=message.length;
```

- 访问对象的方法 objectName.methodName()
```
var message="Hello worle!";
var x=message.toUpperCase();
```

## 创建JS对象
通过JS可以定义并创建对象，创建新对象有两种方法：
- 定义并创建对象的实例
```
person=new Object();
person.firstname="Bill";
person.lastname="Gates";
```

- 使用函数来定义对象，然后创建新的对象实例
```
<script>
    function person(firstname,lastname,age) {
        this.firstname=firstname;
        this.lastname=lastname;
        this.age=age;
    }
    myFather=new person("bill","Gates",16);
    document.write(myFather.firstname + myFather.lastname + myFather.age)
</script>
```

# JS 数字
- 所有JS数字均为64位、并且JS不定义不同类型的数字
- 数字属性和方法
    - 属性：
        - MAX VALUE
        - MIN VALUE
        - NEGATIVE INFINITIVE
        - POSITIVE INFINITIVE
        - NaN
        - prototype
        - constructor
    - 方法：
        - toExponential()
        - toFixed()
        - toPrecision()
        - toString()
        - valueOf()

# JS 字符串
- 计算字符串的长度
- 为字符串添加样式
- 定位字符串中某一个指定的字符首次出现的位置 indexOf()方法
- 查找字符串中特定的字符并返回这个字符 match()方法
- 如何替换字符串中的字符 - replace()

# JS 日期
- 获得当日的日期 Date()
- 返回19701月1日至今的毫秒数 getTime()
- 设置日期 setFullYear()
- 将当日的日期转换为字符串 toUTCString()
- 显示星期，不仅仅是数字 getDay()
- 显示一个钟表

# JS 数组
- 创建数组
- 循环输出数组中的元素 for...in
- 合并两个数组 concat()
- 将数组中的所有元素组成一个字符串 join()
- 从字面上对数组进行排序 sort()

# JS 逻辑
检查逻辑对象是true还是false

# JS 算数
- 随机数 round()
- 返回最大数 max()
- 返回最小数 min()

# JS 正则表达式
- 检索字符串中的指定值，返回值是true或false test()
- 检索字符串中的指定值，返回指定值或者null exec()
- 改变检索模式，也可以添加或删除第二个参数 compile()
