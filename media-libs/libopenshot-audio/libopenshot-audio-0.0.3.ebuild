# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="A high-quality audio editing and playback library used by libopenshot."
HOMEPAGE="http://openshot.org/"
SRC_URI="
	https://launchpad.net/libopenshot/0.0/${PV}/+download/${P}.tar.gz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND="
	x11-libs/libX11
"
DEPEND="
	${RDEPEND}
"
