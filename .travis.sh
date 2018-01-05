#!/bin/bash -e
mirror="https://mirrors.kernel.org/gentoo"
overlay="$(pwd)"
name="$(cat "$overlay/profiles/repo_name")"
root="/gentoo"
profile="default/linux/amd64/13.0"
packages="$PACKAGES"

export PS4="$ "

strap() {
	set -x
	mkdir -p "$1"
	curl "$2"/releases/amd64/autobuilds/latest-stage4-amd64-minimal.txt | sed -e '1 d' -e '2 d' -e '3 s/\(.*\) .*/\1/' | xargs -I '{}' curl -s "$2"/releases/amd64/autobuilds/'{}' | tar -C "$1" -xj
	{ set +x; } 2>/dev/null
}

run() {
	chroot "$1" /usr/bin/env - /bin/bash -c "source /etc/profile && export PS4=\"$PS4\" && set -x && ${*:2}"
}

prep() {
	set -x
	mount --bind "$1" "$1"
	mount -t proc none "$1"/proc
	mount --bind /sys "$1"/sys
	mount --make-rslave "$1"/sys
	mount --bind /dev "$1"/dev
	mount --make-rslave "$1"/dev
	mkdir -p "$1"/run/shm
	mount --bind /run/shm "$1"/run/shm
	mount --make-rslave "$1"/run/shm
	mount
	{ set +x; } 2>/dev/null

	run "$1" emerge-webrsync
}

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

# run repoman on codebase
run "$root" cd /usr/local/portage '&&' repoman -v full

# retry up to four times as necessary for rerunning after writing autounmask changes
run "$root" emerge $packages || run "$root" emerge $packages || run "$root" emerge $packages || run "$root" emerge $packages || run "$root" emerge $packages
