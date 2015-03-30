# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Open Broadcaster Software is free and open source software for video recording and live streaming."
HOMEPAGE="https://obsproject.com/"
SRC_URI="https://github.com/jp9000/obs-studio/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fdk imagemagick +pulseaudio +qt5 truetype v4l"

DEPEND="
	>=dev-libs/jansson-2.5
	media-libs/x264
	media-video/ffmpeg
	x11-libs/libXinerama
	x11-libs/libXcomposite
	x11-libs/libXrandr

	fdk? ( media-libs/fdk-aac )
	imagemagick? ( media-gfx/imagemagick )
	pulseaudio? ( media-sound/pulseaudio )
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtdeclarative:5
		dev-qt/qtgui:5
		dev-qt/qtmultimedia:5
		dev-qt/qtnetwork:5
		dev-qt/qtquickcontrols:5
		dev-qt/qtsql:5
		dev-qt/qttest:5
		dev-qt/qtwidgets:5
		dev-qt/qtx11extras:5
	)
	truetype? (
		media-libs/fontconfig
		media-libs/freetype
	)
	v4l? ( media-libs/libv4l )
"
RDEPEND="${DEPEND}"

src_prepare() {
	CMAKE_REMOVE_MODULES_LIST=(FindFreetype)

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package fdk Libfdk)
		$(cmake-utils_use imagemagick LIBOBS_PREFER_IMAGEMAGICK)
		$(cmake-utils_use_find_package pulseaudio PulseAudio)
		$(cmake-utils_use_enable qt5 UI)
		$(cmake-utils_use_disable qt5 UI)
		$(cmake-utils_use_find_package truetype Freetype)
		$(cmake-utils_use_find_package v4l Libv4l2)
		-DUNIX_STRUCTURE=1
	)

	cmake-utils_src_configure
}

pkg_postinst() {
	if ! use pulseaudio; then
		ewarn "Without PulseAudio, you will not have audio capture capability."
	fi
}
