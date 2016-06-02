#!/bin/bash
sudo yum install -y epel-release
sudo yum install -y gcc gcc-c++ cmake make glibc ghostscript netcdf-devel \
                    glib2-devel gdal-devel gdal-python lapack-devel \
                    pcre-devel fftw-devel wget zlib-devel

if [ -e GMT-*-installer.sh ]; then
    sed -i 's/(GMT_USE_THREADS TRUE)/(GMT_USE_THREADS FALSE)/' GMT-*-installer.sh
else
    echo "######################################################################"
    echo "# WARNING: Modify GMT_USE_THREADS to FALSE in GMT-*-installer.sh     #"
    echo "######################################################################"
fi
