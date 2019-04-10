ansible-vault encrypt file.yml      #加密明文文件file.yml

ansible-vault decrypt file.yml      #解密已加密的文件file.yml

ansible-vault view file.yml         #打印已加密文件file.yml的内容

ansible-vault create file.yml       #创建新的加密文件file.yml

ansible-vault edit file.yml         #编辑已加密的文件file.yml

ansible-vault rekey file.yml        #变更已加密的文件file.yml的密码


引用加密文件需要加参数    --ask-vault-pass
在playbook中指定加密文件的密码文件    --valut-paaaword-file /directory/password.txt    
