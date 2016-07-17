# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-r3 cmake-utils

DESCRIPTION="next generation Plex client"
HOMEPAGE="http://plex.tv/"

EGIT_REPO_URI="https://github.com/plexinc/plex-media-player.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
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

CMAKE_IN_SOURCE_BUILD=1

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable cec CEC)
		$(cmake-utils_use_enable joystick SDL2)
		$(cmake-utils_use_enable lirc LIRC)
		-DQTROOT=/usr
	)

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
