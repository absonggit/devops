【注意】jenkins的job 匿名用户一定要给read权限 否则提示找不到这个job
========================================================================

sshpass -p '2016!' scp -P 5120 $WORKSPACE/$m_sql admin@1.2.3.6:/home/sql
sshpass -p 'd321' rsync -ave 'ssh -p 5120' admin@1.2.2.2:/1.txt ./
yum install -y sshpass openssl

# 测试环境
```
#!/bin/bash
#DESCRIPTION
#1自动部署mysql
#2当执行jenkins的job时、自动分析工作空间的pom.xml的properties标签、如果是SNOPSHOT属性自动调用>
所依赖的jar包进行Deploy、如果有相同的动作不去重复执行Deploy动作


#jenkins系统变量$JENKINS_URL=http://192.168.6.243:8080/jenkins
#jenkins系统变量$WORKSPACE=/home/lvyu/.jenkins/workspace/
#jenkins系统变量$JOB_NAME=maven-test
#jenkins系统变量$BUILD_ID=44


export pom_path=$WORKSPACE/pom.xml
export jk_jar=/home/lvyu/.jenkins/jenkins-cli.jar
export pom_content=`sed -n '/<properties>/,/<\/properties>/'p $pom_path |grep "<com.df"`


export log_sql=sql-`date +%Y%m%s`.log
export log_path=/opt/app/jk_shell
export m_war=`ls $WORKSPACE/target/*.war |awk -F '[/|.]' '{print $9}'`
export sql_conf=$log_path/sql_config/sql.config
export bu_iden=/opt/app/jk_shell/build.identify_parent


if ! [ -e $log_path ]
        then
                mkdir $log_path
                if ! [ -e $log_path/sql ]
                        then
                                mkdir $log_path/sql
                fi
                if ! [ -e $log_path/sql_config ]
                        then
                                mkdir $log_path/sql_config
                fi
fi


if [ -e $WORKSPACE/target/$m_war ]
        then
#               sql=$WORKSPACE/src/sql/v1.0.2.sql
                m_path=$WORKSPACE/target/$m_war/WEB-INF/classes/environment-config.properties
                m_user=`grep ^[^#] $m_path |grep -oP '(?<=jdbc_username=)\S+'`
                m_pass=`grep ^[^#] $m_path |grep -oP '(?<=jdbc_password=)\S+'`
                m_ip=`grep ^[^#] $m_path |grep -oP '(?<=jdbc_ip=)\S+' |cut -d : -f 1`
                m_port=`grep ^[^#] $m_path |grep -oP '(?<=jdbc_ip=)\S+' |cut -d : -f 2`
                m_db=`grep ^[^#] $m_path |grep -oP '(?<=jdbc_database=)\S+'`
                m_sql=v`grep "<version>" $pom_path |head -1 |awk -F "[>|-]" 'OFS="."{print $2}'`.sql
                echo "#m_user,m_pass,m_ip,m_port,m_db" > $sql_conf
                echo "$m_user,$m_pass,$m_ip,$m_port,$m_db" >> $sql_conf
                if ! [ -z $m_sql ]
                        then
#                                echo "my-sql执行时间:`date`" >> $log_path/sql/$log_sql
                                mysql -u$m_user -p$m_pass -h$m_ip -P$m_port $m_db  < $WORKSPACE/src/sql/$m_sql
#                                echo "========================================" >> $log_path/sql/$log_sql
                fi
        else
        		echo "-----------------------------------------------"
                echo '*** WARNIN: Does not define the "sql" file!'
                echo "-----------------------------------------------"
fi




echo "" > /opt/app/jk_shell/build.identify_child
echo "" > /opt/app/jk_shell/build.identify_parent
if ! [ -z $pom_content ]
        then
                echo "$pom_content" |while read line
                do
                        current_job=`echo $line |grep -c "SNAPSHOT"`
                        if ! [ -z $current_job ]
                                then
                                        svn_path=`echo $line |awk -F '.' 'OFS="."{print $1,$2,$4}' |awk -F '<' '{print $2}'`
                                        echo $SVN_REVISION
                                        java -jar $jk_jar -s $JENKINS_URL build $svn_path --username=wangweijing --password=nihao123!
                                        while :
                                        do
                                                bu_id=`grep $svn_path $bu_iden |wc -l`
                                                if [[ $bu_id -eq 1 ]]
                                                        then
                                                                break
                                                        else
                                                                sleep 5
                                                                continue
                                                fi
                                        done
                                else
                                        echo "-----------------------------------------------"
                                        echo '*** WARNING: Please check the status of SNAPSHOT!'
                                        echo "-----------------------------------------------"  
                        fi
                done
        else
                echo "-----------------------------------------------"
                echo '*** WARNING: Please check "properties" of pom.xml!'
                echo "-----------------------------------------------"
fi
```

## 依赖模块构建前执行
```
#!/bin/bash
#DESCRIPTION
#1自动部署mysql
#2当执行jenkins的job时、自动分析工作空间的pom.xml的properties标签、如果是SNOPSHOT属性自动调用>
所依赖的jar包进行Deploy、如果有相同的动作不去重复执行Deploy动作


#jenkins系统变量$JENKINS_URL=http://192.168.6.243:8080/jenkins
#jenkins系统变量$WORKSPACE=/home/lvyu/.jenkins/workspace/
#jenkins系统变量$JOB_NAME=maven-test
#jenkins系统变量$BUILD_ID=44


export pom_path=$WORKSPACE/pom.xml
export jk_jar=/home/lvyu/.jenkins/jenkins-cli.jar
export pom_content=`sed -n '/<properties>/,/<\/properties>/'p $pom_path |grep "<com.df"`


export log_sql=sql-`date +%Y%M%s`.log
export log_path=/opt/app/jk_shell
export sql_conf=$log_path/sql_config/sql.config
export m_sqlname=v`grep "<version>" $pom_path |head -1 |awk -F "[>|-]" 'OFS="."{print $2}'`.sql
export m_sql=$WORKSPACE/src/sql/$m_sqlname
export bu_iden=/opt/app/jk_shell/build.identify_child


if ! [ -z $m_sqlname ]
        then
                sql=/home/lvyu/.jenkins/workspace/maven-test/src/sql/v1.0.2.sql
                m_user=`grep ^[^#] $sql_conf |awk -F "," '{print $1}'`
                m_pass=`grep ^[^#] $sql_conf |awk -F "," '{print $2}'`
                m_ip=`grep ^[^#] $sql_conf |awk -F "," '{print $3}'`
                m_port=`grep ^[^#] $sql_conf |awk -F "," '{print $4}'`
                m_db=`grep ^[^#] $sql_conf |awk -F "," '{print $5}'`
#                echo "my-sql执行时间:`date`" >> $log_path/sql/$log_sql
                mysql -u$m_user -p$m_pass -h$m_ip -P$m_port $m_db  < $sql
#                echo "========================================" >> $log_path/sql/$log_sql
        else
                echo "-----------------------------------------------"
                echo '*** WARNIN: Does not define the "sql" file!'
                echo "-----------------------------------------------"
fi


if ! [ -z $pom_content ]
        then    
                echo "$pom_content" |while read line
                do
                        current_job=`echo $line |grep -c "SNAPSHOT" `
                        if ! [ -z $current_job ]
                                then
                                        svn_path=`echo $line |awk -F '.' 'OFS="."{print $1,$2,$4}' |awk -F '<' '{print $2}'`
                                        svn_path_s1=`grep $svn_path $bu_iden |wc -l`
                                        if ! [[ $svn_path_s1 -gt 0 ]]
                                                then
                                                        java -jar $jk_jar -s $JENKINS_URL build $svn_path --username=wangweijing --password=nihao123!
                                                        while :
                                                        do
                                                                svn_path_s2=`grep $svn_path $bu_iden |wc -l`
                                                                if [[ $svn_path_s2 -eq 1 ]]
                                                                        then
                                                                                break
                                                                else
                                                                         sleep 5
                                                                         continue
                                                                 fi
                                                        done
                                                else
                                                        echo "-----------------------------------------------"
                                                        echo "*** $svn_path have been build"
                                                        echo "-----------------------------------------------"  
                                        fi
                                else
                                        echo "-----------------------------------------------"
                                        echo '*** WARNING: Please check the status of SNAPSHOT!'
                                        echo "-----------------------------------------------"  
                        fi
                done
        else
                echo "-----------------------------------------------" 
                echo '*** WARNING: Please check "properties" of pom.xml!'
                echo "-----------------------------------------------"
fi

```

## 依赖模块构建结束执行
```
#!/bin/bash
echo "$JOB_NAME" >> /opt/app/jk_shell/build.identify_parent
echo "$JOB_NAME" >> /opt/app/jk_shell/build.identify_child
```
