#!/bin/bash
# This script is used to generate a vanilla CentOS 7 latest base image
# Note: This script must be executed in a CentOS 7 host, no matter where it is running.

TINI_VERSION="0.18.0"

export centos_root='/centos_image/rootfs'
rm -rf $centos_root
mkdir -p $centos_root
rpm --root $centos_root --initdb
yum -y --releasever=7 --installroot=$centos_root --setopt=tsflags='nodocs' install yum
sed -i "/distroverpkg=centos-release/a tsflags=nodocs" $centos_root/etc/yum.conf
echo "clean_requirements_on_remove=1" >> $centos_root/etc/yum.conf
cp /etc/resolv.conf $centos_root/etc

# Bind mount proc, sys and dev fs as required by Centos 7.5+
mount -t proc proc $centos_root/proc/
mount -t sysfs sys $centos_root/sys/
mount -o bind /dev $centos_root/dev/

chroot $centos_root /bin/bash <<EOF
yum -y install yum-plugin-ovl https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}-amd64.rpm
yum clean all
rm -rf /boot
rm -rf /etc/firewalld
rm -rf /var/cache/yum/x86_64
rm -f /tmp/ks-script*
rm -rf /var/log/anaconda
rm -rf /tmp/ks-script*
rm -rf /etc/sysconfig/network-scripts/ifcfg-*
rm -rf /etc/udev/hwdb.bin
rm -rf /usr/lib/udev/hwdb.d/*
:> /etc/machine-id
rm -f /var/run/nologin
/bin/date +%Y%m%d_%H%M > /etc/BUILDTIME
EOF
rm -f $centos_root/etc/resolv.conf

# Unmount the bind mounted temp directories
umount $centos_root/proc/ $centos_root/sys/ $centos_root/dev/

tar -cf centos-7-docker.tar -C $centos_root .
docker import centos-7-docker.tar danlsgiga/centos:7
docker tag danlsgiga/centos:7 danlsgiga/centos:7.5
docker tag danlsgiga/centos:7 danlsgiga/centos:latest