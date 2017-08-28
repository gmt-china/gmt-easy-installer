#!/bin/bash

# Basic Information
GMT_VERSION=5.4.2
GSHHG_VERSION=2.3.7
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
7bab16610c12eb054d1e7b1c6ef8b194  gmt-${GMT_VERSION}-src.tar.gz
8ee2653f9daf84d49fefbf990bbfa1e7  gshhg-gmt-${GSHHG_VERSION}.tar.gz
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

# Add enviromental variables to shell startup file
current_shell=$(basename $SHELL)
if [ $current_shell == "bash" ]; then
    startup_file="${HOME}/.bashrc"
elif [ $current_shell == "zsh" ]; then
    startup_file="${HOME}/.zshrc"
else
    startup_file="${HOME}/.bashrc"
fi
echo "Adding GMT related enviromental variables to $startup_file"
echo "    export GMT5HOME=${GMT_INSTALL}"
echo '    export PATH=${GMT5HOME}/bin:$PATH'
echo '    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${GMT5HOME}/lib64'

echo "export GMT5HOME=${GMT_INSTALL}" >> $startup_file
echo 'export PATH=${GMT5HOME}/bin:$PATH' >> $startup_file
echo 'export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${GMT5HOME}/lib64' >> $startup_file
