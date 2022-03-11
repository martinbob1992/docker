```shell
docker pull cptactionhank/atlassian-confluence:latest

docker run -d --name confluence --privileged=true --restart=always -p 8002:8090 --user root:root \
-e TZ="Asia/Shanghai" \
-v /root/docker/confluence/data:/var/atlassian/confluence \
-v /root/docker/confluence/logs:/opt/atlassian/confluence/logs \
-v /root/docker/confluence/lib/atlassian-extras-decoder-v2-3.4.1.jar:/opt/atlassian/confluence/confluence/WEB-INF/lib/atlassian-extras-decoder-v2-3.4.1.jar \
-v /root/docker/confluence/fonts:/opt/atlassian/confluence/fonts \
-v /root/docker/confluence/bin/setenv.sh:/opt/atlassian/confluence/bin/setenv.sh \
cptactionhank/atlassian-confluence:latest


# 破解方式
https://www.cnblogs.com/rslai/p/8845777.html

docker cp confluence:/opt/atlassian/confluence/confluence/WEB-INF/lib/atlassian-extras-decoder-v2-3.4.1.jar ./
```