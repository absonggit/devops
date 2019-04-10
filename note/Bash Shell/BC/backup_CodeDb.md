```bash
#!/bin/bash
#DESCRIPTION:1、备份千亿/long8论坛数据库、源码并删除5天前的备份。
#AUTHOR&DATE:francis-20161228

echo -e "\033[31;15m---------------------------\033[0m"
echo -e "\033[31;1m开始运行博客数据库备份脚本：\033[0m"
echo -e "\033[31;15m---------------------------\033[0m"

#定义变量(数据库用户、密码以及备份目录)
DB_USER=root
DB_PWD='Sw3X3@sd%2w3sfSD23s'
DB_NAME=("qy8bbs" "long8bbs")
BACKUP_PATH=/home/BACKUP/db
BACKUP_DATE=`date +%Y%m%d-%H%M%S`

CODE_SRCPATH=/home/WebSer/bbs
CODE_DESTPATH=/home/BACKUP/code
CODE_NAME=("bbs.qy8.us" "bbs.long8.cc")

#定义rsync命令
COMM_RSYNC=`which rsync`

#创建备份目录
if [ ! -e $BACKUP_PATH ] || [ ! -e $CODE_DESTPATH ];then
        echo -e "\033[33m创建备份目录/home/BACKUP......\033[0m"
        /bin/mkdir -p $BACKUP_PATH $CODE_DESTPATH > /dev/null 2>&1
        echo -e "\033[33m备份目录/home/BACKUP创建完成！\n\033[0m"
fi

#备份博客数据库并删除
for BACKUP_DB in ${DB_NAME[@]};do
        echo "开始备份数据库-$BACKUP_DB......"
        /home/lnmp/mysql/bin/mysqldump -u$DB_USER -p$DB_PWD $BACKUP_DB > $BACKUP_PATH/$BACKUP_DB-$BACKUP_DATE.sql
        #echo $BACKUP_PATH/$BACKUP_DB-$BACKUP_DATE.sql
        echo -e "\033[33m$BACKUP_DB库备份完成！\033[0m"
        echo "--------------------"
done

/bin/find $BACKUP_PATH -type f -name "*.sql" -mtime +31 |xargs rm -rf

echo -e "\033[31;15m---------------------------\033[0m"
echo -e "\033[31;1m开始运行博客源码备份脚本：\033[0m"
echo -e "\033[31;15m---------------------------\033[0m"

#清理临时文件
echo "开始清理临时文件......"
sleep 3
TMP_FILE=/home/WebSer/bbs
/bin/rm -rf $TMP_FILE/bbs.long8.cc/uc_server/data/tmp/*
/bin/rm -rf $TMP_FILE/bbs.qy8.us/uc_server/data/tmp/*

#同步千亿图片
echo "开始同步千亿图片文件......"
sleep 3
IMAGE_SRC=/home/WebSer/bbs/bbs.qy8.us
IMAGE_DEST=/home/BACKUP/code/image/qy

IMAGE_PATH1=data/attachment/forum/
IMAGE_PATH2=data/attachment/image/000/
IMAGE_PATH3=uc_server/data/avatar/000/

$COMM_RSYNC -auv $IMAGE_SRC/$IMAGE_PATH1 $IMAGE_DEST/$IMAGE_PATH1
$COMM_RSYNC -auv $IMAGE_SRC/$IMAGE_PATH2 $IMAGE_DEST/$IMAGE_PATH2
$COMM_RSYNC -auv $IMAGE_SRC/$IMAGE_PATH3 $IMAGE_DEST/$IMAGE_PATH3

#同步龙8图片
echo "开始同步龙8图片文件......"
sleep 3
IMAGE_SRC=/home/WebSer/bbs/bbs.long8.cc
IMAGE_DEST=/home/BACKUP/code/image/long8
$COMM_RSYNC -auv $IMAGE_SRC/$IMAGE_PATH1 $IMAGE_DEST/$IMAGE_PATH1
$COMM_RSYNC -auv $IMAGE_SRC/$IMAGE_PATH2 $IMAGE_DEST/$IMAGE_PATH2
$COMM_RSYNC -auv $IMAGE_SRC/$IMAGE_PATH3 $IMAGE_DEST/$IMAGE_PATH3

#备份源码文件
cd $CODE_SRCPATH
for BACKUP_CODE in ${CODE_NAME[@]};do
        echo "开始备份源码-$BACKUP_CODE......"
        sleep 3
        #/bin/tar zcf $BACKUP_CODE-$BACKUP_DATE.tar.gz $BACKUP_CODE/
        #/bin/mv $BACKUP_CODE-$BACKUP_DATE.tar.gz $CODE_DESTPATH
        #/bin/cp -R $BACKUP_CODE $CODE_DESTPATH/$BACKUP_CODE-$BACKUP_DATE.bak

                #备份代码不包含图片
                $COMM_RSYNC -a --exclude="data/attachment/forum" --exclude="uc_server/data/avatar/000" --exclude="data/attachment/image/000"  $BACKUP_CODE $CODE_DESTPATH/$BACKUP_CODE-$BACKUP_DATE.bak
                echo -e "\033[33m$BACKUP_CODE源码备份完成！\033[0m"
                echo "--------------------"
        done

        /bin/find $CODE_DESTPATH -type d -name "*.bak" -mtime +31 |xargs rm -rf
```
