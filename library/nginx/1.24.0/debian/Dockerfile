FROM lcr.loongnix.cn/library/debian:sid

LABEL maintainer="yangzewei@loongson.cn"

# nginx 文件夹名称
ENV NGINX_NAME=nginx-1.24.0

# nginx 源码包路径
ENV NGINX_SRC_DIR=/usr/local/src

# nginx 安装路径
ENV NGINX_HOME=/usr/local/$NGINX_NAME

WORKDIR $NGINX_SRC_DIR
# 拷贝源码包
RUN apt-get update && apt-get install -y wget && \
	wget http://nginx.org/download/nginx-1.24.0.tar.gz -O nginx-1.24.0.tar.gz && \
	tar xf nginx-1.24.0.tar.gz && \
	rm nginx-1.24.0.tar.gz

RUN apt-get update && apt-get install -y \
	# 安装基础组件
	# 安装 tzdata, vim, less, ncurses-bin, telnet, wget, zip, unzip, traceroute, procps, net-tools, iproute2, tcpdump  
	&& apt-get install -y tzdata vim less ncurses-bin telnet wget zip unzip traceroute procps net-tools iproute2 tcpdump   \
# 安装编译组件  
	&& apt-get install -y gcc g++ autoconf automake make libssl-dev libpcre3-dev zlib1g-dev \
	&&  ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&&  echo "alias ls='ls --color'" >> ~/.bashrc \
	&&  echo "alias ll='ls -l'" >> ~/.bashrc \
	# 配置基本信息
	&& cd $NGINX_SRC_DIR/$NGINX_NAME && ./configure --prefix=$NGINX_HOME --with-http_ssl_module --with-http_stub_status_module \
	# 编译安装
	&& cd $NGINX_SRC_DIR/$NGINX_NAME && make && make install \
	# forward request and error logs to docker log collector
	&& mkdir /docker-entrypoint.d \
	&& rm -rf $NGINX_SRC_DIR

WORKDIR $NGINX_HOME

COPY docker-entrypoint.sh /

COPY 10-listen-on-ipv6-by-default.sh /docker-entrypoint.d

COPY 15-local-resolvers.envsh /docker-entrypoint.d

COPY 20-envsubst-on-templates.sh /docker-entrypoint.d

COPY 30-tune-worker-processes.sh /docker-entrypoint.d

ENTRYPOINT ["/docker-entrypoint.sh"]

# 配置环境变量
ENV PATH=$PATH:$NGINX_HOME/sbin

EXPOSE 80

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
