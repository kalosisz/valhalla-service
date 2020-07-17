#!/usr/bin/env bash
set -e

NPROC=$(nproc)

REPO="https://github.com/valhalla/valhalla.git"
git clone --branch ${VALHALLA_RELEASE} ${REPO} valhalla_git
cd valhalla_git
git submodule update --init --recursive

mkdir build && cd build
cmake .. \
  -DCMAKE_C_FLAGS:STRING="${CFLAGS}" \
  -DCMAKE_CXX_FLAGS:STRING="${CXXFLAGS}" \
  -DCMAKE_EXE_LINKER_FLAGS:STRING="${LDFLAGS}" \
  -DCMAKE_INSTALL_LIBDIR=lib \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=/usr \
  -DCMAKE_BUILD_TYPE=Release \
  -DENABLE_DATA_TOOLS=On \
  -DENABLE_PYTHON_BINDINGS=Off \
  -DENABLE_NODE_BINDINGS=Off \
  -DENABLE_SERVICES=On \
  -DENABLE_HTTP=On

make -j"${NPROC}"
make -j"${NPROC}" check
make install

cp -r /valhalla/valhalla_git/scripts/* ${SCRIPTS_DIR}

rm -rf /valhalla/valhalla_git /tmp/* /var/tmp/*

chmod +x ${SCRIPTS_DIR}/entrypoint.sh
