# elasticsearch
```shell
# 创建一个elk专用网络
docker network create elk_network

docker run -d --privileged=true --restart=always --network=elk_network \ 
--cpuset-cpus=2 -m 2G --name=es -p 9200:9200 -p 9300:9300 \
-e ES_JAVA_OPTS="-Xms1024m -Xmx1024m" -e "discovery.type=single-node" \
-v /root/docker/es/plugins:/usr/share/elasticsearch/plugins \
-v /root/docker/es/data:/usr/share/elasticsearch/data \ 
-v /root/docker/es/logs:/usr/share/elasticsearch/logs \ 
elasticsearch:6.8.18
```

# kibana
```shell
docker run -d --privileged=true --restart=always --network elk_network \
-p 5601:5601 --name kibana -v /root/docker/kibana/config:/usr/share/kibana/config \
kibana:6.8.18
```
# logstash
```shell
docker run -d --restart=always --privileged=true --net elk_network \
--cpuset-cpus=2 -m 1G -p 5044:5044 \
-v /root/docker/logstash/config:/usr/share/logstash/config \ 
-v /root/docker/logstash/pipeline:/usr/share/logstash/pipeline \ 
-v /root/docker/logstash/template:/usr/share/logstash/template \
-v /root/docker/logstash/logs:/usr/share/logstash/logs \ 
-v /root/opt/yl_pension/pension-web/logs:/usr/local/docker/logstash/yihai_log/pension-web \ 
-v /root/opt/yl_pension/wristband-web/logs:/usr/local/docker/logstash/yihai_log/wristband-web \ 
--name logstash logstash:6.8.18
```

