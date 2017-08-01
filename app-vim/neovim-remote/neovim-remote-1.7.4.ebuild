# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Neovim support for --remote and friends"
HOMEPAGE="https://github.com/mhinz/neovim-remote"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/neovim-python-client[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
