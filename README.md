# Spark 2.1 binary & livy 0.3 docker base on ubuntu
- ADD on livy

## 1. Spark Standalone mode

**BUILD**
##### 1. base : spark common
```
docker build -t tobby48/spark-base:lastest base
```
##### 2. master : spark master
```
docker build -t tobby48/spark-master:lastest master
```
##### 3. worker : spark worker
```
docker build -t tobby48/spark-worker:lastest worker
```
##### 4. livy : spark job management opensource stack
```
docker build -t tobby48/livy:lastest livy
```

**RUN**
##### 1. master
```
docker stop spark-master
docker rm -f spark-master
docker run -d \
	--name spark-master \
	--restart=always \
	--hostname xxx.xxx.xxx.xxx \
	-p 8080:8080 \
	-p 7077:7077 \
	tobby48/spark-master:lastest
```
##### 2. worker
```
docker stop spark-worker
docker rm -f spark-worker
docker run -d \
	--name spark-worker \
	--restart=always \
	-e SPARK_MASTER=spark://xxx.xxx.xxx.xxx:7077 \
	-p 8081:8081 \
	tobby48/spark-worker:lastest
```
##### 3. livy
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
- livy.conf : Need to update 'livy.spark.master'



## 2. YARN mode

**BUILD**
##### 1. base : spark common
```
docker build -t tobby48/spark-base:lastest base
```
##### 2. livy : spark job management opensource stack
```
docker build -t tobby48/livy:lastest livy
```

**RUN**
##### 1. hadoop
- hadoop-cluster-docker: [Run Hadoop Cluster within Docker Containers](https://github.com/kiwenlau/hadoop-cluster-docker)
##### 2. livy
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
- livy-env.sh : Add to HADOOP_CONF_DIR env
