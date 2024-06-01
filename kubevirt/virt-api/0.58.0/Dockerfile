FROM lcr.loongnix.cn/kubevirt/passwd:server

LABEL maintainer="zhaixiaojuan@loongson.cn"

COPY .version /.version

COPY virt-api /usr/bin/

USER 1001

ENTRYPOINT ["/usr/bin/virt-api"]


