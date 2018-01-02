#!/bin/sh
GMT_version=5.4.3
BASE_dir=/gmt-easy-installer
GMT_installer=GMT-installer.sh

OS_installer=$1-installer.sh
DOCKER=$2
CMDS=$3

sudo docker run --rm=true --privileged=true -v `pwd`:${BASE_dir}:rw ${DOCKER} /bin/bash -c "
        ${CMDS}
        cd ${BASE_dir}/
        bash ${OS_installer}
        bash ${GMT_installer}
        /opt/GMT-${GMT_version}/bin/gmt --version
"
