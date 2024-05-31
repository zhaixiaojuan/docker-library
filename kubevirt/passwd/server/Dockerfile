FROM lcr.loongnix.cn/openeuler/openeuler:22.03-LTS

LABEL maintainer="zhaixiaojuan@loongson.cn"

RUN groupadd nonroot-user -g 1001 &&\
	useradd nonroot-user -u 1001 -g 1001 &&\
	usermod -s /bin/bash nonroot-user

USER 1001

CMD ["/bin/bash"]
