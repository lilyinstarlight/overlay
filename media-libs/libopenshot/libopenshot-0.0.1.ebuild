# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils bzr

DESCRIPTION="An open-source, cross-platform C++ library for video editing, animation, and playback"
HOMEPAGE="http://openshot.org/"
EBZR_REPO_URI="lp:libopenshot"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="
	media-gfx/imagemagick
	virtual/ffmpeg
	media-libs/libopenshot-audio
	>=media-libs/libsdl-1.2
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5
	dev-lang/swig
"
DEPEND="
	${RDEPEND}
"
