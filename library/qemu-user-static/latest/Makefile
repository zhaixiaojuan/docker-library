.DEFAULT_GOAL := docker-build-loongarch64
.PHONY: all
.PHONY: docker-build-all docker-push-all docker-manifest-rm

REGISTRY?=lcr.loongnix.cn/library/qemu-user-static
TAG?=latest
DOCKERFILE?=Dockerfile.common
URL?=wget https://github.com/Loongson-Cloud-Community/qemu-user-static/releases/download/abi2.0/qemu-static-8.2.0-rc2.tar.gz
all: docker-build-all

define docker-build

.PHONY: docker-build-list-$(1)

docker-build-list += docker-build-$(1)

ifeq ($(1),loongarch64)
	DOCKERFILE=Dockerfile
endif

download:
	wget -O qemu-static.tar.gz $(URL) && tar xf qemu-static.tar.gz --strip-components=1

docker-build-$(1): download
	docker buildx build . -f $(DOCKERFILE) \
		--platform linux/$(1) \
		--build-arg BASE_IMAGE=$(2) \
		--build-arg TARGETARCH=$(1) \
		-t $(REGISTRY):$(TAG)-$(1) \
		-t $(REGISTRY):latest-$(1)

.PHONY: docker-push-$(1)
docker-push-list += docker-push-$(1)
docker-push-$(1): docker-manifest-rm
	docker push $(REGISTRY):$(TAG)-$(1)

tag-list += $(REGISTRY):$(TAG)-$(1)

endef

$(eval $(call docker-build,x86_64,debian:latest))
#$(eval $(call docker-build,loongarch64,lcr.loongnix.cn/library/debian:sid))
$(eval $(call docker-build,loongarch64,yangzewei2023/debian:sid))

docker-build-all: $(docker-build-list)
docker-push-all: $(docker-push-list)
	-docker manifest rm $(REGISTRY):$(TAG)
	-docker manifest rm $(REGISTRY):latest
	docker manifest create $(REGISTRY):$(TAG) $(tag-list)
	docker manifest push $(REGISTRY):$(TAG)
	docker manifest create $(REGISTRY):latest $(tag-list)
	docker manifest push $(REGISTRY):latest
