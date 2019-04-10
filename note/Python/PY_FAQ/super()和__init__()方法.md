# 为什么要使用super()
在类的继承中、一旦调用派生类、Python就必须回到类的层次结构中去检查它的父类、而且要用固定的次序(MRO，Method Resolution Order - '方法解析顺序')以及C3算法去检查，super()函数就是用来理清这些继承关系。

# super()和__init__搭配使用
----------------------------------------------------------------------------
class Base(object):
    def __init__(self):
        print "Base created"

class ChildA(Base):
    def __init__(self):
        Base.__init__(self)

class ChildB(Base):
    def __init__(self):
        super(ChildB, self).__init__()

print ChildA(),ChildB()
-----------------------------------------------------------------------------
super()的好处就是可以避免直接使用父类的名字.但是它主要用于多重继承,这里面有很多好玩的东西.如果还不了解的话可以看看官方文档

注意在Python3.0里语法有所改变:你可以用super().__init__()替换super(ChildB, self).__init__().
