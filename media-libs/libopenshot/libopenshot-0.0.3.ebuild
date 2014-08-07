# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils eutils

DESCRIPTION="A high quality, open-source video editing, animation, and playback library for C++, Python, and Ruby."
HOMEPAGE="http://openshot.org/"
SRC_URI="
	https://launchpad.net/libopenshot/0.0/${PV}/+download/${P}.tar.gz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"

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
