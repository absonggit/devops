#!/bin/bash
# Description: install tomcat8
# Date:
# Author:

if [ ! -d "/data/package" ];then mkdir -p /data/package;fi
if [ ! -d "/data/WebServer" ];then mkdir -p /data/WebServer;fi

dc_dir="/data/WebServer"

function copy_tc() {
  # unzip the package and copy the specified directory.
  tar zxvf ./package/apache-tomcat-8.5.31.tar.gz -C ./package
  rm -rf ${dc_dir}/${dc_proj}/webapps/*
  mv ./package/apache-tomcat-8.5.31 ${dc_dir}/${dc_proj}
  /bin/cp ./conf/tomcat/catalina.sh ${dc_dir}/${dc_proj}/bin/
  /bin/cp ./conf/tomcat/shutdown.sh ${dc_dir}/${dc_proj}/bin/
  /bin/cp ./conf/tomcat/server.xml ${dc_dir}/${dc_proj}/conf/
}

function md_conf() {
  # modify related configurations - catalina.sh
  sed -i 's#JAVA_OPTS="user-define"#JAVA_OPTS="-server -Xms8G -Xmx8G -XX:+AggressiveOpts -XX:MaxDirectMemorySize=4G -Duser.timezone=Asia/shanghai"#g' ${dc_dir}/${dc_proj}/bin/catalina.sh
}

echo "---------------------------------------"
echo "----------选择对应的项目序号或者名称-----"
echo "----------1、dc-chain-service----------"
echo "----------2、dc-chain-wex--------------"
echo "----------3、dc-chain-node-------------"
echo "---------------------------------------"
read -p "请选择操作类型：" choose

#if [ ${choose} = "1" -o ${choose} = "dc-chain-service" ];then
#  dc_proj="dc-chain-service"
#elif [ ${choose} = "2" -o ${choose} = "dc-chain-wex" ];then
#  dc_proj="dc-chain-wex"
#elif [ ${choose} = "3" -o ${choose = "dc-chain-node"}];then
#  dc_proj="dc-chain-node"
#else
#  echo "选择错误、请重新运行脚本~";
#  break;
#fi

case ${choose} in
  1|dc-chain-service)
  dc_proj="dc-chain-service"
  copy_tc
  md_conf
  sed -i 's#CATALINA_HOME="user-define"#CATALINA_HOME=/data/WebServer/dc-chain-service#g' ${dc_dir}/${dc_proj}/bin/catalina.sh
  sed -i 's#docBase="user-define.war"#docBase="dc-chain-server.war"#g' ${dc_dir}/${dc_proj}/conf/server.xml
  ;;
  2|dc-chain-wex)
  dc_proj="dc-chain-wex"
  copy_tc
  md_conf
  sed -i 's#CATALINA_HOME="user-define"#CATALINA_HOME=/data/WebServer/dc-chain-wex#g' ${dc_dir}/${dc_proj}/bin/catalina.sh
  sed -i 's#docBase="user-define.war"#docBase="dc-chain-wex.war"#g' ${dc_dir}/${dc_proj}/conf/server.xml
  ;;
  3|dc-chain-node)
  dc_proj="dc-chain-node"
  copy_tc
  md_conf
  sed -i 's#CATALINA_HOME="user-define"#CATALINA_HOME=/data/WebServer/dc-chain-node#g' ${dc_dir}/${dc_proj}/bin/catalina.sh
  sed -i 's#docBase="user-define.war"#docBase="dc-chain-node.war"#g' ${dc_dir}/${dc_proj}/conf/server.xml
  ;;
  *)
  echo "选择错误、请重新运行脚本！"
  exit
  ;;
esac

echo
${dc_dir}/${dc_proj}/bin/version.sh
echo

echo "Successful installation!"
echo
