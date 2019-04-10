#!/bin/bash
# Description: Tomcat以daemon的方式启动(即便root用户启动程序也是tomcat用户去运行)
# Date:
# Author:

if [ ! -d "/data/package" ];then mkdir -p /data/package;fi
#if [ ! -d "/data/tomcat" ];then mkdir -p /data/WebServer;fi

dc_dir="/data/tomcat"

function copy_tc() {
  #解压缩tomcat包，并移动到指定目录
  tar zxvf ./package/apache-tomcat-8.5.31.tar.gz -C ./package
  #rm -rf ${dc_dir}/${dc_proj}/webapps/*
  mv ./package/apache-tomcat-8.5.31 ${dc_dir}
}

function compile_daemon() {
  #安装依赖并编译commons-daemon模块
  yum -y install gcc gcc-c++ make expat-devel
  cat > /data/tomcat/bin/setevn.sh << "EOF"
JAVA_HOME=/data/jdk8
JRE_HOME=${JAVA_HOME}/jre
CATALINA_HOME=/data/tomcat
CATALINA_BASE=${CATALINA_HOME}
JAVA_OPTS='-server -Xms2048m -Xmx4096m -Xss512k'
EOF
  cd ${dc_dir}/bin/
  tar -xf ${dc_dir}/bin/commons-daemon-native.tar.gz
  cd ${dc_dir}/bin/commons-daemon-1.1.0-native-src/unix/
  ./configure
  make
  echo $?
  cp jsvc ${dc_dir}/bin/
  useradd -M -d /data/tomcat -s /sbin/nologin tomcat
  chown -R tomcat:tomcat ${dc_dir}
}

function md_conf() {
  #指定jdk环境变量、并优化
  sed -i 's#JAVA_OPTS="user-define"#JAVA_OPTS="-server -Xms8G -Xmx8G -XX:+AggressiveOpts -XX:MaxDirectMemorySize=4G -Duser.timezone=Asia/shanghai"#g' ${dc_dir}/${dc_proj}/bin/catalina.sh
}

function auto_start_centos6() {
  #开机自启动centos6
  ln -s /data/tomcat/bin/daemon.sh /etc/init.d/tomcat
  #/etc/init.d/tomcat start
  sed -i '2s/^.*/# chkconfig: 2345 55 25/' /data/tomcat/bin/daemon.sh
  chkconfig tomcat on
}

function copy_start_shell() {
  cat /etc/init.d/tomcat << EOF
#!/bin/bash
# chkconfig: 2345 60 80
# description: script for tomcat start

CATALINA_HOMES=(/home/ziker/tomcat) 
TOMCAT_USER=tomcat
JAVA_HOME=/usr/local/jdk1.8.0_191

function jsvc_exec() {
    retval=0
    for CATALINA_HOME in ${CATALINA_HOMES[@]}
    do
        [ $retval -eq 0 ] || [ $retval -eq 255 ] || break
        ${CATALINA_HOME}/bin/daemon.sh \
            --java-home $JAVA_HOME \
            --catalina-home $CATALINA_HOME \
            --catalina-base $CATALINA_HOME \
            --tomcat-user $TOMCAT_USER \
            --service-start-wait-time 50 \
            $1
        retval=$?
    done
    return $retval
}

case "$1" in
    start   )
      jsvc_exec start
      exit $?
    ;;
    stop    )
      jsvc_exec stop
      exit $?
    ;;
    restart  )
      jsvc_exec stop
      sleep 1
      jsvc_exec start
      exit $?
    ;;
    version    )
      jsvc_exec version
      exit $?
    ;;
    *       )
      echo "Unknown command: \`$1'"
      echo "commands:"
      echo "  restart           Retart Tomcat"
      echo "  start             Start Tomcat"
      echo "  stop              Stop Tomcat"
      echo "  version           What version of commons daemon and Tomcat"
      echo "                    are you running?"
      exit 1
    ;;
esac
EOF
}

function auto_start_centos7() {
  #开机自启动centos7
  cat > /lib/systemd/system/tomcat.service << EOF
[Unit]
Description=seafile
After=network.target

[Service]
Type=forking
ExecStart=/data/tomcat/bin/daemon.sh start
ExecReload=/data/tomcat/bin/daemon.sh restart
ExecStop=/data/tomcat/bin/daemon.sh stop
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF
  systemctl enable tomcat.service
}

copy_tc
compile_daemon
#md_conf
#copy_start_shell
#auto_start_centos6
#auto_start_centos7

echo
${dc_dir}/bin/daemon.sh version
echo

echo "Successful installation!"
