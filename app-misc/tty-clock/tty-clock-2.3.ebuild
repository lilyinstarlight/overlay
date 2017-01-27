# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="analog clock in ncurses"
HOMEPAGE="https://github.com/xorg62/tty-clock"
SRC_URI="https://github.com/xorg62/${PN}/archive/v${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	sys-libs/ncurses:0
"
RDEPEND="
	${DEPEND}
"

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}
