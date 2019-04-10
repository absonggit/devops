执行shell：
```
# npm compilation
npm install
npm run build

# Generate the tar packages
cd dist/
tar zcf dc-chain-browser.tag.gz ./*
mv dc-chain-browser.tag.gz ../
/usr/bin/ansible-playbook /etc/ansible/wallet-pro-online/online-backend-browser.yml
```

```
# update code to production
sed -i "s/\/\*SEDTAG//g" dc-chain-node-api/src/main/java/com/dc/chain/Application.java
sed -i "s/}SEDTAGEND\*\//}/g" dc-chain-node-api/src/main/java/com/dc/chain/Application.java
sed -i "s/{ \/\/SEDTAG//g" dc-chain-node-api/src/main/java/com/dc/chain/Application.java
sed -i "s/<\!--SEDTAG//g"  pom.xml
sed -i "s/SEDTAGEND-->//g"  pom.xml
```

```
# replace service-api
cat > config/prod.env.js <<EOF
module.exports = {
  NODE_ENV: '"production"',
  //production environment service api(BASE_URL: '"https://dc-jiuan-api-pro.com"',)
  //test environment service api(BASE_URL: 'https://www.dc-jiuan-callback-api-pro.com',)
  BASE_URL: '"https://dc-jiuan-api-pro.com"',
  NODE_ID: '"0"'
}
EOF
```

```
NODE_A="server 172.31.37.233:8080 weight=10 max_fails=2 fail_timeout=20s;"
NODE_B="server 172.31.33.77:8080  weight=10 max_fails=2 fail_timeout=20s;"

SELECT_A="cluster1_52.197.61.133"
SELECT_B="cluster2_54.250.135.167"
SELECT_O="cluster1_52.197.61.133,cluster2_54.250.135.167"

echo ${PARA_NODE}
if [ ${PARA_NODE} = ${SELECT_A} ];then
  NODE_A="# server 172.31.37.233:8080 weight=10 max_fails=2 fail_timeout=20s;"
elif [ ${PARA_NODE} = ${SELECT_B} ];then
  NODE_B="# server 172.31.33.77:8080  weight=10 max_fails=2 fail_timeout=20s;"
elif [ ${PARA_NODE} = ${SELECT_O} ];then
  NODE_A="# server 172.31.37.233:8080 weight=10 max_fails=2 fail_timeout=20s;"
  NODE_B="# server 172.31.33.77:8080  weight=10 max_fails=2 fail_timeout=20s;"
else
  NODE_A="server 172.31.37.233:8080 weight=10 max_fails=2 fail_timeout=20s;"
  NODE_B="server 172.31.33.77:8080  weight=10 max_fails=2 fail_timeout=20s;"
fi

cat > ./dc-chain-service.conf << EOF
upstream dc-chain-service {
    # 52.197.61.133 service-cluster1
    ${NODE_A}
    # 54.250.135.167 service-cluster2
    ${NODE_B}
    }
EOF

ansible pro-master-service-proxy -m copy -a "src=/data/jenkins_home/workspace/trad-dc-chain-service-proxy/dc-chain-service.conf \
dest=/data/nginx/conf/proxy/dc-chain-service.conf \
mode=0644"

ansible pro-master-service-proxy -a 'systemctl restart nginx'
```
