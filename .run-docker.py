#!/usr/bin/env python

import os
import sys

if len(sys.argv) != 2:
    sys.exit("Usage: python {} osname".format(sys.argv[0]))

docker = sys.argv[1]
osname, release = docker.split(':')

if osname == 'centos':
    cmds = "yum -y install sudo"
    if release == '7':
        cmds += "\nsed -i -e 's/Defaults    requiretty.*/ #Defaults    requiretty/g' /etc/sudoers"
elif osname == 'ubuntu':
    if release == '14.04':
        cmds = "apt-get update\n apt-get install -y software-properties-common sudo"
    else:
        cmds = "apt-get update\n apt-get install -y lsb-release sudo"
elif osname == 'fedora':
    cmds = "dnf install -y sudo"
elif osname == 'debian':
    cmds = "apt-get update\napt-get install -y sudo"

os.system("bash .docker.sh {} {} '{}'".format(osname, docker, cmds))
