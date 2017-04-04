# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5} )

inherit eutils distutils-r1

DESCRIPTION="Python library for XMPP - asyncio fork"
HOMEPAGE="https://dev.louiz.org/projects/slixmpp"
DOWNLOAD_ID="117"
SRC_URI="https://dev.louiz.org/attachments/download/${DOWNLOAD_ID}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="crypt cython"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="
	dev-python/aiodns[${PYTHON_USEDEP}]
	dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/pyasn1-modules[${PYTHON_USEDEP}]

	crypt? (
		dev-python/python-gnupg[${PYTHON_USEDEP}]
	)
	cython? (
		dev-python/cython[${PYTHON_USEDEP}]
		net-dns/libidn
	)
"

python_test() {
	esetup.py test
}
