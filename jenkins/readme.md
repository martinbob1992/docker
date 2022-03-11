docker pull jenkins/jenkins

mkdir -r ~/docker/jenkins/data
chmod 777 ~/docker/jenkins/data

docker run --privileged=true --restart=always -d --name jenkins -p 8001:8080 -p 50000:50000 -v $(which docker):/usr/bin/docker -v ~/docker/jenkins/data:/var/jenkins_home jenkins/jenkins