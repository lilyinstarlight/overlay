# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils

DESCRIPTION="Combine the frontend media player Kodi with the multimedia backend server Plex"
HOMEPAGE="https://github.com/croneter/PlexKodiConnect"
SRC_URI="https://github.com/croneter/PlexKodiConnect/archive/${PV}.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND="
	>=media-tv/kodi-16.0
"

RDEPEND="
	${DEPEND}
"

S="${WORKDIR}/PlexKodiConnect-${PV}"

src_install() {
	insinto "/usr/share/kodi/addons/plugin.video.plexkodiconnect"
	doins -r "${S}/"*
}
