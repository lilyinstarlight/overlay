# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils unpacker

DESCRIPTION="Slack is a messaging app for teams"
HOMEPAGE="https://slack.com/"
SRC_URI="
	x86? (
		https://downloads.slack-edge.com/linux_releases/${P}-i386.deb
	)
	amd64? (
		https://downloads.slack-edge.com/linux_releases/${P}-amd64.deb
	)
"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND="
"
RDEPEND="
	dev-lang/python:2.7
	dev-libs/libappindicator
	dev-libs/libgcrypt:*
	dev-libs/nss
	gnome-base/gconf:2
	gnome-base/gnome-keyring
	gnome-base/gvfs
	gnome-base/libgnome-keyring
	virtual/libudev
	x11-libs/gtk+:2
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/libnotify
	x11-misc/xdg-utils
"

S="${WORKDIR}"

RESTRICT="bindist mirror preserve-libs"
QA_PREBUILT="*"

src_install() {
	# package contents
	dodir /opt/slack-desktop
	cp -R usr/lib/slack/* "${D}"/opt/slack-desktop/

	dosym /opt/slack-desktop/slack usr/bin/slack

	domenu usr/share/applications/slack.desktop
	doicon usr/share/pixmaps/slack.png

	dodoc usr/share/doc/slack/copyright
}
