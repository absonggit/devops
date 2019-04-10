```
version: '3'
services:
  rabbitmq:
    container_name: rabbitmq
    build: rabbitmq
    #image: rabbitmq:3.7.5-management-alpine
    restart: always
    ports:
      - 5672:5672
      - 15672:15672
      - 15674:15674
      - 61613:61613
    #volumes:
    #  - '/data/compose-docker/rabbitmq/rabbitmq-conf:/etc/rabbitmq'
```

```
rabbitmq/Dockerfile
FROM rabbitmq:3.7.5-management-alpine
ADD rabbitmq-conf /etc/rabbitmq/

rabbitmq/rabbitmq-conf/enabled_plugins
[rabbitmq_management,rabbitmq_stomp,rabbitmq_web_stomp].

rabbitmq/rabbitmq-conf/rabbitmq.conf
loopback_users.guest = false
listeners.tcp.default = 5672
hipe_compile = false
management.listener.port = 15672
management.listener.ssl = false
```
