FROM tobby48/spark-common:latest
MAINTAINER Suk Heo <tobby48@gmail.com>

# Set install path for Livy
ENV LIVY_BUILD_VERSION livy-server-0.3.0
ENV LIVY_HOME /apps/livy
ENV LIVY_LOG $LIVY_HOME/logs

# Clone Livy repository
RUN mkdir -p /apps && \
    cd /apps && \
    wget http://archive.cloudera.com/beta/livy/$LIVY_BUILD_VERSION.zip && \
    unzip $LIVY_BUILD_VERSION.zip && \
    mv $LIVY_BUILD_VERSION $LIVY_HOME && \
    rm /apps/$LIVY_BUILD_VERSION.zip && \
    mkdir -p $LIVY_LOG

# Copy config file
COPY livy.conf $LIVY_HOME/conf
COPY livy-env.sh $LIVY_HOME/conf

# location Spark module
RUN mkdir -p /apps/spark-modules

# Set Volume
VOLUME ["/apps/livy/logs"]

# Add custom files, set permissions
ADD entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN ln -s usr/local/bin/entrypoint.sh

# TCP   8998	Livy Server
EXPOSE 8998

ENTRYPOINT ["entrypoint.sh"]
