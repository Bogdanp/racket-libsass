#!/usr/bin/env bash

set -euxo pipefail

pushd libsass
git reset --hard HEAD
autoreconf --force --install
./configure --prefix="$(pwd)/../artifacts/linux-x86-64"
make clean
make -j 4
make -j 4 install
popd
