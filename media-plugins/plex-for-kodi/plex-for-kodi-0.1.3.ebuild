# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Plex's official Plex add-on for Kodi."
HOMEPAGE="http://plex.tv/"
MY_PN="script.plex"
SRC_URI="https://github.com/plexinc/plex-for-kodi/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="PMS-EULA"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

RDEPEND=">=media-tv/kodi-16.0"

src_install() {
	insinto "/usr/share/kodi/addons/${MY_PN}"
	doins -r "${S}"/*
}
