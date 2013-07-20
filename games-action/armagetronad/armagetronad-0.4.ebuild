# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit games bzr

DESCRIPTION="A fast-paced 3D lightcycle game based on Tron."
HOMEPAGE="http://armagetronad.org/"
EBZR_REPO_URI="lp:armagetronad/0.4"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="dedicated"

RDEPEND="
	dev-libs/libxml2
	!dedicated? (
		media-libs/ftgl
		media-libs/glew
		=media-libs/libsdl-1.2*
		=media-libs/sdl-image-1.2*
		=media-libs/sdl-mixer-1.2*
	)
"
DEPEND="
	sys-devel/autoconf
	sys-devel/bison
	dev-libs/protobuf
	dev-libs/boost
	${RDEPEND}
"

src_prepare() {
	"${WORKDIR}/${P}/bootstrap.sh"
}

src_configure() {
	econf \
		$(use_enable dedicated)
}

src_install() {
	emake DESTDIR="${D}" install

	doicon desktop/icons/large/armagetronad.png
	domenu desktop/armagetronad-armagetronad.desktop

	dodoc AUTHORS ChangeLog COPYING NEWS README
}
