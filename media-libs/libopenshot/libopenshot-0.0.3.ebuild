# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils eutils

DESCRIPTION="A high quality, open-source video editing, animation, and playback library for C++, Python, and Ruby"
HOMEPAGE="http://openshot.org/"
SRC_URI="https://launchpad.net/libopenshot/0.0/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	media-gfx/imagemagick
	virtual/ffmpeg
	=media-libs/libopenshot-audio-${PV}
	>=media-libs/libsdl-1.2
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5[widgets]
	dev-qt/qtwidgets:5
"
DEPEND="
	${RDEPEND}
	dev-lang/swig
	dev-util/unittest++
"

src_prepare() {
	epatch "${FILESDIR}/qtexebug.patch"
}
