#!/bin/bash
Install_dir="/data"
codis_dir=$Install_dir/codis
zk_dir=$Install_dir/zookeeper
zk_addr="0.0.0.0:2181"
dash_addr="0.0.0.0:18080"
admin_addr="0.0.0.0:11080"
proxy_addr="0.0.0.0:19000"
product_name="codis_mode"
fe_addr="0.0.0.0:8080"
if [ -d  $Install_dir ];then
    rm -rf /data/{codis,go,jdk,zookeeper}
else
    mkdir -p $Install_dir
fi
#解压软件包
tar xvzf go1.11.linux-amd64.tar.gz -C $Install_dir
tar xvzf jdk-8u144-linux-x64.tar.gz -C $Install_dir
tar xvzf zookeeper-3.4.13.tar.gz -C $Install_dir
tar xvzf codis3.2.2-go1.8.5-linux.tar.gz -C $Install_dir

#修改目录名
mv $Install_dir/jdk1.8.0_144/ $Install_dir/jdk
mv $Install_dir/zookeeper-3.4.13/ $Install_dir/zookeeper
mv $Install_dir/codis3.2.2-go1.8.5-linux/  $Install_dir/codis
mkdir $Install_dir/codis/{conf,logs}

#添加环境变量
function _ENV (){
cat >> /etc/profile << EOF
export PATH=$PATH:$Install_dir/go/bin
export GOROOT=$Install_dir/go
export GOPATH=$Install_dir/codis
JAVA_HOME=$Install_dir/jdk
CLASS_PATH=$JAVA_HOME/lib:$JAVA_HOME/jre/lib
export ZOOKEEPER_HOME=$Install_dir/zookeeper
export PATH=$PATH:$GOROOT/bin:$JAVA_HOME/bin:$ZOOKEEPER_HOME/bin
EOF
source /etc/profile
echo
go version
java -version
}
if [ ! -e /etc/profile.bak ];then
    cp /etc/profile /etc/profile.bak
    _ENV
else
    \cp /etc/profile.bak /etc/profile
    _ENV
fi
#生成配置文件并修改
cp $zk_dir/conf/zoo_sample.cfg $zk_dir/conf/zoo.cfg
$zk_dir/bin/zkServer.sh start
$codis_dir/codis-dashboard --default-config > $codis_dir/conf/dashboard.toml
$codis_dir/codis-proxy --default-config > $codis_dir/conf/proxy.toml
sed -i 's#coordinator_name = "filesystem"#coordinator_name = "zookeeper"#g' $codis_dir/conf/dashboard.toml
sed -i 's#coordinator_addr = "/tmp/codis"#coordinator_addr = "'$zk_addr'"#g' $codis_dir/conf/dashboard.toml
sed -i 's#product_name = "codis-demo"#product_name = "'$product_name'"#g' $codis_dir/conf/dashboard.toml
sed -i 's#admin_addr = "0.0.0.0:18080"#admin_addr = "'$dash_addr'"#g' $codis_dir/conf/dashboard.toml
sed -i 's#product_name = "codis-demo"#product_name = "'$product_name'"#g' $codis_dir/conf/proxy.toml
sed -i 's#proxy_addr = "0.0.0.0:19000"#proxy_addr = "'$proxy_addr'"#g' $codis_dir/conf/proxy.toml
sed -i 's#admin_addr = "0.0.0.0:11080"#admin_addr = "'$admin_addr'"#g' $codis_dir/conf/proxy.toml
sed -i 's#jodis_name = ""#jodis_name = "zookeeper"#g' $codis_dir/conf/proxy.toml
sed -i 's#jodis_addr = ""#jodis_addr = "'$zk_addr'"#g' $codis_dir/conf/proxy.toml

#启动服务
nohup $codis_dir/codis-dashboard --ncpu=4 --config=$codis_dir/conf/dashboard.toml --log=$codis_dir/logs/dashboard.log --log-level=WARN &
nohup $codis_dir/codis-proxy --ncpu=4 --config=$codis_dir/conf/proxy.toml --log=$codis_dir/logs/proxy.log --log-level=WARN &
$codis_dir/codis-admin --dashboard=$dash_addr --create-proxy -x$admin_addr
$codis_dir/codis-admin --dashboard-list --zookeeper=$zk_addr > $codis_dir/conf/codis.json
nohup $codis_dir/codis-fe --ncpu=4 --log=$codis_dir/logs/fe.log --log-level=WARN --dashboard-list=$codis_dir/conf/codis.json --listen=$fe_addr &
echo
netstat -ntlup | grep -E "19000|18080|11080|2181|8080"
