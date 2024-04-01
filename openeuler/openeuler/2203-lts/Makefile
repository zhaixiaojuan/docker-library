REGISTRY        ?=lcr.loongnix.cn
ORGANIZATION    ?=openeuler
REPOSITORY      ?=openeuler
TAG             ?=22.03-LTS
LATEST          ?=true
ARCH?=loongarch64

IMAGE=$(REGISTRY)/$(ORGANIZATION)/$(REPOSITORY):$(TAG)
LATEST_IMAGE=$(REGISTRY)/$(ORGANIZATION)/$(REPOSITORY):latest

default: image

rootfs:
	bash mkimage-rootfs.sh
image: clear rootfs
	docker build  \
		--build-arg TARGETARCH=$(ARCH) \
		--build-arg TAG=$(TAG) \
		-t lcr.loongnix.cn/$(ORGANIZATION)/$(REPOSITORY):$(TAG) .

push:
	docker push $(IMAGE)
	@if [ "$(LATEST) = true "] ; \
		then \
		docker tag $(IMAGE) $(LATEST_IMAGE)
		docker push $(LATEST_IMAGE)
	fi;

clear:
	rm -rf  openEuler*
