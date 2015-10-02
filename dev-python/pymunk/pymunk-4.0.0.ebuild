# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="pymunk is a pythonic 2d physics library based on Chipmunk"
HOMEPAGE="http://www.pymunk.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples"

RDEPEND=""
DEPEND="${RDEPEND}"

python_install_all() {
	use doc && HTML_DOCS=( docs/html/. )
	distutils-r1_python_install_all

	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
