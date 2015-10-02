# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="a pure python implementation of multicast DNS service discovery"
HOMEPAGE="https://github.com/jstasiak/python-zeroconf"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="
	dev-python/enum34
	dev-python/netifaces
	dev-python/six
"

src_prepare() {
	epatch "${FILESDIR}"/enum-compat.patch

	distutils-r1_src_prepare
}
