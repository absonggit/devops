#!/bin/bash
# author: itimor
# desc: jdk安装脚本
download_url='http://69.172.86.99:998'
jdk_env='/etc/profile.d/java-env.sh'

# 熵池底包
yum -y install rng-tools
echo 'EXTRAOPTIONS="--rng-device /dev/urandom"' >/etc/sysconfig/rngd
service rngd start
chkconfig rngd on

# apr模式
yum install -y epel-release apr*
yum install -y tomcat-native


function jdk6() {
jdk_tar='jdk-6u45-linux-x64.bin'
jdk_dir='jdk1.6.0_45'

[ -d /usr/java ] || mkdir /usr/java
[ -f ${jdk_tar} ] || wget $download_url/${jdk_tar}
chmod  +x $jdk_tar
[ -d ${jdk_dir} ] || ./$jdk_tar
[ -d /usr/java/${jdk_dir} ] || mv $jdk_dir /usr/java

echo 'export JAVA_HOME=/usr/java/jdk1.6.0_45
export JRE_HOME=${JAVA_HOME}/jre
export PATH=$PATH:${JAVA_HOME}/bin:${JRE_HOME}/bin
export CLASSPATH=${JAVA_HOME}/lib:${JRE_HOME}/lib' >$jdk_env
}

```html
<div styple="color: green;">
  123
<div/>
```

function jdk7() {
jdk_tar='jdk-7u79-linux-x64.tar.gz'
jdk_dir='jdk1.7.0_79'

[ -d /usr/java ] || mkdir /usr/java
[ -f ${jdk_tar} ] || wget $download_url/${jdk_tar}
[ -d /usr/java/$jdk_dir ] || tar -xvf ${jdk_tar} -C /usr/java

echo 'export JAVA_HOME=/usr/java/jdk1.7.0_79
export JRE_HOME=${JAVA_HOME}/jre
export PATH=$PATH:${JAVA_HOME}/bin:${JRE_HOME}/bin
export CLASSPATH=${JAVA_HOME}/lib:${JRE_HOME}/lib' >$jdk_env
}

function jdk8() {
jdk_tar='jdk-8u144-linux-x64.tar.gz'
jdk_dir='jdk1.8.0_144'

[ -d /usr/java ] || mkdir /usr/java
[ -f ${jdk_tar} ] || wget $download_url/${jdk_tar}
[ -d /usr/java/$jdk_dir ] || tar -xvf ${jdk_tar} -C /usr/java

echo 'export JAVA_HOME=/usr/java/jdk1.8.0_144
export JRE_HOME=${JAVA_HOME}/jre
export PATH=$PATH:${JAVA_HOME}/bin:${JRE_HOME}/bin
export CLASSPATH=${JAVA_HOME}/lib:${JRE_HOME}/lib' >$jdk_env
}

case $1 in
6)
jdk6
;;
7)
jdk7
;;
8)
jdk8
;;
*)
echo "you must select jdk version!!"
echo "bash $0 6|7|8"
exit
;;
esac
