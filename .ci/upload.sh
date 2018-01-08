#!/bin/bash -e
source "$(readlink -f "$(dirname $0)")"/common.sh

# install AWS CLI and upload to remote
echo "travis_fold:start:system.upload"
set -x
pip install awscli
tar cjpf "$root"/../prefix-"$id".tar.bz2 --xattrs-include='*.*' --numeric-owner --one-file-system "$root/*"
aws s3 cp "$root"/../prefix-"$id".tar.bz2 "$sync"/prefix-"$id".tar.bz2
{ set +x; } 2>/dev/null
echo "travis_fold:end:system.upload"
