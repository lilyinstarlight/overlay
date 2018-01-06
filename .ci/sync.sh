#!/bin/bash -e
source "$(readlink -f "$(dirname $0)")"/common.sh
set -x

[ -e "$root"/dev ] || prep

pip install awscli
aws s3 sync "$sync" "$root" --exclude /dev --exclude /sys --exclude /proc --exclude /run/shm
