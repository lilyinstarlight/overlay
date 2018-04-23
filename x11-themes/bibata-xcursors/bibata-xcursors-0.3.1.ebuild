# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Material based cursor"
HOMEPAGE="https://github.com/KaizIqbal/Bibata_Cursor"
MY_PN="Bibata_Cursor"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://github.com/KaizIqbal/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	media-gfx/inkscape
	x11-apps/xcursorgen
"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i -e 's/gksu //' build.sh || die

	default
}

src_compile() {
	./build.sh || die
}

src_install() {
	insinto /usr/share/icons/
	doins -r Bibata_Ice
	doins -r Bibata_Oil

	insinto /usr/share/cursors/xorg-x11/
	doins -r Bibata_Ice
	doins -r Bibata_Oil
}
