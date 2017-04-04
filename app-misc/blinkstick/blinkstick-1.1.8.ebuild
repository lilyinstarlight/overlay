# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="Python interface to control BlinkStick devices connected to the computer"
HOMEPAGE="https://www.blinkstick.com/"
MY_PN="BlinkStick"
MY_P="${MY_PN}-${PV}"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	=dev-python/pyusb-1.0.0_beta1
"
RDEPEND="
	${DEPEND}
"

S="${WORKDIR}/${MY_P}"

src_install() {
	distutils-r1_src_install

	insinto /lib/udev/rules.d
	doins "${FILESDIR}"/85-blinkstick.rules
}
