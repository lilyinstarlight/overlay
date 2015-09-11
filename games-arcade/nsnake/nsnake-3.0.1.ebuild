# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils games

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
}

src_compile() {
	PREFIX="${GAMES_PREFIX}" DATAROOTDIR="${GAMES_DATADIR_BASE}" EXEC_PREFIX="${GAMES_PREFIX}" BINDIR="${GAMES_BINDIR}" emake
}

src_install() {
	PREFIX="${GAMES_PREFIX}" DATAROOTDIR="${GAMES_DATADIR_BASE}" EXEC_PREFIX="${GAMES_PREFIX}" BINDIR="${GAMES_BINDIR}" emake DESTDIR="${D}" install

	dodoc README.md ChangeLog AUTHORS

	prepgamesdirs
}
