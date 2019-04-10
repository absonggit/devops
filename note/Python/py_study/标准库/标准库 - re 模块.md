# 常用正则表达式符号
```
'.'     默认匹配除\n之外的任意一个字符，若指定flag DOTALL,则匹配任意字符，包括换行
'^'     匹配字符开头，若指定flags MULTILINE,这种也可以匹配上(r"^a","\nabc\neee",flags=re.MULTILINE)
'$'     匹配字符结尾，或e.search("foo$","bfoo\nsdfsf",flags=re.MULTILINE).group()也可以
'*'     匹配*号前的字符0次或多次，re.findall("ab*","cabb3abcbbac")  结果为['abb', 'ab', 'a']
'+'     匹配前一个字符1次或多次，re.findall("ab+","ab+cd+abb+bba") 结果['ab', 'abb']
'?'     匹配前一个字符1次或0次
'{m}'   匹配前一个字符m次
'{n,m}' 匹配前一个字符n到m次，re.findall("ab{1,3}","abb abc abbcbbb") 结果'abb', 'ab', 'abb']
'|'     匹配|左或|右的字符，re.search("abc|ABC","ABCBabcCD").group() 结果'ABC'
'(...)' 分组匹配，re.search("(abc){2}a(123|456)c", "abcabca456c").group() 结果 abcabca456c


'\A'    只从字符开头匹配，re.search("\Aabc","alexabc") 是匹配不到的
'\Z'    匹配字符结尾，同$
'\d'    匹配数字0-9
'\D'    匹配非数字
'\w'    匹配[A-Za-z0-9]
'\W'    匹配非[A-Za-z0-9]
'\s'    匹配空白字符、\t、\n、\r , re.search("\s+","ab\tc1\n3").group() 结果 '\t'

'(?P<name>...)' 分组匹配 re.search("(?P<province>[0-9]{4})(?P<city>[0-9]{2})(?P<birthday>[0-9]{4})","371481199306143242").groupdict("city") 结果{'province': '3714', 'city': '81', 'birthday': '1993'}

eg:
>>> res = re.search("(?P<SHENG>[0-9]{2}(?P<SHI>\d{2})(?P<QU>\d{2}))", "11111111").groupdict()
>>> res
{'SHI': '11', 'QU': '11', 'SHENG': '111111'}
#分组读取身份信息，省市区
```

# 常用的匹配方法
```
re.match 从头开始匹配
re.search 匹配包含
re.findall 把所有匹配到的字符放到以列表中的元素返回
re.split 切割字符串，以列表的形式返回
re.splitall 以匹配到的字符当做列表分隔符
re.sub  匹配字符并替换

不经常用的
re.I(re.IGNORECASE): 忽略大小写（括号内是完整写法，下同）
M(MULTILINE): 多行模式，改变'^'和'$'的行为（参见上图）
S(DOTALL): 点任意匹配模式，改变'.'的行为
```
# re 模块
- 参数说明
    - pattern 匹配的正则表达式
    - string 要匹配的字符串
    - flags 标志位，用于控制正则表达式的匹配方法，如：是否区分大小写、多行匹配等
    - pattern概念：pattern可以理解为一个匹配模式，获取这种 模式需要用compile方法：
```
re.compile(strPattern[, flag])
# 通过compile方法将参数中的原生字符串对象编译生成一个pattern对象。
# 参数flag是匹配模式，取值可以使用按位或者运算符'|'表示同时生效，eg:re.I | re.M
```

- 可选值：
    - re.I(ignorecase)：忽略大小写(括号内是完整写法，下同)
    - re.M(multiline)：多行模式，影响^和$
    - re.S(dotall)：使 . 匹配包括换行在内的所有字符
    - re.U(locale)：根据Unicode字符集解析字符。这个标志影响 \w, \W, \b, \B
    - re.L(unicode)：做本地化识别（locale-aware）匹配
    - re.X(verbose)：该标志通过给予你更灵活的格式以便你将正则表达式写得更易于理解。
```
eg:
pattern = re.compile(r'hello')
```
**以下七个方法的flags都是匹配模式的意思、如果在pattern生成时已经指明flags，那么在下面的方法就不需要传入这个参数。**

## match 方法
### 语法
```
re.match(pattern, string[, flags])
# 从字符串的起始位置匹配一个模式，如果不是起始位置匹配成功、match()就返回none。

pattern = re.compile(r'hello', re.I | re.M)
match = pattern.match('hello word!')
```

