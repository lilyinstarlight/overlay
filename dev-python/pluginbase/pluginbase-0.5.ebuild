# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="A support library for building plugins sytems in Python"
HOMEPAGE="https://github.com/mitsuhiko/pluginbase"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND=""
RDEPEND=""

python_test() {
	cd tests && PYTHONPATH=.. py.test --tb=native || die "Tests fail with ${EPYTHON}"
}
