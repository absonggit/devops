1、文件开始符
```
---
```

2、数组List（数组中的每个元素都是以 - 开始的）
```
- element1
- element2
- element3
```

3、字典(Hash or Directory)
```
key: value
key和value以冒号加空格分隔。
复杂的字典
```

4、字典的嵌套
```
# An employee record
martin:
    name: Martin D'vloper
    job: Developer
    skill: Elite
```

5、字典和数组的嵌套
```
-  martin:
    name: Martin D'vloper
    job: Developer
    skills:
      - python
      - perl
      - pascal
-  tabitha:
    name: Tabitha Bitumen
    job: Developer
    skills:
      - lisp
      - fortran
      - erlang


注意的地方
变量里有：要加引号
foo: "somebody said I should put a colon here: so I did"
变量的引用要加引号
foo: "{{ variable }}"
```

参考资料：
http://www.yamllint.com/

https://en.wikipedia.org/wiki/YAML
