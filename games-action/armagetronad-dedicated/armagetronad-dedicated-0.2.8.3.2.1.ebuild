# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games

DESCRIPTION="A fast-paced 3D lightcycle game based on Tron."
HOMEPAGE="http://armagetronad.org/"
MY_PN="armagetronad"
MY_P="${MY_PN}-${PV}"
BRANCH="0.2.8"
VERSION="0.2.8.3.2"
SRC_URI="https://launchpad.net/armagetronad/${BRANCH}/${VERSION}/+download/${MY_P}.src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="auth"

RDEPEND="
	dev-libs/libxml2
	auth? ( dev-libs/zthread )
"
DEPEND="
	${RDEPEND}
	sys-devel/autoconf
	sys-devel/bison
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i "s/png_check_sig/png_sig_cmp" "${WORKDIR}/${MY_P}"/configure.ac
	"${WORKDIR}/${MY_P}"/bootstrap.sh
}

src_configure() {
	egamesconf \
		--disable-uninstall
		--enable-dedicated
		$(use_enable auth authentication)
}

src_compile() {
	# Parallel builds sometimes fail
	emake -j1
}

src_install() {
	emake DESTDIR="${D}" install

	doicon desktop/icons/large/armagetronad.png
	domenu desktop/armagetronad-armagetronad.desktop

	dodoc AUTHORS ChangeLog COPYING NEWS README

	prepgamesdirs
}
