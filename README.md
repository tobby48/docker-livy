# Livy 0.3 docker base on Spark 2.1

**Configuration**
- livy.conf : Need to update 'livy.spark.master' (Only Standalone mode)
- livy-env.sh : Add to HADOOP_CONF_DIR env (Only YARN mode)
- and so on....

**BUILD**
```
docker build -t tobby48/livy:lastest livy
```

**RUN**
- After Master and Worker(Standalone mode) or NameNode and DataNode(YARN mode)...
- YARN mode : [Run Hadoop Cluster within Docker Containers](https://github.com/kiwenlau/hadoop-cluster-docker)
- Standalone mode : [spark-master](https://github.com/tobby48/docker-spark-master), [spark-worker](https://github.com/tobby48/docker-spark-worker)
```
docker stop livy
docker rm -f livy
docker run -d \
        --name livy \
	--restart=always \
        -v {user-log-path}:/apps/livy/logs \
        -p 8998:8998 \
        tobby48/livy:lastest
	docker cp {user-spark-fat-jar} livy:/apps/spark-modules/
```

**Notice**
- {user-log-path} : local path from livy log
- {user-spark-fat-jar} : spark app fat jar
