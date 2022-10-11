jps_om='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIvD6xI3XCR4qw0M8V2FpK8w6vadRlN0j4hxr9pDMgiR//a8X0w7puIm3vJ+xDv/H3e0GdKR4vJPE8Q3jHEwQDeL+3tozHLfWK117Wr59W4DtCiriUFq6BOT0+iuLqKN8MThweVSFOpgosuofSncIwJ8QfjsmC2HTVXQtHi7vXQoGo7gWmdfPVFwEg23F2EIw6dRHNRQQsgX0wFMfQlxo95kYFv0DvBq7cisglb+G433SHcRcW2LuQquTEhsRaqUsrOKRjBfwuA+JkZ5YZwciQ+RPKYDJOLpr/qoVUC7wWIRFVSl3PvfXcVopgHDbrp6Ls7PUCTLKSeLVULxdDloSR om_user@jps'
jps_root='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7W6u16Rbb7AzuqzmfQPa0MXcnEL8QXcfJI+pufW0gkKzgw4/jVsq+shByMjyfPXBISLxxlx/RoBEWb0qlJo7RvOFWiS1yoQGl6+YIjQDzF81TkkT+LHQMb/+jcb/rodr6hmWgujgV7sZDInOUpezSmmNceFq7xzGX+q0cEWmxHNmWQtv3GxKIiV3Z64F6NSJ6QfZMbSJx+yPf8rgeoLcNQKMRRBx3n+y5BYc4aMb8nMffSLy1aX0zMl/smMXnAgnLTfxP5B/HQjpQalEP8YtWYr3QNNAT+O/d6JofUonNYAw1pjxY9NI7DGbJz39e0R2pZNtGWBYsv8n6N51A/A6B root@jps'
if ! grep "${jps_root}" /root/.ssh/authorized_keys > /dev/null
then
    echo "${jps_root}" >> /root/.ssh/authorized_keys
    echo "堡垒机特权用户添加公钥"
fi
if ! grep "${jps_om}" /home/om_user/.ssh/authorized_keys > /dev/null
then
    echo "${jps_om}" >> /home/om_user/.ssh/authorized_keys
    echo "堡垒机OM用户添加公钥"
fi

if ! grep "sshd:43.198.73.220:allow" /etc/hosts.allow > /dev/null
then
    sed -i '1i\sshd:43.198.73.220:allow' /etc/hosts.allow
    echo "堡垒机IP添加 hosts.allow" 
fi
