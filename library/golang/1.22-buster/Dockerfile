FROM lcr.loongnix.cn/library/debian:sid

# install cgo-related dependencies
RUN set -eux; \
        apt-get update; \
        apt-get install -y --no-install-recommends \
                g++ \
                gcc \
                libc6-dev \
                make \
                wget \
                pkg-config \
        ; \
        apt-get autoclean all; \
        rm -rf /var/lib/apt/lists/*

ENV PATH /usr/local/go/bin:$PATH

ENV GOLANG_VERSION 1.22.4

RUN set -eux; \
        url='http://ftp.loongnix.cn/toolchain/golang/go-1.22/abi2.0/go1.22.4.linux-loong64.tar.gz'; \
	sha256='5912a81cdaf3109f68e2d76e2db19378bd48ff60acd86c9c04becd0d48556aba'; \
	wget -O go.tgz "$url" --progress=dot:giga; \
	echo "$sha256 *go.tgz" | sha256sum -c -; \
	tar -C /usr/local -xzf go.tgz; \
	rm go.tgz; \
	go version

ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

