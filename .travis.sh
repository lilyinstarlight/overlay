#!/bin/bash -e
mirror="https://mirrors.kernel.org/gentoo"
overlay="$(pwd)"
root="/gentoo"
packages="app-admin/linode-cli:{0,4} app-admin/pass-otp app-misc/{blinkstick,cronic,gotty-bin,tty-clock,wemux} app-shells/elvish app-vim/neovim-remote dev-embedded/{arduino-bin,energia-bin,teensyduino-bin} dev-games/mcedit dev-python/{pandocfilters,slixmpp,twilio,vex} dev-util/ffdec games-action/armagetronad{,-dedicated} games-arcade/nsnake games-misc/{git-fire,lolcat,nyancat,pipes} media-gfx/{main,sk1} media-libs/openvr media-plugins/{calf,gxplugins-lv2,midifilter-lv2,plex-for-kodi,plex-kodi-connect} media-sound/{gxtuner,ympd} media-tv/{airtame-bin,plex-media-player,plex-media-server,plexpy} media-video/{v4l2loopback} net-fs/pingfs net-im/{discord-bin,slack-bin} net-mail/syncmaildir net-p2p/zget net-wireless/{create_ap,unifi} sci-electronics/{eagle,freeroute,fritzing-bin} sci-physics/chipmunk sys-apps/petty sys-fs/{exfat-nofuse,pifs,udiskie} sys-kernel/pf-sources www-servers/pagekite x11-misc/{awf,barline,clipster,lemonbar,rofi-pass,slop} x11-themes/arc-openbox-theme"

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
	{ set +x; } 2>/dev/null

	run "$1" emerge-webrsync
	run "$1" eselect profile set default/linux/amd64/13.0
}

# get root image
echo "travis_fold:start:system_bootstrap"
strap "$root" "$mirror"
echo "travis_fold:end:system_bootstrap"

# prepare
echo "travis_fold:start:system_prepare"
prep "$root"
echo "travis_fold:end:system_prepare"

# prepare
echo "travis_fold:start:portage_configure"
set -x
cat >>"$root"/etc/portage/make.conf <<EOF

ACCEPT_KEYWORDS="~amd64"
FEATURES="test-fail-continue"
EOF
{ set +x; } 2>/dev/null
echo "travis_fold:end:portage_configure"

# move repository to image
echo "travis_fold:start:repository_copy"
set -x
mkdir -p "$root"/usr/local
mv "$overlay" "$root"/usr/local/portage
{ set +x; } 2>/dev/null
echo "travis_fold:end:repository_copy"

# setup repository
echo "travis_fold:start:repository_setup"
set -x
mkdir -p "$root"/etc/portage/repos.conf
cat >"$root"/etc/portage/repos.conf/local.conf <<EOF
[local]
location = /usr/local/portage
auto-sync = no
EOF
{ set +x; } 2>/dev/null
echo "travis_fold:end:repository_setup"

# merge repoman
echo "travis_fold:start:repoman_install"
run "$root" emerge dev-vcs/git app-portage/repoman
echo "travis_fold:end:repoman_install"

# run repoman on codebase
run "$root" cd /usr/local/portage '&&' repoman -v full

# merge repoman
run "$root" emerge $packages
