#!/bin/bash
sudo yum install -y epel-release
sudo yum install -y gcc gcc-c++ cmake make glibc ghostscript netcdf-devel \
                    glib2-devel gdal-devel gdal-python lapack-devel \
                    pcre-devel fftw-devel wget zlib-devel

echo "######################################################################"
echo "# WARNING: Modify GMT_USE_THREADS to FALSE in gmt-5.2.1-installer.sh #"
echo "######################################################################"
