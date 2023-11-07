FROM lcr.loongnix.cn/library/alpine:v3.18-base

RUN apk add --no-cache ca-certificates

RUN set -eux;\
	version='2.8.0'; \
	apkArch="$(apk --print-arch)"; 
COPY registry /bin/
COPY ./config-example.yml /etc/docker/registry/config.yml

VOLUME ["/var/lib/registry"]
EXPOSE 5000

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/etc/docker/registry/config.yml"]
