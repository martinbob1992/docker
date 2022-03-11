```shell
docker run --privileged=true -d --name rabbitmq --restart=always -v /home/root/docker/rabbitmq/data:/var/lib/rabbitmq -e RABBITMQ_DEFAULT_USER=admin -e RABBITMQ_DEFAULT_PASS=123456 -p 15672:15672 -p 5672:5672 rabbitmq:3.7.25-management
```