FROM openjdk:8u171-jdk

MAINTAINER marsh

# 创建一个非root用户来运行程序
ARG user=java
ARG group=java
ARG uid=3000
ARG gid=3000

# 替换xxxx
ARG JAR_NAME="xxxx.jar"
ARG JAR_FILE="xxxx/target/${JAR_NAME}"
ENV JAR_EXPOSE="8081"

ENV WORK_DIR="/opt/java"
# 创建工作目录，并分配用户权限，如果要挂载目录主机需要创建一个uid=3000的用户，防止出现权限问题
# 根据具体业务情况创建路径，目前这里创建了logs目录及gc子目录和文件上传的存放目录
RUN mkdir -p ${WORK_DIR}/logs/gc \
  && mkdir -p ${WORK_DIR}/upload \
  && chown ${uid}:${gid} ${WORK_DIR} \
  && groupadd -g ${gid} ${group} \
  && useradd -N -d "${WORK_DIR}" -u ${uid} -g ${gid} -m -s /bin/bash ${user}


WORKDIR ${WORK_DIR}
ADD ${JAR_FILE} ${WORK_DIR}/${JAR_NAME}

# 设置容器的时间
ENV TZ="Asia/Shanghai"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN chown -R ${user} "$WORK_DIR"

USER ${user}
ARG JAVA_OPTS="-Xmx512m -Xms512m -Xmn256m -XX:MetaspaceSize=256M -XX:MaxMetaspaceSize=256M"
ARG JVM_SERVER_FIXED_ARGS="-server -XX:+DisableExplicitGC -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+UseCMSInitiatingOccupancyOnly \
-XX:CMSInitiatingOccupancyFraction=70 -XX:+ExplicitGCInvokesConcurrentAndUnloadsClasses -XX:+CMSClassUnloadingEnabled -XX:+ParallelRefProcEnabled \
-XX:+CMSScavengeBeforeRemark -XX:+HeapDumpOnOutOfMemoryError -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintHeapAtGC \
-XX:+PrintGCApplicationStoppedTime -XX:+PrintGCDateStamps"
ARG JVM_GC_LOG_PATH="-XX:ErrorFile=${WORK_DIR}/logs/gc/hs_err_pid%p.log -XX:HeapDumpPath=${WORK_DIR}/logs/gc -Xloggc:${WORK_DIR}/logs/gc/gc%t.log"
ARG SPRING_BOOT_YML=""

# 定义参数
ENV JAR_NAME=${JAR_NAME}
ENV JAVA_OPTS=${JAVA_OPTS}
ENV JVM_SERVER_FIXED_ARGS=${JVM_SERVER_FIXED_ARGS}
ENV JVM_GC_LOG_PATH=${JVM_GC_LOG_PATH}
ENV SPRING_BOOT_YML=${SPRING_BOOT_YML}
#对外暴漏的端口号
EXPOSE ${JAR_EXPOSE}

#指定容器启动时需要执行的命令
ENTRYPOINT java ${JAVA_OPTS} ${JVM_SERVER_FIXED_ARGS} ${JVM_GC_LOG_PATH} ${SPRING_BOOT_YML} -Djava.security.egd=file:/dev/./urandom -Dfile.encoding=UTF-8 -jar ${WORK_DIR}/${JAR_NAME}