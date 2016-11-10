#!/bin/bash

sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
sudo apt-get update
sudo apt-get -y install gcc g++ cmake make libc6 ghostscript \
                libglib2.0-dev libnetcdf-dev libgdal-dev python-gdal \
                liblapack3 libpcre3-dev libfftw3-dev curl tar
