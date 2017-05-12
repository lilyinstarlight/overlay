# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils git-r3 cmake-utils

DESCRIPTION="next generation Plex client"
HOMEPAGE="http://plex.tv/"

EGIT_REPO_URI="https://github.com/plexinc/plex-media-player.git"

LICENSE="GPL-2 PMS-EULA"
SLOT="0"
KEYWORDS=""
IUSE="cec +desktop joystick lirc"

CDEPEND="
	>=dev-qt/qtcore-5.7
	>=dev-qt/qtnetwork-5.7
	>=dev-qt/qtxml-5.7
	>=dev-qt/qtwebchannel-5.7[qml]
	>=dev-qt/qtwebengine-5.7
	>=dev-qt/qtdeclarative-5.7
	>=dev-qt/qtquickcontrols-5.7
	>=dev-qt/qtx11extras-5.7
	>=media-video/mpv-0.22.0[libmpv]
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

DEPEND="
	${CDEPEND}

	>=dev-util/conan-0.20
"

RDEPEND="
	${CDEPEND}

	lirc? (
		app-misc/lirc
	)
"

PATCHES=(
	"${FILESDIR}/iconv-fix.patch"
)

S="${WORKDIR}/${MY_P}"

CMAKE_IN_SOURCE_BUILD=1

src_unpack() {
	git-r3_src_unpack

	cd "${S}"

	CONAN_USER_HOME="${S}" conan remote add plex http://conan.plex.tv || die
	CONAN_USER_HOME="${S}" conan install -o include_desktop=$(usex desktop True False) || die
}

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
	)

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
