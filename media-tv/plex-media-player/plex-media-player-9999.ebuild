# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="next generation Plex client"
HOMEPAGE="http://plex.tv/"

EGIT_REPO_URI="https://github.com/plexinc/plex-media-player.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
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

src_prepare() {
	epatch "${FILESDIR}"/no-qt-conf.patch
	epatch "${FILESDIR}"/support-qt-5.5.patch
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable cec CEC)
		$(cmake-utils_use_enable joystick SDL2)
		$(cmake-utils_use_enable lirc LIRC)
		-DQTROOT=/usr
	)

	cmake-utils_src_configure
}
