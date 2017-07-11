# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{3_4,3_5} )

inherit distutils-r1

DESCRIPTION="CLI for the Linode API v4"
HOMEPAGE="https://www.linode.com/docs/platform/linode-cli/"
MY_PV="6b430f3dd1b00121a87e4fffcb927bdf4ebb3b74"
MY_P="${PN}-${MY_PV}"
SRC_URI="https://github.com/linode/${PN}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=dev-python/linode-api-4.1.1_beta0[${PYTHON_USEDEP}]
	dev-python/terminaltables[${PYTHON_USEDEP}]
	dev-python/colorclass[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
