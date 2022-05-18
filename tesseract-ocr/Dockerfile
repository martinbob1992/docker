# 环境中多安装了python和opencv包用来进行图像处理
FROM ubuntu:18.04

COPY data/chi_sim.traineddata /font_temp/
RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
	DEBIAN_FRONTEND=noninteractive apt-get update && \
	apt-get install -y --no-install-recommends tesseract-ocr python3-pip openjdk-8-jre python3.6 && \
	cp /font_temp/chi_sim.traineddata $(find /usr/share/tesseract-ocr -name tessdata) && \
        rm -rf /font_temp && \
	rm -rf python && \
	ln -s /usr/bin/python3.6 /usr/bin/python && \
	pip3 install opencv-python==3.4.2.16 -i https://mirrors.aliyun.com/pypi/simple && \
	pip3 install opencv-contrib-python==3.4.2.16 -i https://mirrors.aliyun.com/pypi/simple && \
	apt-get clean && rm -rf /var/lib/apt/lists/*
