# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games bzr

DESCRIPTION="A fast-paced 3D lightcycle game based on Tron."
HOMEPAGE="http://armagetronad.org/"
EBZR_REPO_URI="lp:armagetronad/${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+auth +fortress glew +joystick +sound"

RDEPEND="
	dev-libs/boost[threads]
	dev-libs/libxml2
	dev-libs/protobuf
	media-libs/ftgl
	media-libs/libpng
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	virtual/opengl

	glew? ( media-libs/glew )
"
DEPEND="
	${RDEPEND}
	sys-devel/autoconf
	sys-devel/bison
"

src_prepare() {
	./bootstrap.sh
}

src_configure() {
	egamesconf \
		--disable-uninstall \
		$(use_enable auth authentication) \
		$(use_enable fortress) \
		$(use_enable joystick) \
		$(use_enable sound) \
		$(use_with glew)
}

src_compile() {
	#Parallel builds sometimes fail
	emake -j1
}

src_install() {
	emake DESTDIR="${D}" install

	doicon desktop/icons/large/armagetronad.png
	domenu desktop/armagetronad-armagetronad.desktop

	dodoc AUTHORS ChangeLog NEWS README

	prepgamesdirs
}
