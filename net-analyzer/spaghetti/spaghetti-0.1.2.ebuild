# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit eutils python-single-r1

DESCRIPTION="Spaghetti web application security scanner"
HOMEPAGE="https://github.com/m4ll0k/Spaghetti"
MY_PN="Spaghetti"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://github.com/m4ll0k/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:python-2[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${MY_P}"

src_install() {
	dodir /usr/share/${PN}/

	cp -R * "${ED}"/usr/share/${PN}/
	python_fix_shebang "${ED}"/usr/share/${PN}
	fperms +x /usr/share/${PN}/spaghetti.py
	make_wrapper "${PN}" /usr/share/"${PN}"/spaghetti.py /usr/share/"${PN}"
}
