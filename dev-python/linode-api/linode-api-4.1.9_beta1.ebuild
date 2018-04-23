# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="Official Python library for the Linode API v4"
HOMEPAGE="https://developers.linode.com/v4/libraries/python"
MY_PN="python-${PN}"
MY_PV="${PV/_beta/b}"
MY_P="${MY_PN}-${MY_PV}"
SRC_URI="https://github.com/linode/${MY_PN}/archive/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	virtual/python-enum34[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	sed -i -e "s/find_packages(exclude=\['contrib', 'docs', 'tests'\])/['linode']/" setup.py || die

	distutils-r1_python_prepare_all
}
