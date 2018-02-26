#!/bin/bash -e
source "$(readlink -f "$(dirname $0)")"/common.sh

# install AWS CLI and upload to remote
echo "travis_fold:start:system.upload"
set -x
pip install awscli
tar cjpf "$root"/../prefix-"$id".tar.bz2 --xattrs-include='*.*' --numeric-owner --one-file-system -C "$root" $(find "$root" -maxdepth 1 -type d -not -wholename "$root" -not -name dev -not -name sys -not -name proc -not -name tmp -not -name run -not -name boot -printf '%f ')
aws s3 cp "$root"/../prefix-"$id".tar.bz2 "$sync"/prefix-"$id".tar.bz2
{ set +x; } 2>/dev/null
echo "travis_fold:end:system.upload"
