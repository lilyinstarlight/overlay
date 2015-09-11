# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools

DESCRIPTION="A simple, lightweight C library for writing XMPP clients"
HOMEPAGE="http://strophe.im/libstrophe/"
SRC_URI="https://github.com/strophe/libstrophe/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="
	|| ( dev-libs/libxml2 dev-libs/expat )
	dev-libs/openssl:*
"
DEPEND="
	${RDEPEND}
	doc? ( app-doc/doxygen )
"

src_prepare() {
		eautoreconf
}

src_compile() {
		emake

		if use doc; then
			doxygen || die
		fi
}

src_install() {
		einstall

		use doc && dohtml -r docs/html/*
}
