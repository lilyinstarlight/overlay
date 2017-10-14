#!/bin/bash -e
mirror="https://mirrors.kernel.org/gentoo"
overlay="$(pwd)"
root="/gentoo"
repoman=""

# prepare
apt-get update
apt-get install -y curl

# get root image
mkdir "$root"
curl -s "$mirror"/releases/amd64/autobuilds/latest-stage4-amd64-minimal.txt | sed -e '1 d' -e '2 d' -e '3 s/\(.*\) .*/\1/' | xargs -I '{}' curl -s "$mirror"/releases/amd64/autobuilds/'{}' | tar -C "$root" -xj

# move repository to image
cd "$root"/root
mv "$overlay" "$root"/root/overlay

# mount everything
sudo mount --bind "$root" "$root"
sudo mount -t proc none "$root"/proc
sudo mount --bind /sys "$root"/sys
sudo mount --make-rslave "$root"/sys
sudo mount --bind /dev "$root"/dev
sudo mount --make-rslave "$root"/dev

# merge repoman
chroot "$root" /bin/bash -c "emerge repoman"

# run repoman on codebase
exec chroot "$root" /bin/bash -c "repoman scan /root/overlay"
