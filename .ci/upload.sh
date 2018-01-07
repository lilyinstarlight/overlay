#!/bin/bash -e
source "$(readlink -f "$(dirname $0)")"/common.sh

# install AWS CLI and upload to remote
echo "travis_fold:start:system.upload"
set -x
pip install awscli
aws s3 sync "$root" "$sync" --exclude 'dev/*' --exclude 'sys/*' --exclude 'proc/*' --exclude 'run/shm/*'
{ set +x; } 2>/dev/null
echo "travis_fold:end:system.upload"
