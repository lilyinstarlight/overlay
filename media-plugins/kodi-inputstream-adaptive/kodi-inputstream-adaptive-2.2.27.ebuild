# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils kodi-addon

DESCRIPTION="Kodi's Adaptive inputstream addon"
HOMEPAGE="https://github.com/peak3d/inputstream.adaptive.git"

MY_PN="inputstream.adaptive"
MY_P="${MY_PN}-${PV}"

case ${PV} in
9999)
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/peak3d/${MY_PN}.git"
	inherit git-r3
	;;
*)
	KEYWORDS=""
	SRC_URI="https://github.com/peak3d/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	S="${WORKDIR}/${MY_P}"
	;;
esac

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	>=media-tv/kodi-9999
	>=media-libs/kodi-platform-9999
	"
RDEPEND="
	${DEPEND}
	"

src_prepare() {
	sed -i -e "s#DECRYPTERPATH \"special://home/cdm\"#DECRYPTERPATH \"/usr/$(get_libdir)/kodi/cdm\"#" CMakeLists.txt

	default
}

src_install() {
	cmake-utils_src_install

	dosym /usr/$(get_libdir)/kodi/addons/inputstream.adaptive/libssd_wv.so /usr/$(get_libdir)/kodi/cdm/libssd_wv.so
}
