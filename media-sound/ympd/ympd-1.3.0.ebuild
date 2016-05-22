# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

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

	ssl? ( dev-libs/openssl )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with hostchange MPD_HOST_CHANGE)
		$(cmake-utils_use_with ipv6 IPV6)
		$(cmake-utils_use_with ssl SSL)
	)

	cmake-utils_src_configure
}
