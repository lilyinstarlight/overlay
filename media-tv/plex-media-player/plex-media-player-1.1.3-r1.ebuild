# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils cmake-utils

DESCRIPTION="next generation Plex client"
HOMEPAGE="http://plex.tv/"

BUILD="380"
COMMIT="a2959899"
WEBCLIENT_VERSION="2.6.9"
WEBCLIENT_BUILD="149"
WEBCLIENT_COMMIT="6ec8fed"
MY_PV="${PV}.${BUILD}-${COMMIT}"
MY_P="${PN}-${MY_PV}"

SRC_URI="
	https://github.com/plexinc/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz
	https://nightlies.plex.tv/directdl/plex-dependencies/plex-web-client-plexmediaplayer/${WEBCLIENT_BUILD}/plex-web-client-pmp-${WEBCLIENT_VERSION}-${WEBCLIENT_COMMIT}.tbz2
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cec joystick lirc"

DEPEND="
	>=dev-qt/qtcore-5.6
	>=dev-qt/qtnetwork-5.6
	>=dev-qt/qtxml-5.6
	>=dev-qt/qtwebchannel-5.6[qml]
	>=dev-qt/qtwebengine-5.6
	>=media-video/mpv-0.11.0[libmpv]
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXrandr

	cec? (
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

PATCHES=( "${FILESDIR}"/git-revision.patch )

S="${WORKDIR}/${MY_P}"

CMAKE_IN_SOURCE_BUILD=1

src_unpack() {
	unpack "${P}".tar.gz
}

src_prepare() {
	cp "${DISTDIR}"/plex-web-client-pmp-"${WEBCLIENT_VERSION}"-"${WEBCLIENT_COMMIT}".tbz2 "${S}"

	cmake-utils_src_prepare

	eapply_user
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_CEC=$(usex cec)
		-DENABLE_SDL2=$(usex joystick)
		-DENABLE_LIRC=$(usex lirc)
		-DQTROOT=/usr
	)

	export BUILD_NUMBER="${BUILD}"
	export GIT_REVISION="${COMMIT}"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	# menu items
	domenu "${FILESDIR}/plexmediaplayer.desktop"
	newicon -s 16 "${FILESDIR}/plexmediaplayer-16x16.png" plexmediaplayer.png
	newicon -s 24 "${FILESDIR}/plexmediaplayer-24x24.png" plexmediaplayer.png
	newicon -s 32 "${FILESDIR}/plexmediaplayer-32x32.png" plexmediaplayer.png
	newicon -s 48 "${FILESDIR}/plexmediaplayer-48x48.png" plexmediaplayer.png
	newicon -s 256 "${FILESDIR}/plexmediaplayer-256x256.png" plexmediaplayer.png
}
