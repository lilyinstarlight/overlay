#!/bin/bash -e
source "$(readlink -f "$(dirname $0)")"/common.sh

echo "travis_fold:start:system.sync"
set -x
[ -e "$root"/dev ] || prep
pip install awscli
aws s3 sync "$sync" "$root" --exclude /dev --exclude /sys --exclude /proc --exclude /run/shm
{ set +x; } 2>/dev/null
echo "travis_fold:end:system.sync"
