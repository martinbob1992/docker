# 在服务器上创建一个java用户来运行项目
```shell
# 创建一个用户组id为3000的 java 组
groupadd -g 3000 java

# -N 表示取消建立以用户名称为名的群组．因为在上一步我们已经创建好了java的组群了，无法重复创建
# -d 指定用户登入时的起始目录，每次用户登录到系统自动进入/home/java目录
# -u 指定用户id
# -g 指定用户组id
# -m 自动建立用户的登入目录,这里会自动将/home/yihai-java目录创建
useradd -N -d /home/java -u 3000 -g 3000 -m java
# 可以通过如下方式修改java用户的密码
passwd java
```
```shell
# java项目使用maven进行打包的命令
mvn clean package -U -Dmaven.test.skip=true
```

```shell
# 切换到java用户
su java
# 创建项目路径  xxx更换为自己项目名字
mkdir -r /home/java/opt/test/xxx/build
# 将刚才打好的jar包和Dockerfile文件放到上面的路径中（Dockerfile模板在本目录下）
# 将run.sh文件放到/home/java/opt/test/xxx目录下（run.sh模板在本目录下）
# 通过运行run.sh文件即可创建和运行容器(运行run.sh前已默认当前机器安装了docker环境）
sh /home/java/opt/test/xxx/run.sh
```

