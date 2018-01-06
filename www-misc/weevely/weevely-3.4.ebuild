# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 eutils

DESCRIPTION="Weaponized web shell"
HOMEPAGE="https://github.com/epinna/weevely3"
MY_PN="weevely3"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://github.com/epinna/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="
	dev-python/prettytable[${PYTHON_USEDEP}]
	dev-python/mako[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/PySocks[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${MY_P}"

src_install() {
	dodir /usr/share/${PN}
	cp -R * "${ED}"/usr/share/${PN}/ || die

	python_fix_shebang "${ED}"/usr/share/${PN}

	make_wrapper ${PN} /usr/share/${PN}/weevely.py
}
