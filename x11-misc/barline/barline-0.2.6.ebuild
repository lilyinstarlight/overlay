# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="a simple data collector and formatter for lemonbar and bspwm"
HOMEPAGE="https://github.com/fkmclane/barline"
SRC_URI="https://github.com/fkmclane/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	media-libs/alsa-lib
	x11-libs/libxcb
"
RDEPEND="
	${DEPEND}
"

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
}
