docker pull nacos/nacos-server:v2.0.4

# 下载数据库文件
https://github.com/alibaba/nacos/blob/master/distribution/conf/nacos-mysql.sql
# 在mysql数据库中创建一个nacos_config的库，并执行上面的sql语句

# 创建数据挂载目录
mkdir -p ~/docker/nacos/data
mkdir -p ~/docker/nacos/conf
mkdir -p ~/docker/nacos/logs

# 创建一个初始容器，主要用于copy配置文件
docker run -d -p 8848:8848 --name nacos \
--ip 192.168.199.91 --env MODE=standalone --env SPRING_DATASOURCE_PLATFORM=mysql \
--env MYSQL_SERVICE_HOST=192.168.199.91 --env MYSQL_SERVICE_PORT=3306 \
--env MYSQL_SERVICE_DB_NAME=nacos_config --env MYSQL_SERVICE_USER=nacos \
--env MYSQL_SERVICE_PASSWORD=yihai@123 nacos/nacos-server:v2.0.4

# 拷贝出来容器中的文件
docker cp nacos:/home/nacos/logs ~/docker/nacos
docker cp nacos:/home/nacos/conf ~/docker/nacos
docker cp nacos:/home/nacos/data ~/docker/nacos

# 删除镜像
docker rm -f nacos

# 创建最终挂载了数据盘的nacos
docker run -d -p 8848:8848 --name nacos --restart=always \
--ip 192.168.199.91 --env MODE=standalone --env SPRING_DATASOURCE_PLATFORM=mysql \
--env MYSQL_SERVICE_HOST=192.168.199.91 --env MYSQL_SERVICE_PORT=3306 \
--env MYSQL_SERVICE_DB_NAME=nacos_config --env MYSQL_SERVICE_USER=nacos \
--env MYSQL_SERVICE_PASSWORD=yihai@123 \
-v ~/docker/nacos/logs:/home/nacos/logs \
-v ~/docker/nacos/conf:/home/nacos/conf \
-v ~/docker/nacos/data:/home/nacos/data \
nacos/nacos-server:v2.0.4


# 访问如下地址使用默认账号密码进行登录
# 账号：nacos   密码：nacos
http://192.168.199.91:8848/nacos