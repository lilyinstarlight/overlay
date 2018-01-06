#!/bin/bash -e
source "$(readlink -f "$(dirname $0)")"/common.sh
set -x

# retry up to four times as necessary for rerunning after writing autounmask changes
run "$root" emerge $packages || run "$root" emerge $packages || run "$root" emerge $packages || run "$root" emerge $packages || run "$root" emerge $packages
