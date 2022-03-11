```shell
sudo docker run --privileged=true -p 6379:6379 --name redis --restart=always -v /root/docker/redis/data:/data -d redis:5.0.4 redis-server --requirepass "123456" --appendonly yes
```