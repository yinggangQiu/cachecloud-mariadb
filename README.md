wget jdk-7u79-linux-x64.tar.gz 
mv ./cachecloud-web  /opt/<br>
docker run -it -d --name tomcat11 -v /opt/cachecloud-web/:/opt/cachecloud-web/ -v /var/lib/mysql/:/var/lib/mysql/ -p 8585:8585 tomcat10
