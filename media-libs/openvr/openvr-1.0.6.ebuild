# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="API and runtime for accessing VR hardware from multiple vendors"
HOMEPAGE="https://steamvr.com/"
SRC_URI="https://github.com/ValveSoftware/${PN}/archive/v${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

PATCHES=( "${FILESDIR}"/no-stdcall.patch )

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
}
