FROM lcr.loongnix.cn/library/python:2.7-jdk8

LABEL maintainer="yangzewei@loongson.cn"

RUN wget https://github.com/Loongson-Cloud-Community/presto/releases/download/0.216/presto-server-0.216.tar.gz -O /opt/presto-server-0.216.tar.gz && cd /opt && tar xf presto-server-0.216.tar.gz && rm presto-server-0.216.tar.gz

COPY pip.conf /root/.pip/

VOLUME /opt/presto-server-0.216/etc/

WORKDIR /opt/presto-server-0.216

EXPOSE 48286

CMD ["bin/launcher","run"]
