# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils bzr

DESCRIPTION="A fast-paced 3D lightcycle game based on Tron"
HOMEPAGE="http://armagetronad.org/"
EBZR_REPO_URI="lp:armagetronad/${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+auth +fortress glew +joystick +sound"

RDEPEND="
	dev-libs/boost[threads]
	dev-libs/libxml2
	dev-libs/protobuf
	media-libs/ftgl
	media-libs/libpng:*
	media-libs/libsdl2
	media-libs/sdl2-image
	media-libs/sdl2-mixer
	virtual/opengl

	glew? ( media-libs/glew:0 )
"
DEPEND="
	${RDEPEND}
	sys-devel/autoconf
	sys-devel/bison
"

src_prepare() {
	./bootstrap.sh || die

	default
}

src_configure() {
	econf \
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
	default

	doicon desktop/icons/large/armagetronad.png
	domenu desktop/armagetronad-armagetronad.desktop
}
