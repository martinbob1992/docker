# 构建一个具有java运行环境且包含Libreoffice转码软件的基础镜像
FROM openjdk:8-jre-slim
 
COPY Fonts/ /usr/share/fonts/Fonts
RUN sed -i s@/deb.debian.org/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y --no-install-recommends libreoffice fontconfig && \
    fc-cache  -fv && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
