# This file is generated by the template.

REGISTRY?=lcr.loongnix.cn
ORGANIZATION?=library
REPOSITORY?=rabbitmq
TAG?=3.9.22

IMAGE=$(REGISTRY)/$(ORGANIZATION)/$(REPOSITORY):$(TAG)


default: image

image:
	docker build \
		--build-arg https_proxy=$(https_proxy) \
		--build-arg http_proxy=$(http_proxy) \
		-t $(IMAGE) \
		.

push:
	docker push $(IMAGE)
