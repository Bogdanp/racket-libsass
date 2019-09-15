#!/usr/bin/env bash

set -euxo pipefail

git submodule update --init

pushd libsass
autoreconf --force --install
./configure --prefix="$(pwd)/../artifacts/macos-x86-64"
make -j 4
make -j 4 install
popd
