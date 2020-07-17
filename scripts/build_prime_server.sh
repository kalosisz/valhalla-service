#!/usr/bin/env bash
set -e

NPROC=$(nproc)

REPO="https://github.com/kevinkreiser/prime_server.git"
git clone --branch ${PRIMESERVER_RELEASE} ${REPO}
cd prime_server
git submodule update --init --recursive

./autogen.sh
./configure --prefix=/usr LIBS="-lpthread"
make -j"${NPROC}" all
make -k -j"${NPROC}" test
make install

rm -rf /valhalla/prime_server /tmp/* /var/tmp/*
