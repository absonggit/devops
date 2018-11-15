#!/bin/bash
color_start="\033[36;45m"
color_flash="\033[36;45;5m"
color_close="\033[0m"
c_num=(31 32 33 34 35 36 37)
name=("向*雷" "陈*学" "龚*辉" "孙*芃" "李*俊" "姚*博" "胡*臻" "王*劝" "王*飞" "赖*强" "龙*红" "石*梅" "王*武" "姚*瑶" "王*波" "李*芳" "皮*玉" "樊*乐" "陆*美")
while true
do
clear
	echo -e "$color_start========================$color_close"
	echo -e "$color_start||$color_close     随机抽取       $color_start||$color_close"
	echo -e "$color_start||$color_close      \033[${c_num[$RANDOM%7]}m${name[$[$RANDOM%19]]}$color_close        $color_start||$color_close"
	echo -e "$color_start||$color_close   Ctrl + c exit    $color_start||$color_close"
	echo -e "$color_start========================$color_close"
	sleep 0.3
	trap "break" 2
done
	clear
	echo -e "$color_flash========================$color_close"
	echo -e "$color_flash||$color_close                    $color_flash||$color_close"
	echo -e "$color_flash||$color_close恭喜中奖了！\033[${c_num[$RANDOM%7]}m${name[$[$RANDOM%7]]}$color_close  $color_flash||$color_close"
	echo -e "$color_flash||$color_close                    $color_flash||$color_close"
	echo -e "$color_flash========================$color_close"
