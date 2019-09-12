#!/bin/bash
get_nginx(){
    for i in `elinks -dump https://nginx.org/download/ | awk '{print $2}' | grep "nginx-${nginx_version}.tar.gz$"`
    do
        download_url=$i
        package_name=`echo $i | awk -F"/" '{print $NF}'`
        src_dir="nginx-$nginx_version"
    done

    [ $download_url ] || {
        echo "Nginx-${nginx_version}.The version does not exist, re-enter the correct version number"
        get_package
    }
    [ -z `find $home_dir/package -name $package_name` ] &&  wget -q $download_url -P $home_dir/package && echo "nginx-${nginx_version}.tar.gz Download completed" || echo "nginx-${nginx_version}.tar.gz Already downloaded"
}

get_python(){
    curl -Is https://www.python.org/ftp/python/$python_version | grep 404 &>/dev/null
    [ $? -ne 0 ] || {
        echo "Python-${python_version}.The version does not exist, re-enter the correct version number"
        install_python
    }
    [ -z `find $home_dir/package -name Python-${python_version}.tar.xz` ] && wget -q https://www.python.org/ftp/python/$python_version/Python-$python_version.tar.xz -P $home_dir/package && echo "Python-${python_version}.tar.xz Download completed" || echo "Python-${python_version}.tar.xz Already downloaded"
}

install_nginx(){
    tar zxf $home_dir/package/$package_name -C $home_dir/src/
    cd $home_dir/src/$src_dir
    grep "^www" /etc/group &> /dev/null
    [ $? -ne 0 ] && groupadd www
    id www &> /dev/null
    [ $? -ne 0 ] && useradd www -g www -s /sbin/nologin -M
    ./configure --user=www --group=www --prefix=$home_dir/nginx --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module  --with-threads 1> /dev/null
    make 1> /dev/null
    make install 1> /dev/null
}
#install_python(){
#}

clear
echo "Loading, please wait ..."
yum -y install epel-release 1> /dev/null
yum -y install figlet 1> /dev/null

clear
    line1="_______________________________________"
    line2="---------------------------------------"
    echo $line1
    echo -e "`figlet N g i n x`\n`figlet P y t h o n`\n`figlet u W S G I`\n`figlet D j a n g o`\nAutomatic installation script"
    echo $line1
    read -p "Specify the installation path ：" home_dir
    [ $home_dir ] || {
        clear
        echo "No version number entered. re-enter"
        sleep 2
        clear
        sh $0
    }
    mkdir -p $home_dir/{package,src,nginx}
    read -p "Enter the version of nginx to be installed. Example 1.17.3 : " nginx_version
    [ $nginx_version ] || {
        echo "No version number entered. re-enter"
        get_nginx
    }
    read -p "Enter the version of python to be installed. Example 3.7.4 : " python_version
    [ $python_version ] || {
        echo "No version number entered. re-enter"
        get_python
    }
    echo "Installation is about to begin ..."
    sleep 2
clear

main(){
    echo $line1
    echo "Step 1: Initialization environment"
    echo $line2
    mkdir -p $home_dir/{package,src,nginx}

    yum -y update 1> /dev/null
    yum -y install gcc gcc-c++ pcre pcre-devel zlib zlib-devel openssl openssl-devel wget bzip2-devel expat-devel gdbm-devel readline-devel sqlite-devel elinks 1> /dev/null
    echo "Initialization environment completed"
    sleep 2
    clear
    echo $line1
    echo "Step 1: Initialization environment Done"
    echo $line2 
    echo $line1
    echo "Step 2: Download Package"
    echo $line2
    get_nginx && echo "Nginx downloaded" || {
    echo "Nginx download failed"
    exit 2
    }
    get_python && echo "Python downloaded" || {
    echo "Nginx download failed"
    exit 22
    }
    sleep 2
    clear
    echo $line1
    echo "Step 1: Initialization environment Done"
    echo $line2
    echo $line1
    echo "Step 2: Download Package Done"
    echo $line2 
    sleep 2
    clear
    echo $line1 
    echo "Step 1: Initialization environment Done"
    echo $line2
    echo $line1 
    echo "Step 2: Download Package Done"
    echo $line2
    echo $line1
    echo "Step 3: Compile and install"
    echo $line2
    install_nginx && echo "Nginx installation is complete" || {
    echo "Nginx installation is failed"
    exit 3
    }
    sleep 2
    clear
    echo $line1
    echo "Step 1: Initialization environment Done"
    echo $line2 
    echo $line1 
    echo "Step 2: Download Package Done"
    echo $line2 
    echo $line1 
    echo "Step 3: Compile and install Done"
    echo $line2 
    figlet bay bay !    
}
main
