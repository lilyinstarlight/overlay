# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib unpacker

CHROME_PN="google-chrome-stable"
CHROME_PV="61.0.3163.79"
CHROME_P="${CHROME_PN}_${CHROME_PV}-1"
CHROME_DIR="opt/google/chrome"

DESCRIPTION="An adapter for playing DRM content"
HOMEPAGE="https://www.google.com/chrome"
SRC_URI="https://dl.google.com/linux/chrome/deb/pool/main/g/${CHROME_PN}/${CHROME_P}_amd64.deb"

LICENSE="google-chrome"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip"

DEPEND=""
RDEPEND="
	>=media-tv/kodi-9999[agile]
"

S="${WORKDIR}/${CHROME_DIR}"

src_install() {
	insinto /usr/$(get_libdir)/kodi/cdm
	doins libwidevinecdm.so
}
