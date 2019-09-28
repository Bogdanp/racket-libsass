#!/usr/bin/env bash

set -euxo pipefail

git submodule update --init
brew install automake libtool
pushd libsass
autoreconf --force --install
./configure \
    --disable-static \
    --prefix="$(pwd)/../artifacts/macos-x86-64"
make clean
make -j 4
make -j 4 install
popd
