# Please use "make image" to build the docker image
FROM lcr.loongnix.cn/library/debian:sid

RUN \
    apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates \
      gcc \
      netbase \
    && rm -rf /var/lib/apt/lists/*

RUN set -x \
    && mkdir -p rootfs/lib \
    && set -- \
        /etc/nsswitch.conf \
        /etc/ssl/certs/ca-certificates.crt \
        /usr/share/zoneinfo \
        /etc/services \
        /lib/"$(gcc -print-multiarch)"/libpthread.so.* \
        /etc/group  \
        /etc/passwd \
        /etc/shadow \
    && while [ "$#" -gt 0  ]; do \
        f="$1"; shift; \
        fn="$(basename "$f")"; \
        if [ -e "rootfs/lib/$fn" ]; then continue; fi; \
        if [ "${f#/lib/}" != "$f" ]; then \
            ln -vL "$f" "rootfs/lib/$fn"; \
        else \
            d="$(dirname $f)" \
            && mkdir -p "rootfs/${d#/}" \
            && cp -av "$f" "rootfs/${f#/}"; \
        fi; \
    done

FROM lcr.loongnix.cn/library/busybox:1.32.0

LABEL maintainer="zhaixiaojuan@loongson.cn"

COPY --from=0 /rootfs /
RUN echo "nobody:x:65534:" >> /etc/group
