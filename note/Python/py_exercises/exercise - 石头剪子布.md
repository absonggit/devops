#!/usr/bin/env python
# -*- coding:utf-8 -*-
# descirption：石头剪子布小游戏.

import random

while True:
    s = int(random.uniform(1,3))
    if s == 1:
        ind = "石头"
    if s == 2:
        ind = "剪子"
    if s == 3:
        ind = "布"
    m = raw_input("输入“石头”“剪子”“布”玩游戏、或者“q”退出游戏：")
    blist = ["石头","剪子","布"]
    if ( m not in blist ) and ( m != 'q' ):
        print "输入错误、请重新输入："
    elif ( m not in blist ) and ( m == 'q' ):
        print "\n正在退出游戏中..."
        break
    elif ind == m:
        print "电脑出了：%s ---> 平局！" % ind
        print "继续下一轮..."
    elif ( ind == "石头" and m == "布" ) or ( ind == "剪子" and m =="石头" ) or ( ind == "布" and m == "剪子" ):
        print "电脑出了：%s ---> 你赢了！" % ind
    elif ( ind == "石头" and m == "剪子" ) or ( ind == "剪子" and m == "布" ) or ( ind == "布" and m == "石头" ):
        print "电脑出了：%s ---> 你输了！" % ind
