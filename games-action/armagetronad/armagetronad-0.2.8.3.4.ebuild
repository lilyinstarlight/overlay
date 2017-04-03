# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="A fast-paced 3D lightcycle game based on Tron"
HOMEPAGE="http://armagetronad.org/"
BRANCH="0.2.8"
VERSION="0.2.8.3.4"
SRC_URI="https://launchpad.net/armagetronad/${BRANCH}/${VERSION}/+download/${P}.src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+auth music"

RDEPEND="
	dev-libs/libxml2
	media-libs/libpng:*
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	virtual/opengl

	auth? ( dev-libs/zthread )
"
DEPEND="
	${RDEPEND}
	sys-devel/autoconf
	sys-devel/bison
"

src_prepare() {
	sed -i -e "s/png_check_sig/png_sig_cmp/" configure.ac || die
	./bootstrap.sh || die

	default
}

src_configure() {
	econf \
		--disable-uninstall \
		$(use_enable auth authentication) \
		$(use_enable music)
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
