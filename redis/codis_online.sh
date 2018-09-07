#!/bin/bash
Install_dir="/data"
codis_dir=$Install_dir/codis
zk_addr="2.2.2.130:2181"
dash_addr="2.2.2.130:18080"
admin_addr="2.2.2.130:11080"
proxy_addr="0.0.0.0:19000"
product_name="codis_test"
fe_addr="0.0.0.0:8080"
if [ -d  $Install_dir ];then
    rm -rf /data/codis
else
    mkdir -p $Install_dir
fi
#安装软件包
rpm -Uvh http://repos.mesosphere.io/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm
yum install java-1.8.0-openjdk golang mesosphere-zookeeper -y
wget https://github.com/CodisLabs/codis/releases/download/3.2.2/codis3.2.2-go1.8.5-linux.tar.gz || exit
tar xvzf codis3.2.2-go1.8.5-linux.tar.gz -C $Install_dir

#修改目录名
mv $Install_dir/codis3.2.2-go1.8.5-linux/  $Install_dir/codis
mkdir $Install_dir/codis/{conf,logs}

#添加环境变量
cat >> /etc/profile << EOF
export GOPATH=$Install_dir/codis
EOF
source /etc/profile
echo
go version
java -version

#生成配置文件并修改
cp conf/* $codis_dir/conf/
sed -i 's#coordinator_name = "filesystem"#coordinator_name = "zookeeper"#g' $codis_dir/conf/dashboard.toml
sed -i 's#coordinator_addr = "/tmp/codis"#coordinator_addr = "'$zk_addr'"#g' $codis_dir/conf/dashboard.toml
sed -i 's#product_name = "codis-demo"#product_name = "'$product_name'"#g' $codis_dir/conf/dashboard.toml
sed -i 's#admin_addr = "0.0.0.0:18080"#admin_addr = "'$dash_addr'"#g' $codis_dir/conf/dashboard.toml
sed -i 's#product_name = "codis-demo"#product_name = "'$product_name'"#g' $codis_dir/conf/proxy.toml
sed -i 's#proxy_addr = "0.0.0.0:19000"#proxy_addr = "'$proxy_addr'"#g' $codis_dir/conf/proxy.toml
sed -i 's#admin_addr = "0.0.0.0:11080"#admin_addr = "'$admin_addr'"#g' $codis_dir/conf/proxy.toml
sed -i 's#jodis_name = ""#jodis_name = "zookeeper"#g' $codis_dir/conf/proxy.toml
sed -i 's#jodis_addr = ""#jodis_addr = "'$zk_addr'"#g' $codis_dir/conf/proxy.toml
sed -i 's#127.0.0.1#0.0.0.0:18080#g' conf/codis.json

#启动服务
systemctl restart zookeeper
nohup $codis_dir/codis-dashboard --ncpu=4 --config=$codis_dir/conf/dashboard.toml --log=$codis_dir/logs/dashboard.log --log-level=WARN &
nohup $codis_dir/codis-proxy --ncpu=4 --config=$codis_dir/conf/proxy.toml --log=$codis_dir/logs/proxy.log --log-level=WARN &
nohup $codis_dir/codis-fe --ncpu=4 --log=$codis_dir/logs/fe.log --log-level=WARN --dashboard-list=$codis_dir/conf/codis.json --listen=$fe_addr &
sleep 3
$codis_dir/codis-admin --dashboard="$dash_addr" --create-proxy -x"$admin_addr"
echo
netstat -ntlup | grep -E "19000|18080|11080|2181|8080"
