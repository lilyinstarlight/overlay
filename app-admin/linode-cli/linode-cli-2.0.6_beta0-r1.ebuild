# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1 versionator

DESCRIPTION="CLI for the Linode API v4"
HOMEPAGE="https://www.linode.com/docs/platform/linode-cli/"
MY_PV="${PV/_beta/b}"
MY_P="${PN}-${MY_PV}"
SRC_URI="https://github.com/linode/${PN}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/colorclass[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/terminaltables[${PYTHON_USEDEP}]
	virtual/python-enum34[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
