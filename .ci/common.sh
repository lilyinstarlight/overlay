mirror="https://mirrors.kernel.org/gentoo"
overlay="$(pwd)"
name="$(cat "$overlay/profiles/repo_name")"
root="$1"
profile="default/linux/amd64/17.0"
packages="$PACKAGES"

sync="s3://fkmclane-build/gentoo"
id="$TRAVIS_COMMIT"

export PS4="$ "

strap() {
	set -x
	mkdir -p "$1"
	curl "$2"/releases/amd64/autobuilds/latest-stage4-amd64-minimal.txt | sed -e '1 d' -e '2 d' -e '3 s/\(.*\) .*/\1/' | xargs -I '{}' curl -s "$2"/releases/amd64/autobuilds/'{}' | tar -C "$1" -xj
	{ set +x; } 2>/dev/null
}

run() {
	chroot "$1" /bin/env - /bin/bash -c "source /etc/profile && export PS4=\"$PS4\" && set -x && ${*:2}"
}

prep() {
	set -x
	mkdir -p "$1"
	mount --bind "$1" "$1"
	mkdir -p "$1"/proc
	mount -t proc none "$1"/proc
	mkdir -p "$1"/sys
	mount --bind /sys "$1"/sys
	mount --make-rslave "$1"/sys
	mkdir -p "$1"/dev
	mount --bind /dev "$1"/dev
	mount --make-rslave "$1"/dev
	mkdir -p "$1"/dev/pts
	mount --bind /dev/pts "$1"/dev/pts
	mount --make-rslave "$1"/dev/pts
	mkdir -p "$1"/run/shm
	mount --bind /run/shm "$1"/run/shm
	mount --make-rslave "$1"/run/shm
	{ set +x; } 2>/dev/null

	df -h

	run "$1" emerge-webrsync
}
