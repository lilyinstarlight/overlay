# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Libraries for programming the roboRIO"
HOMEPAGE="https://github.com/wpilibsuite/allwpilib"
MY_PN="allwpilib"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://github.com/wpilibsuite/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+allwpilib doc +java +opencv static"

REQUIRED_USE="static? ( !java ) allwpilib? ( opencv )"

RDEPEND="
	java? ( virtual/jdk:* )
	opencv? ( media-libs/opencv )
"
DEPEND="
	${RDEPEND}
	doc? ( app-doc/doxygen )
"
BDEPEND=""

S="${WORKDIR}/${MY_P}"

src_configure() {
	local mycmakeargs=(
		-DWITHOUT_JAVA=$(usex java "OFF" "ON")
		-DBUILD_SHARED_LIBS=$(usex static "OFF" "ON")
		-DWITHOUT_CSCORE=$(usex opencv "OFF" "ON")
		-DWITHOUT_ALLWPILIB=$(usex allwpilib "OFF" "ON")
	)

	cmake-utils_src_configure
}
