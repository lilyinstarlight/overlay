# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils cmake-utils

DESCRIPTION="next generation Plex client"
HOMEPAGE="http://plex.tv/"

BUILD="70"
COMMIT="15a01542"
WEBCLIENT="c1f55d5"
MY_PV="${PV}.${BUILD}-${COMMIT}"
MY_P="${PN}-${MY_PV}"

SRC_URI="
	https://github.com/plexinc/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz
	https://nightlies.plex.tv/directdl/plex-web-client-plexmediaplayer/master/plex-web-client-konvergo-${WEBCLIENT}.cpp.bz2
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cec joystick lirc"

DEPEND="
	>=dev-qt/qtcore-5.5.1
	>=dev-qt/qtnetwork-5.5.1
	>=dev-qt/qtxml-5.5.1
	>=dev-qt/qtwebchannel-5.5.1[qml]
	>=dev-qt/qtwebengine-5.5.1[qml,pmp]
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

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack "${P}".tar.gz

	cd "${S}"

	unpack plex-web-client-konvergo-"${WEBCLIENT}".cpp.bz2
}

src_prepare() {
	epatch "${FILESDIR}"/git-revision.patch
	epatch "${FILESDIR}"/web-client-resource.patch
}

src_configure() {
	local mycmakeargs="
		$(cmake-utils_use_enable cec CEC)
		$(cmake-utils_use_enable joystick SDL2)
		$(cmake-utils_use_enable lirc LIRC)
		-DQTROOT=/usr
	"

	export BUILD_NUMBER="${BUILD}"
	export GIT_REVISION="${COMMIT}"

	cmake-utils_src_configure
}
