#!/bin/bash
set -o errexit
set -o nounset

MIRROR_ADDRESS="http://ftp.ports.debian.org/debian-ports"
RELEASE="sid"
ROOTFS="rootfs.tar.xz"

OUTPUT=$(cd $(dirname $0);pwd)
cd ${OUTPUT?}

apt update
apt install -y debootstrap xz-utils
# loongnix do not have $RELEASE file, fix it!
if [ ! -f /usr/share/debootstrap/scripts/$RELEASE ]; then
	ln -s /usr/share/debootstrap/scripts/sid /usr/share/debootstrap/scripts/$RELEASE
fi

# create a directory for rootfs
ROOTFSDIR=`mktemp -d`
# install packages
# Package: debain-ports-archive-keyring - fix GPG error
# extra-suites: unreleased - as a complement to sid
debootstrap --no-check-gpg --variant=minbase --components=main --arch=loong64 --extra-suites=unreleased --include=debian-ports-archive-keyring $RELEASE $ROOTFSDIR $MIRROR_ADDRESS
# chroot $ROOTFSDIR debootstrap/debootstrap --second-stage
chroot $ROOTFSDIR rm -rf /tmp/* /var/cache/apt/* /var/lib/apt/lists/*
# package rootfs.tar.gz
tar -cJvf $ROOTFS -C $ROOTFSDIR .

