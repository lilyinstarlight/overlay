# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils gnome2-utils git-r3 cmake-utils

DESCRIPTION="Next generation Plex Desktop/Embedded Client"
HOMEPAGE="http://plex.tv/"

EGIT_BRANCH="tv2"
EGIT_REPO_URI="https://github.com/plexinc/plex-media-player.git"

LICENSE="GPL-2 PMS-EULA"
SLOT="0"
KEYWORDS=""
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
)

S="${WORKDIR}/${P}"

CMAKE_IN_SOURCE_BUILD=1

src_prepare() {
	sed -i -e '/^  install(FILES ${QTROOT}\/resources\/qtwebengine_devtools_resources.pak DESTINATION resources)$/d' src/CMakeLists.txt || die

	cmake-utils_src_prepare

	eapply_user
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_CEC=$(usex cec)
		-DENABLE_SDL2=$(usex joystick)
		-DENABLE_LIRC=$(usex lirc)
		-DQTROOT=/usr/share/qt5
		-DWEB_CLIENT_DISABLE_DESKTOP=$(usex desktop "no" "yes")
	)

	export BUILD_NUMBER="${BUILD}"
	export GIT_REVISION="${COMMIT}"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	# menu items
	domenu "${FILESDIR}/plexmediaplayer.desktop"
	insinto "/usr/share/xsessions"
	doins "${FILESDIR}/plexmediaplayer-session.desktop"
	insinto "/usr/share/wayland-sessions"
	doins "${FILESDIR}/plexmediaplayer-wayland.desktop"

	newicon -s 16 "${FILESDIR}/plexmediaplayer-16x16.png" plexmediaplayer.png
	newicon -s 24 "${FILESDIR}/plexmediaplayer-24x24.png" plexmediaplayer.png
	newicon -s 32 "${FILESDIR}/plexmediaplayer-32x32.png" plexmediaplayer.png
	newicon -s 48 "${FILESDIR}/plexmediaplayer-48x48.png" plexmediaplayer.png
	newicon -s 256 "${FILESDIR}/plexmediaplayer-256x256.png" plexmediaplayer.png
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}