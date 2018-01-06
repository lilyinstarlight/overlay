#!/bin/bash -e
source "$(readlink -f "$(dirname $0)")"/common.sh
set -x

# run repoman on codebase
run "$root" cd /usr/local/portage '&&' repoman -v full
