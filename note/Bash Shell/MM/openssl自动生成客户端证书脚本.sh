#!/bin/bash
#wwj-201601129
#!/bin/bash
#wwj-201601129
#mkpasswd必须先执行yum install -y expect

export path=/usr/local/nginx/ca
export pas=lvyu@SHEQU2016
export dd=`date +%Y-%m-%d`

echo "------------------$dd------------------" >> cerfile.txt
read -p "请输入生成证书的个数: " num
for i in `seq 1 $num`
do        
	read -p "请输入证书名字：" user
        pass=`mkpasswd -l 8 -d 2 -c 2  -s 1`
        openssl genrsa -des3 -passout pass:$pas -out $path/users/$user.key 2048        openssl req -new -passin pass:$pas -subj /C=CN/ST=LIAONING/L=SHENYANG/O=DONKISHTECH/OU=DEV/CN=LVYUSHEQU/emailAddress=server@lvyushequ.com -key $path/users/$user.key -out $path/users/$user.csr        
	openssl ca -in $path/users/$user.csr -cert $path/private/ca.crt -keyfile $path/private/ca.key -out $path/users/$user.crt -config "$path/conf/openssl.conf" -batch
        openssl pkcs12 -passin pass:$pas -passout pass:$pass  -export -clcerts -in $path/users/$user.crt -inkey $path/users/$user.key -out $path/users/$user.p12
        echo "user:$user.p12 ---password:$pass" >> cerfile.txt
        sleep 1
done
echo " " >> cerfile.txt
