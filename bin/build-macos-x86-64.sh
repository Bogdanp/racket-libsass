#!/usr/bin/env bash

set -euxo pipefail

pushd libsass
git reset --hard HEAD
autoreconf --force --install
./configure \
    --disable-static \
    --prefix="$(pwd)/../artifacts/macos-x86-64"
make clean
make -j 4
make -j 4 install
popd
