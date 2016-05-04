# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 autotools

DESCRIPTION="Apple airplay and raop protocol server"
HOMEPAGE="https://github.com/juhovh/shairplay"
EGIT_REPO_URI="https://github.com/juhovh/shairplay.git"
EGIT_COMMIT="ce80e00"

LICENSE="MIT BSD LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+ao"

DEPEND="
	ao? ( media-libs/libao )
	net-dns/avahi[mdnsresponder-compat]
"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf

	sed 's/airport.key/\/etc\/shairplay\/airport.key/' -i "${S}"/src/shairplay.c
}

src_install() {
	emake DESTDIR="${D}" install

	dodir /etc/shairplay

	insinto /etc/shairplay
	doins airport.key
}
