# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="Python interface to control BlinkStick devices connected to the computer"
HOMEPAGE="https://www.blinkstick.com/"
MY_PN="blinkstick-python"
MY_PV="a9227d01a9771c0e7aee811a15b824a357f6f09c"
MY_P="${MY_PN}-${MY_PV}"
SRC_URI="https://github.com/arvydas/${MY_PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pyusb"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_install() {
	distutils-r1_src_install

	insinto /lib/udev/rules.d
	doins "${FILESDIR}"/85-blinkstick.rules
}
