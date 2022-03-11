```shell
# 创建namesrv容器
mkdir -p ~/docker/rocketmq/namesrv/logs
mkdir -p ~/docker/rocketmq/namesrv/data
# 创建并启动
docker run -d -p 9876:9876 \
--name rocketmq_namesrv --restart=always \
-v ~/docker/rocketmq/namesrv/logs:/root/logs \
-v ~/docker/rocketmq/namesrv/data:/root/store \
-e "MAX_POSSIBLE_HEAP=100000000" rocketmqinc/rocketmq:4.4.0 \
sh mqnamesrv


# 创建broker容器
mkdir -p ~/docker/rocketmq/broker/logs
mkdir -p ~/docker/rocketmq/broker/data
mkdir -p ~/docker/rocketmq/broker/config
# 创建配置文件
vi ~/docker/rocketmq/broker/config/broker.conf
brokerClusterName = DefaultCluster
brokerName = broker-a
brokerId = 0
deleteWhen = 04
fileReservedTime = 48
brokerRole = ASYNC_MASTER
flushDiskType = ASYNC_FLUSH
brokerIP1 = 192.168.199.91
# 创建容器
docker run -d -p 10911:10911 -p 10909:10909 \
--name rocketmq_broker --restart=always \
-v ~/docker/rocketmq/broker/logs:/root/logs \
-v ~/docker/rocketmq/broker/data:/root/store \
-v ~/docker/rocketmq/broker/config/broker.conf:/opt/rocketmq-4.4.0/conf/broker.conf \
--link rocketmq_namesrv:namesrv \
-e "NAMESRV_ADDR=namesrv:9876" \
-e "MAX_POSSIBLE_HEAP=200000000" \
rocketmqinc/rocketmq:4.4.0 \
sh mqbroker -c /opt/rocketmq-4.4.0/conf/broker.conf


# rocketmq控制台
# 下载镜像
docker pull styletang/rocketmq-console-ng
docker run -d --restart=always \
--name rocketmq_console \
-e "JAVA_OPTS=-Drocketmq.namesrv.addr=192.168.199.91:9876 -Dcom.rocketmq.sendMessageWithVIPChannel=false" \
-p 9999:8080 \
-t styletang/rocketmq-console-ng


#至此服务部署完毕
浏览器访问9999端口就可以看到监控页面
http://192.168.199.91:9999
```
