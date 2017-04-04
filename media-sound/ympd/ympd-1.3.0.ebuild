# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Standalone MPD Web GUI written in C, utilizing Websockets and Bootstrap/JS"
HOMEPAGE="https://www.ympd.org/"
SRC_URI="https://github.com/notandy/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+hostchange +ipv6 +ssl"

DEPEND="
	media-libs/libmpdclient

	ssl? ( dev-libs/openssl:0 )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DWITH_MPD_HOST_CHANGE=$(usex hostchange)
		-DWITH_IPV6=$(usex ipv6)
		-DWITH_SSL=$(usex ssl)
	)

	cmake-utils_src_configure
}
