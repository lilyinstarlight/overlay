# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils kodi-addon multilib

DESCRIPTION="Kodi's Adaptive inputstream addon"
HOMEPAGE="https://github.com/peak3d/inputstream.adaptive.git"
SRC_URI=""

case ${PV} in
9999)
	KEYWORDS=""
	SRC_URI=""
	inherit git-r3
	;;
*)
	KEYWORDS="~amd64 ~x86"
	SRC_URI="
		!agile? ( https://github.com/peak3d/inputstream.adaptive/archive/v${PV}.tar.gz -> ${P}.tar.gz )
		agile? ( https://github.com/liberty-developer/inputstream.adaptive/archive/v${PV}.tar.gz -> ${P}.tar.gz )
	"
	S="${WORKDIR}/inputstream.adaptive-${PV}"
	;;
esac

LICENSE="GPL-2"
SLOT="0"
IUSE="agile"

DEPEND="
	=media-tv/kodi-9999[agile]
	=media-libs/kodi-platform-9999
	=dev-libs/libplatform-2*
	"
RDEPEND="
	${DEPEND}
	"

src_unpack() {
	case ${PV} in
	9999)
		if use agile; then
			EGIT_REPO_URI="git://github.com/liberty-developer/inputstream.adaptive.git"
			EGIT_BRANCH="agile"
		else
			EGIT_REPO_URI="git://github.com/peak3d/inputstream.adaptive.git"
		fi

		git-r3_src_unpack
		;;
	*)
		default
		;;
	esac

}

src_prepare() {
	if use agile; then
		sed -i -e "s#DECRYPTERPATH \"special://home/cdm\"#DECRYPTERPATH \"/usr/$(get_libdir)/kodi/cdm\"#" CMakeLists.txt
		sed -i -e "s#add_subdirectory(lib/libbento4)#add_subdirectory(wvdecrypter)\n  install(FILES \$<TARGET_FILE:ssd_wv> DESTINATION lib/\${APP_NAME_LC}/addons/inputstream.adaptive)#" CMakeLists.txt
	fi

	default
}

src_install() {
	cmake-utils_src_install

	dosym /usr/$(get_libdir)/kodi/addons/inputstream.adaptive/libssd_wv.so /usr/$(get_libdir)/kodi/cdm/libssd_wv.so
}
