# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils cmake-utils

DESCRIPTION="next generation Plex client"
HOMEPAGE="http://plex.tv/"

BUILD="359"
COMMIT="2b757d45"
WEBCLIENT_BUILD="143"
WEBCLIENT_COMMIT="5f79fce"
MY_PV="${PV}.${BUILD}-${COMMIT}"
MY_P="${PN}-${MY_PV}"

SRC_URI="
	https://github.com/plexinc/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz
	https://nightlies.plex.tv/directdl/plex-dependencies/plex-web-client-plexmediaplayer/${WEBCLIENT_BUILD}/plex-web-client-konvergo-${WEBCLIENT_COMMIT}.cpp.tbz2
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
	cp "${DISTDIR}"/plex-web-client-konvergo-"${WEBCLIENT_COMMIT}".cpp.tbz2 "${S}"/src

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable cec CEC)
		$(cmake-utils_use_enable joystick SDL2)
		$(cmake-utils_use_enable lirc LIRC)
		-DQTROOT=/usr
	)

	export BUILD_NUMBER="${BUILD}"
	export GIT_REVISION="${COMMIT}"

	cmake-utils_src_configure
}
