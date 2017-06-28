# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit python-single-r1

DESCRIPTION="PageKite makes local websites or SSH servers publicly accessible in mere seconds"
HOMEPAGE="http://pagekite.net/"
SRC_URI="https://pagekite.net/pk/${P}.py"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}"/"${P}".py "${PN}".py || die
}

src_prepare() {
	python_fix_shebang .

	default
}

src_install() {
	newbin "${PN}".py "${PN}"
}
