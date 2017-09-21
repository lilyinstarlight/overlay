# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5,3_6} pypy )

inherit distutils-r1 eutils

DESCRIPTION="text progress bar library for Python"
HOMEPAGE="http://progressbar-2.readthedocs.org/en/latest/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/python-utils-2.0.0[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

python_prepare_all() {
	epatch "${FILESDIR}"/no-test.patch

	distutils-r1_python_prepare_all
}
