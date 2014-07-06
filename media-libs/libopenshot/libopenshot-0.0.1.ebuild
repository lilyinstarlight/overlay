# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils eutils bzr

DESCRIPTION="A high quality, open-source video editing, animation, and playback library for C++, Python, and Ruby."
HOMEPAGE="http://openshot.org/"
EBZR_REPO_URI="lp:libopenshot"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="
	media-gfx/imagemagick
	virtual/ffmpeg
	=media-libs/libopenshot-audio-${PV}
	>=media-libs/libsdl-1.2
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5
	dev-lang/swig
	dev-util/unittest++
"
DEPEND="
	${RDEPEND}
"

src_prepare() {
	epatch "${FILESDIR}/qtexebug.patch"
}

src_configure() {
	local mycmakeargs=(
		-DMAGICKCORE_HDRI_ENABLE=1
		-DMAGICKCORE_QUANTUM_DEPTH=16
	)
	cmake-utils_src_configure
}
