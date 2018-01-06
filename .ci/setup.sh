#!/bin/bash -e
source "$(readlink -f "$(basename $0)")"/common.sh

# get root image
echo "travis_fold:start:system.bootstrap"
strap "$root" "$mirror"
echo "travis_fold:end:system.bootstrap"

# prepare mounts and portage
echo "travis_fold:start:system.prepare"
prep "$root"
echo "travis_fold:end:system.prepare"

# configure portage
echo "travis_fold:start:portage.configure"
set -x
echo 'USE="-bindist"' >>"$root"/etc/portage/make.conf
echo 'FEATURES="test-fail-continue"' >>"$root"/etc/portage/make.conf
echo 'CONFIG_PROTECT_MASK="/etc/portage"' >>"$root"/etc/portage/make.conf
echo 'EMERGE_DEFAULT_OPTS="--quiet --autounmask-write --with-test-deps=n --noreplace --jobs"' >>"$root"/etc/portage/make.conf
run "$root" eselect profile set "$profile"
{ set +x; } 2>/dev/null
echo "travis_fold:end:portage.configure"

# update portage packages
echo "travis_fold:start:portage.update"
set -x
run "$root" emerge -uDN --newrepo @world
{ set +x; } 2>/dev/null
echo "travis_fold:end:portage.update"

# merge repoman
echo "travis_fold:start:repoman.install"
set -x
run "$root" emerge dev-vcs/git app-portage/repoman
{ set +x; } 2>/dev/null
echo "travis_fold:end:repoman.install"

# move repository to image
echo "travis_fold:start:repository.copy"
set -x
mkdir -p "$root"/usr/local
mv "$overlay" "$root"/usr/local/portage
{ set +x; } 2>/dev/null
echo "travis_fold:end:repository.copy"

# setup repository
echo "travis_fold:start:repository.setup"
set -x
mkdir -p "$root"/etc/portage/repos.conf
echo "[$name]" >"$root"/etc/portage/repos.conf/"$name".conf
echo 'location = /usr/local/portage' >>"$root"/etc/portage/repos.conf/"$name".conf
echo 'auto-sync = no' >>"$root"/etc/portage/repos.conf/"$name".conf
{ set +x; } 2>/dev/null
echo "travis_fold:end:repository.setup"
