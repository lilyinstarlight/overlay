# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="a featherweight, lemon-scented, bar based on xcb"
HOMEPAGE="https://github.com/LemonBoy/bar"
#SM_COMMIT="ba126f832277b00c2f8c8e0850434542b8452d33"
#XFT_COMMIT="00a3fe6f3485203896156480e86014136749a221"
COMMIT="35183ab81d2128dbb7b6d8e119cc57846bcefdb4"
SRC_URI="
	!sm? ( !xft? ( https://github.com/LemonBoy/bar/archive/${COMMIT}.tar.gz -> ${P}.tar.gz ) )
"
EGIT_REPO_URI="https://github.com/osense/bar.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sm xft"

REQUIRED_USE="!sm !xft"

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
