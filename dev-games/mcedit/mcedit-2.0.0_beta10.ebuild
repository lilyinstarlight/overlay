# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 versionator

DESCRIPTION="Minecraft save game editor"
HOMEPAGE="http://www.mcedit.net/"
MY_PN="mcedit2"
MY_PV="$(replace_version_separator _ -)"
MY_P="${MY_PN}-${MY_PV}"
SRC_URI="https://github.com/mcedit/${MY_PN}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/arrow[${PYTHON_USEDEP}]

	dev-python/pyzmq[${PYTHON_USEDEP}]
	dev-python/pyside[designer,${PYTHON_USEDEP}]
	dev-python/pyopengl[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/ipython[${PYTHON_USEDEP}]
	dev-python/qtconsole[${PYTHON_USEDEP}]
	dev-python/pastebin[${PYTHON_USEDEP}]
	dev-python/raven[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]

	dev-python/pyside-tools[${PYTHON_USEDEP}]

	${CDEPEND}
"
RDEPEND="
	${CDEPEND}
"

S="${WORKDIR}/${MY_P}"

python_prepare() {
	eapply "${FILESDIR}"/mcedit2_plugins_directory.patch
	eapply "${FILESDIR}"/qcombobox_edittextchanged.patch

	sed -i -e "s#include_package_data=True#package_data={'mcedit2': [$(find src/mcedit2 -type f -not -name '*.py*' -not -name '*.ui' -not -name '*.qrc' -not -name 'Makefile' -printf "'%P',")]}#g" setup_mcedit2.py || die
	sed -i -e "s/git describe --tags/echo ${MY_PV}/g" mcedit2.spec src/mcedit2/__init__.py || die

	for file in $(find . -name '*.ui'); do
		pyside-uic "$file" > "${file::-2}py" || die
	done
}

src_install() {
	distutils-r1_src_install

	doicon "${FILESDIR}/mcedit2.png"
	domenu "${FILESDIR}/mcedit2.desktop"
}
