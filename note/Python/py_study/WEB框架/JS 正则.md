# JS 正则
## test - 判断字符串是否符合规定的正则
```javascript
rep = /^\d+$/;
rep.test("sadfwefsdfwer78sdf");

return:
false
```
## exec - 获取匹配的数据
```javascript
rep = /\d+/;
str = "klskdf_789_swdf_123";
rep.exec(str);

return:
789
```

全局匹配
```javascript
str = "wang1 wang2 wang4 wang5saf"
pattern = /\bwang\W+\b/g;    
//g 全局匹配 依次取值直到没有 返回null; i 不区分大小写; m 多行匹配 当使用^的时候 需要加上m
pattern.exec(str);

return:
wang1
```

分组匹配
```javascript
'/\bwang(\W+)\b/'   \b按照空格分割的单词匹配 ()分组匹配 返回列表

str = "wang1 wang2 wang4 wang5saf"
pattern = /\bwang(\W+)\b/;
pattern.exec(str);

return:
["wang1","1"]
```
