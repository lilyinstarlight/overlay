# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils multilib

DESCRIPTION="An application that queries the user for a selection for printing"
HOMEPAGE="https://github.com/naelstrof/slop"
SRC_URI="https://github.com/naelstrof/slop/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	x11-libs/libX11
	x11-libs/libXext
	media-libs/glew:0=
	media-libs/glm
	virtual/opengl"
DEPEND="
	${RDEPEND}
	media-libs/glm"

src_install() {
	cmake-utils_src_install

	# fix multilib-strict QA error
	mv "${D}"/usr/lib "${D}"/usr/$(get_libdir) || die
}
