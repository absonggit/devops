Git global setup
git config --global user.name "Administrator"
git config --global user.email "admin@example.com"


Create a new repository
git clone git@gitlab.example.com:root/community.git
cd community
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master


Existing folder or Git repository
cd existing_folder
git init
git remote add origin http://root:abc123456@192.168.6.230/root/community.git
git add .
git commit -m "备注"
git push -u origin master




同步线上到本地
git pull --rebase origin master
这条指令的意思是把远程库中的更新合并到本地库中，–rebase的作用是取消掉本地库中刚刚的commit，并把他们接到更新后的版本库之中。
