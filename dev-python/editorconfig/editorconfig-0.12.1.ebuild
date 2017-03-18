# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5} )

inherit distutils-r1

MY_PN=EditorConfig
MY_P=${MY_PN}-${PV}

DESCRIPTION="EditorConfig File Locator and Interpreter for Python"
HOMEPAGE="https://pypi.python.org/pypi/EditorConfig"
SRC_URI="mirror://pypi/$(echo ${MY_PN} | cut -c 1)/${MY_PN}/${MY_P}.tar.gz"

LICENSE="PSF-2.4"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}
