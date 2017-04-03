# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="A library for emulating an AirPort Express"
HOMEPAGE="https://github.com/amejia1/libshairport"
COMMIT="16395d85ea2801cec612b935ba2972bd1a42a6a5"
SRC_URI="https://github.com/amejia1/libshairport/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="
	dev-libs/openssl:*
	media-libs/libao
"
DEPEND="
	${RDEPEND}
"

src_prepare() {
	eautoreconf

	default
}
