mkdir -p ~/docker/zentao
cd ~/docker/zentao
mkdir zentaopms mysqldata
# 下载开源版镜像
docker pull easysoft/zentao:16.4
# 如果想连数据库则可以将3306端口映射出去
docker run --restart=always --name zentao -p 8003:80 \-v ~/docker/zentao/zentaopms:/www/zentaopms -v ~/docker/zentao/mysqldata:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=yihai@123 -d easysoft/zentao:16.4
