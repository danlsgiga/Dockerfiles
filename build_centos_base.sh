#!/bin/bash

export centos_root='/centos_image/rootfs'
rm -rf $centos_root
mkdir -p $centos_root
rpm --root $centos_root --initdb
yum reinstall --downloadonly --downloaddir . centos-release
rpm --root $centos_root -ivh centos-release*.rpm
rpm --root $centos_root --import  $centos_root/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
yum -y --installroot=$centos_root --setopt=tsflags='nodocs' --setopt=override_install_langs=en_US.utf8 install yum
sed -i "/distroverpkg=centos-release/a override_install_langs=en_US.utf8\ntsflags=nodocs" $centos_root/etc/yum.conf
cp /etc/resolv.conf $centos_root/etc
chroot $centos_root /bin/bash <<EOF
yum -y install yum-plugin-ovl
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
tar -C $centos_root -c . | docker import - danlsgiga/centos
