# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

MY_PN="nSnake"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="A clone of the classic snake game on the terminal"
HOMEPAGE="http://nsnake.alexdantas.net/"
SRC_URI="https://github.com/alexdantas/nSnake/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	sys-libs/ncurses:0
"
RDEPEND="
	${DEPEND}
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/Makefile.patch

	default
}
