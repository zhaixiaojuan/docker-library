FROM lcr.loongnix.cn/library/alpine:3.19

RUN apk --no-cache upgrade
RUN apk add --no-cache ca-certificates gcc musl-dev bash wget

ENV PATH /usr/local/go/bin:$PATH
ENV GOLANG_VERSION 1.21.11

RUN set -eux; \
	url='http://ftp.loongnix.cn/toolchain/golang/go-1.21/abi2.0/go1.21.11.linux-loong64.tar.gz'; \
	sha256='687ac8a0cd69923422489e0985c53edac6b0e30e789f61f3cd66624d05185827'; \
	wget -O go.tgz "$url" --progress=dot:giga; \
	echo "$sha256 *go.tgz" | sha256sum -c -; \
	tar -C /usr/local -xzf go.tgz; \
	rm go.tgz; \
	go version

ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH
