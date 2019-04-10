#!/usr/bin/env python
# -*- coding:utf-8 -*-
# description：摇骰子

import random,sys,time

result = []

while True:
    result.append(int(random.uniform(1,7)))
    result.append(int(random.uniform(1,7)))
    result.append(int(random.uniform(1,7)))
    # print(result)

    count = 0
    index = 2
    pointStr = ""

    while index >= 0:
        currentPoint = result[index]
        count += currentPoint
        index -= 1
        # 字符串拼接 “空格 str(currentPoint 空格 str(currentPoint    eg: 4 2)”
        pointStr += " "
        pointStr += str(currentPoint)

    if count <= 11:
        # 调用标准输出stdout对象的write方法
        sys.stdout.write(pointStr + " -> " + " 小 " + " \n ")
        time.sleep(1)
    else:
        sys.stdout.write(pointStr + " -> " + " 大 " + " \n ")
        time.sleep(1)

    result = []
