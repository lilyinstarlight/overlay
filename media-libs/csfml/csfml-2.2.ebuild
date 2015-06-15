# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="C library for the Simple and Fast Multimedia Library (SFML)"
HOMEPAGE="http://www.sfml-dev.org/"
MY_PN="CSFML"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://github.com/SFML/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

CDEPEND="
	~media-libs/libsfml-${PV}
"
DEPEND="
	${CDEPEND}
	doc? ( app-doc/doxygen )
"
RDEPEND="
	${CDEPEND}
"

DOCS="readme.txt"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/no-docs.patch"

	sed -i -e "s:DESTINATION .*:DESTINATION /usr/share/doc/${PF}:" doc/CMakeLists.txt
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use doc CSFML_BUILD_DOC)
	)

	cmake-utils_src_configure
}
