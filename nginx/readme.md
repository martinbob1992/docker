```shell
docker run --name nginx -d -p 80:80 -p 443:443 --restart=always --privileged=true --net=host -v /home/prototype/html:/usr/share/nginx/prototype -v ~/docker/nginx/html:/usr/share/nginx/html -v ~/docker/nginx/conf/nginx.conf:/etc/nginx/nginx.conf  -v ~/docker/nginx/logs:/var/log/nginx -v ~/docker/nginx/conf.d:/etc/nginx/conf.d -v ~/docker/nginx/cert:/etc/nginx/cert nginx
```