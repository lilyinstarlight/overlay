# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

inherit distutils-r1 gnome2-utils

DESCRIPTION="An automatic disk mounting service using udisks"
HOMEPAGE="https://pypi.python.org/pypi/udiskie https://github.com/coldfix/udiskie"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND="
	dev-python/docopt[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	sys-fs/udisks:2
"
DEPEND="
	app-text/asciidoc
	dev-python/setuptools[${PYTHON_USEDEP}]
"

src_prepare() {
	sed -i \
		-e 's:gtk-update-icon-cache:true:' \
		setup.py || die

	distutils-r1_src_prepare
}

src_compile() {
	distutils-r1_src_compile
	emake -C doc
}

src_install() {
	distutils-r1_src_install
	doman doc/${PN}.8
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
