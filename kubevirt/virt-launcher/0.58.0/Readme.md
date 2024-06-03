源码中本身依赖的libvirt是8.0.0版本，从kubevirt/WORKSPACE中查看，但目前没有8版本，故从anolis中下载9.10.0版本
由于openeuler 22.03中没有coreutils-single，libcroco，libcurl-minimal，libssh-config，qemu-kvm-common， qemu-kvm-core, glibc-minimal-langpack 故目前在packages.txt中删除这些包
