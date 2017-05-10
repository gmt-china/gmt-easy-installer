#!/bin/bash

# Basic Information
GMT_VERSION=5.4.1
GSHHG_VERSION=2.3.6
DCW_VERSION=1.1.2
GMT_INSTALL=/opt/GMT-${GMT_VERSION}
#GMT_MIRROR=ftp://ftp.soest.hawaii.edu/gmt
GMT_MIRROR=http://mirrors.ustc.edu.cn/gmt/
CURL_OPTIONS="-C - -O --fail -#"

# download files
echo "Downloading gmt-${GMT_VERSION}-src.tar.gz:"
if ! curl ${CURL_OPTIONS} ${GMT_MIRROR}/gmt-${GMT_VERSION}-src.tar.gz; then
    curl ${CURL_OPTIONS} ${GMT_MIRROR}/legacy/gmt-${GMT_VERSION}-src.tar.gz
fi
echo "Downloading gshhg-gmt-${GSHHG_VERSION}.tar.gz:"
if ! curl ${CURL_OPTIONS} ${GMT_MIRROR}/gshhg-gmt-${GSHHG_VERSION}.tar.gz; then
    curl ${CURL_OPTIONS} ${GMT_MIRROR}/legacy/gshhg-gmt-${GSHHG_VERSION}.tar.gz
fi
echo "Downloading dcw-gmt-${DCW_VERSION}.tar.gz:"
if ! curl ${CURL_OPTIONS} ${GMT_MIRROR}/dcw-gmt-${DCW_VERSION}.tar.gz; then
    curl ${CURL_OPTIONS} ${GMT_MIRROR}/legacy/dcw-gmt-${DCW_VERSION}.tar.gz
fi

# write md5sum value to file
cat << EOF > md5sums.md5
45c99d30026742dbc0b1644ea64f496d  dcw-gmt-${DCW_VERSION}.tar.gz
e143577396937809ff845f50bd3b0094  gmt-${GMT_VERSION}-src.tar.gz
108fd757939d3e5f8eaf385e185d6d14  gshhg-gmt-${GSHHG_VERSION}.tar.gz
EOF

# Verify the integrity of files
if ! md5sum --status -c md5sums.md5; then
    echo "#############################################################"
    echo "# Error in downloading files!                               #"
    echo "#############################################################"
    exit
fi

# Not start to install
tar -xf gmt-${GMT_VERSION}-src.tar.gz
tar -xf gshhg-gmt-${GSHHG_VERSION}.tar.gz
tar -xf dcw-gmt-${DCW_VERSION}.tar.gz

mv gshhg-gmt-${GSHHG_VERSION} gmt-${GMT_VERSION}/share/gshhg
mv dcw-gmt-${DCW_VERSION} gmt-${GMT_VERSION}/share/dcw-gmt

cd gmt-${GMT_VERSION}

cat > cmake/ConfigUser.cmake << EOF
set (CMAKE_INSTALL_PREFIX "${GMT_INSTALL}")
set (GMT_INSTALL_MODULE_LINKS FALSE)
set (COPY_GSHHG TRUE)
set (COPY_DCW TRUE)
set (GMT_USE_THREADS TRUE)
EOF

mkdir build
cd build
cmake ..
make
sudo make install
cd ../..

# Configuration
echo "export GMT5HOME=${GMT_INSTALL}" >> ~/.bashrc
echo 'export PATH=${GMT5HOME}/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${GMT5HOME}/lib64' >> ~/.bashrc
