https://www.linuxidc.com/Linux/2017-08/146528.htm


root用户
DISPLAY=:1; export DISPLAY
xhost +
xclock

oracle用户
su - oracle
DISPLAY=:1; export DISPLAY
xclock

> 要两个xlcock全部可以调出才可以

**主机名不能带有"-"，否则数据库会报错**
