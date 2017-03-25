#!/bin/sh
GMT_version=5.3.3
OS=$1

if [[ $# -eq 0 ]] ; then
    echo 'bash test.sh OSname'
    exit 1
fi

BASE_dir=/gmt-easy-installer
GMT_installer=GMT-${GMT_version}-installer.sh
OS_installer=${OS}-installer.sh

if [ "$OS" = "CentOS-6.7" ]; then
    DOCKER="centos:centos6.7"
    more_cmd="yum -y install sudo"
elif [ "$OS" = "CentOS-7.2" ]; then
    DOCKER="centos:centos7.2.1511"
    more_cmd="yum -y install sudo
              sed -i -e 's/Defaults    requiretty.*/ #Defaults    requiretty/g' /etc/sudoers"
elif [ "$OS" = "Ubuntu-14.04.4" ]; then
    DOCKER="ubuntu:14.04.4"
    more_cmd="apt-get update
              apt-get install -y software-properties-common sudo "
elif [ "$OS" = "Ubuntu-15.10" ]; then
    DOCKER="ubuntu:15.10"
    more_cmd="apt-get update
              apt-get install -y lsb-release sudo"
elif [ "$OS" = "Ubuntu-16.04" ]; then
    DOCKER="ubuntu:16.04"
    more_cmd="apt-get update
              apt-get install -y lsb-release sudo"
elif [ "$OS" = "Fedora-22" ]; then
    DOCKER="fedora:22"
    more_cmd="dnf install -y sudo"
elif [ "$OS" = "Fedora-23" ]; then
    DOCKER="fedora:23"
    more_cmd="dnf install -y sudo"
elif [ "$OS" = "Debian-7.10" ]; then
    DOCKER="debian:7.10"
    more_cmd="apt-get update
              apt-get install -y sudo"
elif [ "$OS" = "Debian-8.4" ]; then
    DOCKER="debian:8.4"
    more_cmd="apt-get update
              apt-get install -y sudo"
fi

sudo docker run --rm=true --privileged=true -v `pwd`:${BASE_dir}:rw ${DOCKER} /bin/bash -c "
        ${more_cmd}
        cd ${BASE_dir}/
        bash ${OS_installer}
        bash ${GMT_installer}
        /opt/GMT-${GMT_version}/bin/gmt --version
"
