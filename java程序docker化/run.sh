#!/bin/bash
# 项目，端口，路径根据实际情况自己定义
project=xxxx
port=8081
projectPath=/home/java/opt/test/xxxx

#docker build
set -e
docker build --build-arg SPRING_BOOT_YML="-Dspring.profiles.active=test -Dserver.port=$port -Dmarsh.log.path=/opt/java/logs" -t $project:latest -f $projectPath/build/Dockerfile $projectPath/build
set +e
docker rm -f $project
# 清理悬空镜像
docker rmi $(docker images -q -f dangling=true)
set -e
# -v路径根据实际情况修改
docker run -d --name $project --restart=always -p $port:$port \
-v $projectPath/logs:/opt/java/logs \
-v $projectPath/upload:/opt/java/upload \
$project:latest
