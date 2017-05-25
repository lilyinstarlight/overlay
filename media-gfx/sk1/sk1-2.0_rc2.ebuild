# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit python-single-r1 versionator

DESCRIPTION="an open-source illustration program that can substitute professional proprietary software like Corel Draw or Adobe Illustrator"
HOMEPAGE="https://sk1project.net/"
MY_PV="$(get_version_component_range 1-2)$(get_version_component_range 3)"
MY_P="${PN}-${MY_PV}"
SRC_URI="https://sk1project.net/dc3.php?version=${MY_PV}&target=${MY_P}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~x86"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
DEPEND="
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/reportlab[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/wxpython:3.0[${PYTHON_USEDEP}]
	dev-python/pycups[${PYTHON_USEDEP}]
	media-libs/lcms
	media-gfx/imagemagick
	x11-libs/pango
	${PYTHON_DEPS}
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	chmod +x setup-sk1.py || die

	default
}

src_compile() {
	./setup-sk1.py bdist || die
}

src_install() {
	tar -C "${D}" -xf dist/*.tar.gz || die

	default
}