### math的属性和方法：
### 属性
1. string  匹配时使用的文本。
2. re  匹配时使用的pattern对象。
3. pos 文本中正则表达式开始搜索的索引。值与pattern.match()和pattern.search()方法的同名参数相同。
4. endpos  文本中正则表达式结束搜索的索引。值与pattern.match()和pattern.search()方法的同名参数相同。
5. lastindex 最后一个被捕获的分组在文本中的所以。如果没有被捕获的分组，将为None。
6. lastgroup 最后一个被捕获的分组的别名。如果这个分组没有别名或者没有被捕获的分组，将为None。

### 方法
1. group([group1, ...])
匹配的整个表达式的字符串，group()可以一次输入多个组号，在这种情况下它将返回一个包含哪些组对应值的元组。
获得一个或多个分组截获的字符串；指定多个参数时将以元组形式返回。group1可以使用编号也可以使用别名；编号0代表整个匹配的子串；不填写参数时，返回group(0)；没有截获字符串的组返回None；截获了多次的组返回最后一次截获的字符串。

2. groups([default])
返回一个包含所有小组字符串的元组，从1到所含的小组好
以元组形式返回全部分组截获的字符串。相当于调用group(1,2,3...last)。defalut表示没有截获字符串的组以这个值替代，默认为None。

3. groupdict([default])
返回以有别名的组的组名为键、以改组截获的子串为值的字典，没有别名的组不包括在内。default含义同上。

4. start([group])
返回指定的组截获的子串在string中的起始索引(子串第一个字符的索引)。group默认是为0。

5. end([group])
返回指定的组截获的子串在string中的结束索引(子串最后一个字符的索引)。group默认是为0。

6. span([group])
返回(start(group))、end(group)

7. expand(template)
将匹配的分组带入template中然后返回。template中可以使用\id或者\g、\g引用分组，但不能使用编号0。\id与\g是等价的；但\10将被认为是第10个分组，如果你想表达\1之后是字符'0'，只能使用\g0。

## search 方法
```
re.search(pattern, string[, flags])
search方法与match方法及其类似，区别在于match()函数只检测re是不是在string的开始位置匹配，search()会扫描整个string查找匹配，match()只有在0位置匹配成功的话才有返回，如果不是开始位置匹配成功的话，match()就返回None。

eg：
pattern = re.compile(r'hello')
match = pattern.search('world hello')
print(match.group())
```

## split 方法
```
re.split(pattern, string[, maxsplit])
# 按照能够匹配的子串将string分割后返回列表，maxsplit用于指定最大分割次数，不指定将全部分割。

eg:
pattern = re.compile(r\d+)
print(re.split(pattern, 'one1tow2three3four4'))

### output ###
# ['one', 'two', 'three', 'four', '']
```

## findall 方法
```
re.findall(pattern, string[, flags])
# 搜索string，以列表形式返回全部能匹配的子串。

eg:
pattern = re.compile(r'\d+')
print(re.findall(pattern, 'one1two2three3four4'))

### output ###
# ['1', '2', '3', '4']
```

## finditer 方法
```
re.finditer(pattern, string[, flags])
# 搜索string，返回一个顺序访问每一个匹配结果(match对象)的迭代器。

eg:
pattern = re.compile(r'\d+'
for m in re.finditer(pattern, 'one1two2three3four4'):
    print(m.group())

### output ###
# 1
# 2
# 3
# 4
```

## sub 方法
### 语法
```
re.sub(pattern, repl, string[, count])
```

### 实例
1. 替换和检索：用于替换字符串中的匹配项
- pattern:正则中的模式字符串
- repl:替换的字符串，也可为一个函数
- string:要被查找替换的原始字符串
- count:模式匹配后替换的最大次数，默认0表示替换所有的匹配
```
eg:
import re

phone = "2004-959-559 # 这是一个国外电话号码"
```

2. 删除字符串中的 Python注释
```
num = re.sub(r'#.*$', "", phone)
print "电话号码是: ", num
```

3. 删除非数字(-)的字符串
```
num = re.sub(r'\D', "", phone)
print "电话号码是 : ", num

电话号码是:  2004-959-559
电话号码是 :  2004959559

repl参数是一个函数：
eg:

import re
```

4. 将匹配的数字乘于 2
```
def double(matched):
    value = int(matched.group('value'))
    return str(value * 2)

s = 'A23G4HFD567'
print(re.sub('(?P<value>\d+)', double, s))

A46G8HFD1134
```

## subn 方法
```
re.subn(pattern, repl, string[, count])
# 返回(sub(repl, string[, count])，替换次数)。

eg:
pattern = re.compile(r'(\w+) (\w+)')
s = 'i say, hello world!'

print(re.subn(pattern,r'\2 \1', s))

def func(m):
    return m.group(1).title() + ' ' + m.group(2).title()

print(re.subn(pattern,func, s))

eg：
### output ###
# ('say i, world hello!', 2)
# ('I Say, Hello World!', 2)
```
