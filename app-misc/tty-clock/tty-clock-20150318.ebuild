# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

DESCRIPTION="analog clock in ncurses"
HOMEPAGE="https://github.com/xorg62/tty-clock"
EGIT_REPO_URI="https://github.com/xorg62/tty-clock.git"
EGIT_COMMIT="516afbf"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	sys-libs/ncurses
"
RDEPEND="
	${DEPEND}
"

src_compile() {
	if which ncurses6-config; then
		emake CFLAGS="${CFLAGS} $(ncurses6-config --cflags)" LDFLAGS="${LDFLAGS} $(ncurses6-config --libs)"
	else
		emake CFLAGS="${CFLAGS} $(ncurses5-config --cflags)" LDFLAGS="${LDFLAGS} $(ncurses5-config --libs)"
	fi
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}
