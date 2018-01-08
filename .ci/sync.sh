#!/bin/bash -e
source "$(readlink -f "$(dirname $0)")"/common.sh

# install AWS CLI and sync with remote
echo "travis_fold:start:system.sync"
set -x
mkdir -p "$root"

pip install awscli
aws s3 cp "$sync"/prefix-"$id".tar.bz2 "$root"/../prefix-"$id".tar.bz2
tar xjpf "$root"/../prefix-"$id".tar.bz2 --xattrs-include='*.*' --numeric-owner --one-file-system -C "$root"

prep "$root"
{ set +x; } 2>/dev/null
echo "travis_fold:end:system.sync"
