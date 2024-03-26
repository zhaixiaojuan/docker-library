FROM lcr.loongnix.cn/library/alpine:3.19 as deepflow-server

MAINTAINER yangzewei@loongson.cn

RUN apk add tzdata coreutils

COPY ./server.yaml /etc/
RUN mkdir /etc/mysql
COPY ./controller/db/mysql/migration/rawsql /etc/mysql
COPY ./querier/db_descriptions /etc/db_descriptions/
ARG TARGETARCH 

RUN echo "10.130.0.87 cloud.loongnix.cn" | tee -a /etc/hosts \
   && wget http://cloud.loongnix.cn/releases/loongarch64/deepflow.io%2Fdeepflow%2F6.1.4/deepflow-server-linux-loong64.tar.gz  \
   && tar xf deepflow-server-linux-loong64.tar.gz \
   && chmod +x /bin/deepflow-server


CMD /bin/deepflow-server
