# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils multilib

DESCRIPTION="API and runtime for accessing VR hardware from multiple vendors"
HOMEPAGE="https://steamvr.com/"
SRC_URI="https://github.com/ValveSoftware/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND="
	virtual/opengl
	media-libs/glew
"
RDEPEND=""

src_prepare() {
	sed -i -e "s/ DESTINATION lib)/ DESTINATION $(get_libdir))/" src/CMakeLists.txt || die

	default
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED=ON
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	doheader headers/openvr.h
	doheader headers/openvr_capi.h
	doheader headers/openvr_driver.h

	if use examples; then
		insinto /usr/share/"${PN}"
		doins -r samples
	fi
}
