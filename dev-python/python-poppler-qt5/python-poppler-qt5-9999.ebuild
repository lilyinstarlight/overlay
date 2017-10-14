# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{2,3,4,5,6} )

inherit distutils-r1 git-r3 qmake-utils

DESCRIPTION="A python binding for libpoppler-qt5"
HOMEPAGE="https://github.com/wbsoft/python-poppler-qt5"
EGIT_REPO_URI="https://github.com/wbsoft/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	app-text/poppler:=[qt5]
	dev-python/PyQt5[${PYTHON_USEDEP}]
	dev-python/sip:=[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

src_prepare() {
	echo "[build_ext]" >>setup.cfg
	echo "qmake-bin=$(qt5_get_bindir)/qmake" >>setup.cfg

	distutils-r1_src_prepare
}
