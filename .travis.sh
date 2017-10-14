#!/bin/bash -e
mirror="https://mirrors.kernel.org/gentoo"
overlay="$(pwd)"
root="/gentoo"

strap() {
	mkdir -p "$1"
	curl -s "$2"/releases/amd64/autobuilds/latest-stage4-amd64-minimal.txt | sed -e '1 d' -e '2 d' -e '3 s/\(.*\) .*/\1/' | xargs -I '{}' curl -s "$2"/releases/amd64/autobuilds/'{}' | tar -C "$1" -xj
}

run() {
	chroot "$1" /bin/bash -c "source /etc/profile && ${@:2}"
}

prep() {
	mount --bind "$1" "$1"
	mount -t proc none "$1"/proc
	mount --bind /sys "$1"/sys
	mount --make-rslave "$1"/sys
	mount --bind /dev "$1"/dev
	mount --make-rslave "$1"/dev

	run "$1" emerge-webrsync
	run "$1" eselect profile set default/linux/amd64/13.0
}

# get root image
strap "$root" "$mirror"

# prepare
prep "$root"

# move repository to image
cd "$root"/root
mv "$overlay" "$root"/root/overlay

# merge repoman
run "$root" emerge repoman

# run repoman on codebase
exec run "$root" repoman scan /root/overlay
