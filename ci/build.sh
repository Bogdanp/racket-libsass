#!/usr/bin/env bash

set -euo pipefail

basedir=$(dirname "$0")

case "$1" in
    "macOS-10.14")
        bash "$basedir/build-macos-x86-64.sh";
        ;;
    "ubuntu-18.04")
        bash "$basedir/build-linux-x86-64.sh";
        ;;
    *)
        echo "error: invalid os '$1'"
        exit 1
        ;;
esac
