#!/usr/bin/env bash

set -euo pipefail

test -e artifacts/linux-x86-64 || exit 2
test -e artifacts/macos-x86-64 || exit 3

gpg -q \
    --batch \
    --yes \
    --decrypt \
    --passphrase="$DEPLOY_KEY_PASSPHRASE" \
    -o deploy-key \
    bin/deploy-key.gpg
chmod 0600 deploy-key
trap "rm -f deploy-key" EXIT

version=$(grep version info.rkt | cut -d'"' -f2)
filename="racket-libsass-$version.tar.gz"
mkdir -p dist
tar -cvzf "dist/$filename" artifacts info.rkt main.rkt LICENSE
sha1sum "dist/$filename" | cut -d ' ' -f 1 | tr -d '\n' > "dist/$filename.CHECKSUM"
scp -o StrictHostKeyChecking=no \
    -i "deploy-key" \
    -P "$DEPLOY_PORT" \
    "dist/$filename" \
    "dist/$filename.CHECKSUM" \
    "$DEPLOY_USER@$DEPLOY_HOST":~/www/
