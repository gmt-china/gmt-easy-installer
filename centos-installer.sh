#!/bin/bash
sudo yum install -y epel-release redhat-lsb-core
sudo yum install -y gcc gcc-c++ cmake make glibc ghostscript netcdf-devel \
                    glib2-devel gdal-devel gdal-python lapack-devel \
                    pcre-devel fftw-devel zlib-devel curl tar

release=`lsb_release -r | cut -f2 | cut -c1`
if [ $release = '6' ]; then
    if [ -e GMT-*-installer.sh ]; then
        sed -i 's/(GMT_USE_THREADS TRUE)/(GMT_USE_THREADS FALSE)/' GMT-*-installer.sh
    else
        echo "######################################################################"
        echo "# WARNING: Modify GMT_USE_THREADS to FALSE in GMT-*-installer.sh     #"
        echo "######################################################################"
    fi
elif [ $release = '7' ]; then
    sudo yum install -y lapack64-devel
fi
