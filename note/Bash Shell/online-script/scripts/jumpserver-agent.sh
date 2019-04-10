#!/bin/bash
# Description: jumpserver-agent install
# Date: 2018/08/19
# Author: francis

# public key for every user
root_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDDMLpt8oR9MbmG8V2JWiAlQLH8yXbjDyaIC7KrqgZ6CzEdMW75giDr1gqL8g0lRcCUCNu6HLlgXI4CUWjXZwiXT/YAgK55nyptbAyK4YQh0rJw1u9eyXcTb+lH4ei/UIHUnfFylDlR24RYdg6NRID/5cxnvwgcl40UpdpMLVw2kzf3HQHoDwjDkWnpU9ox6ioR7iXcVXatByzDy395EPJOXF14ZLa8Jw2Rlloi9aZPA0qfMtbHXOJYQcm+Ovp51yhs0wFPi5Vc5j8Wt1HxMRI3IvZ+OuYbvgqXjCUzHON90bmnnkJNE6W/U0kHAIR2lwRhoOqnYXbOJRjNdPkDh5S1 root@localhost.localdomain"

sysuser_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDaKyTxDcSLndRL2Hu60s2yepmD7pvVQF9Fyvzh4v6+FeqthXLOgoh8DHLEodMFACTM3An3VT4Ag5fUBe0kkmx4WwXOzt0ITxpvHy69gB2sMq9nViQNZha5tZGhO7E9BkeGdoZ53636nZiGel/aFVke4xJZTtm8Bkb3/phXrQo48lS6m6N/bsm6isIJqp54U2JE5KsHLOz9iFWONRzUSHuYOuuNlzvpyc61uHQ38SwWcTk28/oEicSdf4cMJpbaUwK9RFqNNpAUBdoOiQJbs1Q3DUTKDrDQ/Eg4B6CR+UpRMwR0OrVehcyFKQuK8VaOoYb/t6JndqMqiHVgc8nWVw6z root@localhost.localdomain"

otheruser_keyr="ssh-rsa  AAAAB3NzaC1yc2EAAAADAQABAAABAQDDMLpt8oR9MbmG8V2JWiAlQLH8yXbjDyaIC7KrqgZ6CzEdMW75giDr1gqL8g0lRcCUCNu6HLlgXI4CUWjXZwiXT/YAgK55nyptbAyK4YQh0rJw1u9eyXcTb+lH4ei/UIHUnfFylDlR24RYdg6NRID/5cxnvwgcl40UpdpMLVw2kzf3HQHoDwjDkWnpU9ox6ioR7iXcVXatByzDy395EPJOXF14ZLa8Jw2Rlloi9aZPA0qfMtbHXOJYQcm+Ovp51yhs0wFPi5Vc5j8Wt1HxMRI3IvZ+OuYbvgqXjCUzHON90bmnnkJNE6W/U0kHAIR2lwRhoOqnYXbOJRjNdPkDh5S1 jumpserver@localhost"

# create a user and ssh file if this user doesn't exist.
# sudo useradd -m -d /home/devuser devuser (ubuntu)
function create_user() {
  id ${u} > /dev/null 2>&1
  if [ $? -ne 0 ];then
    useradd ${u};
    mkdir /home/${u}/.ssh;
  else
    if [ ! -d /home/${u}/.ssh ];then mkdir /home/${u}/.ssh;fi
  fi
}

# modify user permissions.
function modify_per () {
  chmod 600 /home/${u}/.ssh/authorized_keys;
  chown -R ${u}:${u} /home/${u}/.ssh/authorized_keys;
}

# manage user list
user_list=("root"
           "sysuser"
           "manager"
           "omuser"
           "devuser")

# main program
for u in ${user_list[@]};do
 if [ ${u} == "root" ];then
   id ${u} > /dev/null 2>&1
   if [ $? -ne 0 ];then
     echo "This "root" user does not exist! really?";
     exit;
   else
     if [ ! -d "/${u}/.ssh" ];then mkdir /${u}/.ssh; fi
     echo -e ${root_key} >> /${u}/.ssh/authorized_keys;
     chmod 600 /${u}/.ssh/authorized_keys;
     chown -R ${u}:${u} /${u}/.ssh/authorized_keys;
   fi
 elif [ ${u} == "sysuser" ];then
   create_user;
   echo -e ${sysuser_key} >> /home/${u}/.ssh/authorized_keys;
   modify_per;
 else
   create_user;
   echo -e ${otheruser_keyr} >> /home/${u}/.ssh/authorized_keys;
   modify_per;
 fi
done
