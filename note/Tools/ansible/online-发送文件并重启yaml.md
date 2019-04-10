```
[backup-pro-cluster2]
1.1.1.1

[wallet-pro-backup:children]
backup-pro-cz-homepage
backup-pro-homepage
backup-pro-porxy
backup-pro-office-client
backup-pro-browser
backup-pro-wex
backup-pro-cluster1
backup-pro-cluster2

[wallet-pro-backup:vars]
host_key_checking=false
ansible_ssh_port=6599


[wallet-test-aws:children]
test-frontend-aws
test-rabbitmq-aws
test-service1-aws
test-service2-aws

[wallet-test-aws:vars]
host_key_checking=false
ansible_ssh_port=6263

```

```
重启nginx
---
- hosts: pro-master-browser-new
  remote_user: root
  vars:
    jks_workspace: /data/jenkins_home/workspace
    Web_path: /data/WebServer
  tasks:
  - name: remove src file
    file: path={{ Web_path }}/dc-chain-browser/ state=absent
  - name: create web_dir
    file: path={{ Web_path }}/dc-chain-browser/ state=directory owner=www group=www
  - name: uncompress the tar packages
    unarchive: src={{ jks_workspace }}/trad-dc-chain-browser/dc-chain-browser.tag.gz dest={{ Web_path }}/dc-chain-browser owner=www group=www
  - name: restart nginx-service
    service: name=nginx state=restarted
```

```
重启tomcat
---
- hosts: pro-master-service-cluster1
  remote_user: root
  vars:
    tomcat_path: /data/WebServer/dc-chain-service
    jks_workspace: /data/jenkins_home/workspace
    Web_path: /data/WebServer
    tomcat_start: "{{ tomcat_path }}/bin/startup.sh"
    tomcat_stop: "{{ tomcat_path }}/bin/shutdown.sh"
  tasks:
  - name: copy war package
    copy: src={{ jks_workspace }}/trad-dc-chain-service-cluster1/dc-chain-service.war dest={{ Web_path }}/dc-chain-service/webapps/
  - name: restart tomcat
    shell: . /etc/profile;set -m;{{ tomcat_stop }};{{ tomcat_start }}
```
