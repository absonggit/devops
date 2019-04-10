```
#/bin/bash
# The following two public-keys are the same. Is the default administrative user in web/set. This experiment is using sysuser users.
user=sysuser
group=sysuser

yum install libselinux-python -y
setenforce 0
egrep "^$user" /etc/passwd >& /dev/null  
if [ $? -ne 0 ]  
then  
    useradd $user  
    cd /home/$user/
    mkdir .ssh
    cat << EOF >.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDaKyTxDcSLndRL2Hu60s2yepmD7pvVQF9Fyvzh4v6+FeqthXLOgoh8DHLEodMFACTM3An3VT4Ag5fUBe0kkmx4WwXOzt0ITxpvHy69gB2sMq9nViQNZha5tZGhO7E9BkeGdoZ53636nZiGel/aFVke4xJZTtm8Bkb3/phXrQo48lS6m6N/bsm6isIJqp54U2JE5KsHLOz9iFWONRzUSHuYOuuNlzvpyc61uHQ38SwWcTk28/oEicSdf4cMJpbaUwK9RFqNNpAUBdoOiQJbs1Q3DUTKDrDQ/Eg4B6CR+UpRMwR0OrVehcyFKQuK8VaOoYb/t6JndqMqiHVgc8nWVw6z root@localhost.localdomain
EOF
   chmod 600 .ssh/authorized_keys
   chown $user.$user .ssh -R

egrep "^$group" /etc/sudoers >& /dev/null
if [ $? -ne 0 ]
then
	 cat >>/etc/sudoers<<EOF
sysuser ALL=(ALL)       NOPASSWD:ALL
EOF
fi

else
   userdel -r $user
   useradd  $user
    cd /home/$user/
    mkdir .ssh
    cat << EOF >.ssh/authorized_key
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDaKyTxDcSLndRL2Hu60s2yepmD7pvVQF9Fyvzh4v6+FeqthXLOgoh8DHLEodMFACTM3An3VT4Ag5fUBe0kkmx4WwXOzt0ITxpvHy69gB2sMq9nViQNZha5tZGhO7E9BkeGdoZ53636nZiGel/aFVke4xJZTtm8Bkb3/phXrQo48lS6m6N/bsm6isIJqp54U2JE5KsHLOz9iFWONRzUSHuYOuuNlzvpyc61uHQ38SwWcTk28/oEicSdf4cMJpbaUwK9RFqNNpAUBdoOiQJbs1Q3DUTKDrDQ/Eg4B6CR+UpRMwR0OrVehcyFKQuK8VaOoYb/t6JndqMqiHVgc8nWVw6z root@localhost.localdomain
EOF
   chmod 600 .ssh/authorized_keys
   chown $user.$user .ssh -R
egrep "^$group" /etc/sudoers >& /dev/null
if [ $? -ne 0 ]
then
         cat >>/etc/sudoers<<EOF
sysuser ALL=(ALL)       NOPASSWD:ALL
EOF

fi

fi
```
