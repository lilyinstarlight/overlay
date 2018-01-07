#!/bin/bash -e
source "$(readlink -f "$(dirname $0)")"/common.sh

# install AWS CLI and sync with remote
echo "travis_fold:start:system.sync"
set -x
prep

pip install awscli
aws s3 sync "$sync" "$root" --exclude "$root"/dev --exclude "$root"/sys --exclude "$root"/proc --exclude "$root"/run/shm
{ set +x; } 2>/dev/null
echo "travis_fold:end:system.sync"
