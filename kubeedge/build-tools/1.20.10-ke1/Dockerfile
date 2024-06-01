# As a basic image for building various components of KubeEdge
FROM lcr.loongnix.cn/library/debian:sid
ARG ARCH=loong64
RUN apt-get update && apt-get install -y wget \
    vim git make gcc upx-ucl 

RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget -q -c http://ftp.loongnix.cn/toolchain/golang/go-1.20/abi2.0/go1.20.12.linux-loong64.tar.gz -O - | tar -xz -C /usr/local;

ENV GO111MODULE=on
ENV GOPROXY=https://goproxy.cn,direct
ENV GOROOT=/usr/local/go
ENV GOPATH=/go
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin
