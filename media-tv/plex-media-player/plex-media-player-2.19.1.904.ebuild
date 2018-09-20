# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit desktop eutils gnome2-utils cmake-utils

DESCRIPTION="Next generation Plex Desktop/Embedded Client"
HOMEPAGE="http://plex.tv/"

# To change on every release bump:
COMMIT="f679df4f"
WEB_CLIENT_BUILD_ID="73-9cb69aa69c1af1"
WEB_CLIENT_DESKTOP_VERSION="3.69.0-69c1af1"
WEB_CLIENT_TV_VERSION="3.70.3-9cb69aa"

MY_PV="${PV}-${COMMIT}"
MY_P="${PN}-${MY_PV}"

SRC_URI="
	https://github.com/plexinc/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz
	https://artifacts.plex.tv/web-client-pmp/${WEB_CLIENT_BUILD_ID}/buildid.cmake -> buildid-${WEB_CLIENT_BUILD_ID}.cmake
	https://artifacts.plex.tv/web-client-pmp/${WEB_CLIENT_BUILD_ID}/web-client-tv-${WEB_CLIENT_TV_VERSION}.tar.xz
	https://artifacts.plex.tv/web-client-pmp/${WEB_CLIENT_BUILD_ID}/web-client-tv-${WEB_CLIENT_TV_VERSION}.tar.xz.sha1
	desktop? (
		https://artifacts.plex.tv/web-client-pmp/${WEB_CLIENT_BUILD_ID}/web-client-desktop-${WEB_CLIENT_DESKTOP_VERSION}.tar.xz
		https://artifacts.plex.tv/web-client-pmp/${WEB_CLIENT_BUILD_ID}/web-client-desktop-${WEB_CLIENT_DESKTOP_VERSION}.tar.xz.sha1
	)
"

LICENSE="GPL-2 PMS-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cec +desktop joystick lirc"

QT_VERSION=5.7.1
DEPEND="
	>=dev-qt/qtcore-${QT_VERSION}
	>=dev-qt/qtnetwork-${QT_VERSION}
	>=dev-qt/qtxml-${QT_VERSION}
	>=dev-qt/qtwebchannel-${QT_VERSION}[qml]
	>=dev-qt/qtwebengine-${QT_VERSION}
	>=dev-qt/qtdeclarative-${QT_VERSION}
	>=dev-qt/qtquickcontrols-${QT_VERSION}
	>=dev-qt/qtx11extras-${QT_VERSION}
	media-video/mpv[libmpv]
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXrandr

	|| (
		media-video/ffmpeg[openssl]
		media-video/ffmpeg[gnutls]
		media-video/ffmpeg[securetransport]
	)

	cec? (
		<dev-libs/libcec-4.0.0
		>=dev-libs/libcec-2.2.0
	)

	joystick? (
		media-libs/libsdl2
		virtual/libiconv
	)
"

RDEPEND="
	${DEPEND}

	lirc? (
		app-misc/lirc
	)
"

PATCHES=(
	"${FILESDIR}/iconv-fix.patch"
	"${FILESDIR}/git-revision.patch"
)

S="${WORKDIR}/${MY_P}"
DEPENDENCIES_DIR="${S}/dependencies"

CMAKE_IN_SOURCE_BUILD=1

src_prepare() {
	sed -i -e '/^  install(FILES ${QTROOT}\/resources\/qtwebengine_devtools_resources.pak DESTINATION resources)$/d' src/CMakeLists.txt || die

	cmake-utils_src_prepare

	# Avoid to download during the build process
	mkdir -p "${DEPENDENCIES_DIR}"
	cp "${DISTDIR}/buildid-${WEB_CLIENT_BUILD_ID}.cmake" "${DEPENDENCIES_DIR}"
	# Desktop client
	if use desktop; then
		cp "${DISTDIR}/web-client-desktop-${WEB_CLIENT_DESKTOP_VERSION}.tar.xz" "${DEPENDENCIES_DIR}"
		cp "${DISTDIR}/web-client-desktop-${WEB_CLIENT_DESKTOP_VERSION}.tar.xz.sha1" "${DEPENDENCIES_DIR}"
		mkdir -p "${DEPENDENCIES_DIR}/universal-web-client-desktop/${WEB_CLIENT_BUILD_ID}"
		mv "${WORKDIR}/web-client-desktop-${WEB_CLIENT_DESKTOP_VERSION}" "${DEPENDENCIES_DIR}/universal-web-client-desktop/${WEB_CLIENT_BUILD_ID}"
	fi
	# Full screen TV client
	cp "${DISTDIR}/web-client-tv-${WEB_CLIENT_TV_VERSION}.tar.xz" "${DEPENDENCIES_DIR}"
	cp "${DISTDIR}/web-client-tv-${WEB_CLIENT_TV_VERSION}.tar.xz.sha1" "${DEPENDENCIES_DIR}"
	mkdir -p "${DEPENDENCIES_DIR}/universal-web-client-tv/${WEB_CLIENT_BUILD_ID}"
	mv "${WORKDIR}/web-client-tv-${WEB_CLIENT_TV_VERSION}" "${DEPENDENCIES_DIR}/universal-web-client-tv/${WEB_CLIENT_BUILD_ID}"

	eapply_user
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_CEC=$(usex cec)
		-DENABLE_SDL2=$(usex joystick)
		-DENABLE_LIRC=$(usex lirc)
		-DQTROOT=/usr/share/qt5
		-DWEB_CLIENT_DISABLE_DESKTOP=$(usex desktop "OFF" "ON")
	)

	export BUILD_NUMBER="${BUILD}"
	export GIT_REVISION="${COMMIT}"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	make_session_desktop "Plex Media Player" "plexmediaplayer" "--tv" "--fullscreen"
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
