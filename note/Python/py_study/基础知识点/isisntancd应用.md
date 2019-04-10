isinstance(object, classinfo)   判断实例是否是这个类或者object是变量  

classinfo 是类型(tuple,dict,int,float)  判断变量是否是这个类型   

```
class objA:   
pass   

A = objA()
B = 'a','v'
C = 'a string'

print isinstance(A, objA)
print isinstance(B, tuple)
print isinstance(C, basestring)
输出结果：
True
True
True
```

不仅如此，还可以利用isinstance函数，来判断一个对象是否是一个已知的类型。  
isinstance说明如下:  
```
isinstance(object, class-or-type-or-tuple) -> bool  

Return whether an object is an instance of a class or of a subclass thereof.  
With a type as second argument, return whether that is the object's type.  
The form using a tuple, isinstance(x, (A, B, ...)), is a shortcut for  
isinstance(x, A) or isinstance(x, B) or ... (etc.).  


其第一个参数为对象，第二个为类型名或类型名的一个列表。其返回值为布尔型。若对象的类型与参数二的类型相同则返回True。若参数二为一个元组，则若对象类型与元组中类型名之一相同即返回True。  

>>>isinstance(lst, list)  
True  

>>>isinstance(lst, (int, str, list) )  
True  


另外:Python可以得到一个对象的类型 ，利用type函数：>>>lst = [1, 2, 3]>>>type(lst)<type 'list'>  
```
