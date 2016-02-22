# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils

DESCRIPTION="maim (Make Image) takes screenshots of your desktop and is designed to be an improved scrot"
HOMEPAGE="https://github.com/naelstrof/maim"
SRC_URI="https://github.com/naelstrof/maim/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	media-libs/imlib2
	x11-libs/libX11
	x11-libs/libXrandr
	x11-libs/libXfixes
"
RDEPEND="
	${DEPEND}
	x11-misc/slop
"

src_prepare() {
	epatch "${FILESDIR}"/no-gengetopt.patch
}
