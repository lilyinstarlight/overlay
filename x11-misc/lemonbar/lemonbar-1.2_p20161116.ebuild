# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="a featherweight, lemon-scented, bar based on xcb"
HOMEPAGE="https://github.com/LemonBoy/bar"
SM_COMMIT="1b9b3cb23eeac15872ade4119335fd90cec89ec2"
XFT_COMMIT="043ad4757cc079666f50212ee0a2ef0729ecac6b"
COMMIT="d680ea4256637bc89d59342cf6ac6c6f5fe62dec"
SRC_URI="
	sm? ( xft? ( https://github.com/osense/bar/archive/${SM_COMMIT}.tar.gz -> ${P}-sm.tar.gz ) )
	!sm? ( xft? ( https://github.com/osense/bar/archive/${XFT_COMMIT}.tar.gz -> ${P}-xft.tar.gz ) )
	!sm? ( !xft? ( https://github.com/osense/bar/archive/${COMMIT}.tar.gz -> ${P}.tar.gz ) )
"
EGIT_REPO_URI="https://github.com/osense/bar.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sm xft"

REQUIRED_USE="sm? ( xft )"

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

pkg_setup() {
	if use sm; then
		S="${WORKDIR}/bar-${SM_COMMIT}"
	elif use xft; then
		S="${WORKDIR}/bar-${XFT_COMMIT}"
	else
		S="${WORKDIR}/bar-${COMMIT}"
	fi
}

src_prepare() {
	sed -i -e 's/-Os//' Makefile || die
	sed -i -e 's/mon->x + mon->width/mon->x + mon->width - 1/g' lemonbar.c || die

	default
}
