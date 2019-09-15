#!/usr/bin/env bash

set -euo pipefail

version=$(grep version info.rkt | cut -d'"' -f2)
filename="racket-libsass-$version.tar.gz"
mkdir -p dist
tar -cvzf "dist/$filename" artifacts info.rkt main.rkt LICENSE
sha1sum "dist/$filename" | cut -d ' ' -f 1 | tr -d '\n' > "dist/$filename.CHECKSUM"
scp "dist/$filename" "dist/$filename.CHECKSUM" defn_racket:~/www/
