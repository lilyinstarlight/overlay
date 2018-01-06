# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils multilib versionator

DESCRIPTION="Chipmunk2D is a lightweight, fast, and portable 2D rigid body physics library"
HOMEPAGE="http://chipmunk-physics.net/"
MY_PN="Chipmunk"
MY_P="${MY_PN}-${PV}"
MY_PVM="$(get_major_version ${PV}).x"
MY_PM="${MY_PN}-${MY_PVM}"
SRC_URI="http://chipmunk-physics.net/release/${MY_PM}/${MY_P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="demos"

DEPEND="
	demos? (
		media-libs/glfw
		media-libs/glew:0
		virtual/opengl
	)
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	local mycmakeargs=(
		$(use demos && echo "-DBUILD_DEMOS=ON -DINSTALL_DEMOS=ON" || echo "-DBUILD_DEMOS=OFF -DINSTALL_DEMOS=OFF")
		-DLIB_INSTALL_DIR=$(get_libdir)
	)

	cmake-utils_src_configure
}
