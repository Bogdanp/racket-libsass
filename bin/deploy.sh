#!/usr/bin/env bash

set -euo pipefail

log() {
    printf "[%s] %s\n" "$(date)" "$@"
}

log "Ensuring artifact folders are present..."
test -e artifacts/linux-x86-64 || exit 2
test -e artifacts/macos-x86-64 || exit 3

log "Copying artifacts into their respective packages..."
cp artifacts/linux-x86-64/lib/libsass.so.1.0.0 libsass-x86_64-linux/libsass.so
cp artifacts/macos-x86-64/lib/libsass.1.dylib libsass-x86_64-macosx/libsass.dylib
cp artifacts/win32-i386/libsass.dll libsass-i386-win32/libsass.dll
cp artifacts/win32-x86-64/libsass.dll libsass-x86_64-win32/libsass.dll

log "Decrypting deploy key..."
gpg -q \
    --batch \
    --yes \
    --decrypt \
    --passphrase="$DEPLOY_KEY_PASSPHRASE" \
    -o deploy-key \
    bin/deploy-key.gpg
chmod 0600 deploy-key
trap "rm -f deploy-key" EXIT

log "Building packages..."
for package in "libsass-x86_64-linux" "libsass-x86_64-macosx" "libsass-i386-win32" "libsass-x86_64-win32"; do
    log "Building '$package'..."
    pushd "$package"

    version=$(grep version info.rkt | cut -d'"' -f2)
    filename="$package-$version.tar.gz"
    mkdir -p dist
    tar -cvzf "dist/$filename" LICENSE info.rkt libsass.*
    sha1sum "dist/$filename" | cut -d ' ' -f 1 | tr -d '\n' > "dist/$filename.CHECKSUM"
    scp -o StrictHostKeyChecking=no \
        -i ../deploy-key \
        -P "$DEPLOY_PORT" \
        "dist/$filename" \
        "dist/$filename.CHECKSUM" \
        "$DEPLOY_USER@$DEPLOY_HOST":~/www/

    popd
done
