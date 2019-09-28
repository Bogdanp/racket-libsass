#!/usr/bin/env bash

set -euxo pipefail

git submodule update --init
pushd libsass
autoreconf --force --install
./configure \
    --disable-static \
    --prefix="$(pwd)/../artifacts/linux-x86-64"
make clean
make -j 4
make -j 4 install
popd
