# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="A real-time web log analyzer and interactive viewer that runs in a terminal"
HOMEPAGE="http://goaccess.io"
SRC_URI="http://tar.goaccess.io/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="geoip unicode"

RDEPEND="
	dev-libs/glib:2
	sys-libs/ncurses[unicode?]
	geoip? ( dev-libs/geoip )
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	epatch "${FILESDIR}"/geoip-config.patch
}

src_configure() {
	econf \
		$(use_enable geoip) \
		$(use_enable unicode utf8)
}
