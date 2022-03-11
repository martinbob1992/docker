```shell
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
sed -i 's#download.docker.com#mirrors.aliyun.com/docker-ce#' /etc/yum.repos.d/docker-ce.repo
# 安装docker
yum -y install docker-ce
 
# 启动docker
systemctl start docker.service
 
# 配置阿里云镜像加速,镜像加速地址请自行到阿里云申请
cat > /etc/docker/daemon.json <<EOFI
{
  "registry-mirrors": ["https://xxxx.mirror.aliyuncs.com"],
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
  "max-size": "100m"
}
}
EOFI
 
# 重启守护进程
systemctl daemon-reload
# 重启docker服务
systemctl restart docker.service
# 配置docker开机自启动
systemctl enable docker.service

# 查询docker安装信息
docker info
```

```shell
# 当使用非root账号运行docker命令会出现权限不足问题，需要将这个用户添加到docker组中才能运行docker命令
# 已下命令均使用root用户进行操作
# 添加docker用户组，如果已经有docker组则忽略该命令
groupadd docker
 
# 将指定用户添加到docker
gpasswd -a $USER docker
# 切换到$USER 更新用户组
newgrp docker
```