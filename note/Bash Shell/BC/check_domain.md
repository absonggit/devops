```Shell
#!/bin/bash

file_name=check_status.`date +%Y-%m-%d`.txt
current_path=/root/server_check

bbs_domain=("www.qybets.com"
            "www.lehubbs.com"
            "www.mzc80.com"
            "blog.wusong123.com")

cd $current_path
echo "---------- Check access domain ----------" >> ./logs/$file_name
for domain_name in ${bbs_domain[@]};do
        domain_status=`/usr/bin/curl -s -w "%{http_code}" -o /dev/null ${domain_name}`
        #echo "${domain_name} ${domain_status}" |awk -F '{printf("%-25s%-25s\n",$1,$2)}' >> ./$file_name
        file_time=`date +%Y:%m:%d-%H:%M:%S`
        printf "%-25s %-5s %-20s \n" ${domain_name} ${domain_status} ${file_time} >> ./logs/$file_name
        #echo "${domain_name}"%"${domain_status}" |awk -F '{printf("%-20s%-25s\n",$1,$2)}'
done
echo >> ./logs/$file_name

```
