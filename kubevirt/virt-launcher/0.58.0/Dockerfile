FROM lcr.loongnix.cn/openeuler/openeuler:22.03-LTS

LABEL maintainer="zhaixiaojuan@loongson.cn"

COPY .version \
     install_rpm.sh \
     packages.txt \
     /

COPY nsswitch.conf /etc/

COPY libvirtd.conf \
        qemu.conf \
        /etc/libvirt/

COPY node-labeller/node-labeller.sh \
        virt-launcher \
        container-disk \
        virt-freezer \
	virt-launcher-monitor \
        virt-probe \
        /usr/bin/
RUN ./install_rpm.sh; \
    rm -rf install_rpm.sh packages.txt

RUN mkdir /usr/lib64/qemu-kvm

COPY libvirt-9.10.0-rpm /libvirt-9.10.0-rpm

RUN rpm -ivh --nodeps /libvirt-9.10.0-rpm/* &&\
    rm -rf /libvirt-9.10.0-rpm; \
    yum install -y libvirt-devel;

RUN setcap CAP_NET_BIND_SERVICE=+eip "/usr/libexec/qemu-kvm" &&\
#    ln -s /usr/sbin/iptables /usr/sbin/iptables-legacy &&\
    rm -f /usr/bin/nc &&\
    ln -s /usr/bin/ncat /usr/bin/nc &&\
    ln -s /run /var/run

COPY passwd /etc/

RUN setcap CAP_NET_BIND_SERVICE=+eip "/usr/bin/virt-launcher"

ENTRYPOINT ["/usr/bin/virt-launcher"]
