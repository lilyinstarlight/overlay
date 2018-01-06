# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5,3_6} pypy )

inherit distutils-r1 eutils

DESCRIPTION="a collection of functions and classes which shortens common patterns"
HOMEPAGE="http://python-utils.readthedocs.org/en/latest/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/six[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

python_prepare_all() {
	epatch "${FILESDIR}"/no-test.patch

	distutils-r1_python_prepare_all
}
