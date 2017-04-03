# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Plex's official Plex add-on for Kodi."
HOMEPAGE="http://plex.tv/"
MY_PN="script.plex"
GIT_COMMIT="64938ebcecbb32facfa73e8cc5fb5c3b4c373b8c"
SRC_URI="https://github.com/plexinc/plex-for-kodi/archive/${GIT_COMMIT}.zip -> ${P}-${GIT_COMMIT}.zip"

LICENSE="PMS-EULA"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND="
	>=media-tv/kodi-16.0
"

RDEPEND="
	${DEPEND}
"

S="${WORKDIR}/${PN}-${GIT_COMMIT}"

src_install() {
	insinto "/usr/share/kodi/addons/${MY_PN}"
	doins -r "${S}/"*
}
