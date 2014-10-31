# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games bzr

DESCRIPTION="A fast-paced 3D lightcycle game based on Tron."
HOMEPAGE="http://armagetronad.org/"
MY_PN="armagetronad"
MY_P="${MY_PN}-${PV}"
EBZR_REPO_URI="lp:armagetronad/${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+auth +fortress"

RDEPEND="
	dev-libs/boost[threads]
	dev-libs/libxml2
	dev-libs/protobuf
"
DEPEND="
	${RDEPEND}
	sys-devel/autoconf
	sys-devel/bison
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	"${WORKDIR}/${MY_P}"/bootstrap.sh
}

src_configure() {
	egamesconf \
		--disable-uninstall
		--enable-dedicated
		$(use_enable auth authentication)
		$(use_enable fortress)
}

src_compile() {
	#Parallel builds sometimes fail
	emake -j1
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc AUTHORS ChangeLog COPYING NEWS README

	prepgamesdirs
}
