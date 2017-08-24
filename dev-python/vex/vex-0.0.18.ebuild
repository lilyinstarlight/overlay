# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="Run commands in a virtualenv"
HOMEPAGE="https://github.com/sashahart/vex"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/virtualenv[${PYTHON_USEDEP}]"
