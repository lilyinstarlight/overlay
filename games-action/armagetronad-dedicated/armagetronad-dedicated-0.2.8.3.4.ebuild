# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A fast-paced 3D lightcycle game based on Tron - dedicated server"
HOMEPAGE="http://armagetronad.org/"
MY_PN="armagetronad"
MY_P="${MY_PN}-${PV}"
BRANCH="0.2.8"
VERSION="0.2.8.3.4"
SRC_URI="https://launchpad.net/armagetronad/${BRANCH}/${VERSION}/+download/${MY_P}.src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+auth"

RDEPEND="
	dev-libs/libxml2

	auth? ( dev-libs/zthread )
"
DEPEND="
	${RDEPEND}
	sys-devel/autoconf
	sys-devel/bison
"

S="${WORKDIR}/${MY_PN}-${VERSION}"

src_prepare() {
	sed -i -e "s/png_check_sig/png_sig_cmp/" configure.ac || die
	./bootstrap.sh || die

	default
}

src_configure() {
	econf \
		--disable-uninstall \
		--enable-dedicated \
		$(use_enable auth authentication)
}

src_compile() {
	#Parallel builds sometimes fail
	emake -j1
}
