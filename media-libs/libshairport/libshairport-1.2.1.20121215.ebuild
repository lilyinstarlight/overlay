# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="A library for emulating an AirPort Express"
HOMEPAGE="https://github.com/amejia1/libshairport"
COMMIT="16395d8"
SRC_URI="https://github.com/amejia1/libshairport/tarball/${COMMIT} -> ${P}.tar.gz"
S="${WORKDIR}/amejia1-${PN}-${COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="
	dev-libs/openssl
	media-libs/libao
"
DEPEND="
	${RDEPEND}
"
