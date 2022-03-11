```shell
mkdir -r  ~/docker/nexus/data
# 给数据目录授权，不然启动过程中会出现异常  Unable to create directory /nexus-data/instance
chmod 777 ~/docker/nexus/data

docker run --privileged=true --restart=always -d -p 8000:8081 --name nexus -e INSTALL4J_ADD_VM_PARAMS="-Xms1024m -Xmx1024m -XX:MaxDirectMemorySize=1024m" -v ~/docker/nexus/data:/nexus-data sonatype/nexus3
```
