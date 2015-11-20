# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

DESCRIPTION="A featherweight, lemon-scented, bar based on xcb"
HOMEPAGE="https://github.com/LemonBoy/bar"
#MY_PN="bar"
#MY_P="${MY_PN}-${PV}"
#SRC_URI="https://github.com/LemonBoy/bar/archive/v${PV}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="https://github.com/krypt-n/bar.git"
if use xft; then
	EGIT_COMMIT="5bddcce"
else
	EGIT_COMMIT="495ac4e"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xft"

CDEPEND="
	x11-libs/libxcb
	xft? ( x11-libs/libXft )
"
DEPEND="
	dev-lang/perl
	${CDEPEND}
"
RDEPEND="
	${CDEPEND}
"

#S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i -e 's/-Os//' Makefile
}
