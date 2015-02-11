# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit cmake-utils eutils python-single-r1

DESCRIPTION="Plex Home Theater"
HOMEPAGE="http://plex.tv/"

MY_PN="plex-home-theater-public"
MAGIC="431-7966a4df"
MY_PV="${PV}.${MAGIC}"
MY_P="${MY_PN}-${MY_PV}"

SRC_URI="https://github.com/plexinc/${MY_PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="pulseaudio"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

CDEPEND="
	app-pda/libplist
	dev-db/sqlite:3
	dev-libs/boost
	dev-libs/fribidi
	dev-libs/libcdio
	<dev-libs/libcec-2.2.0
	dev-libs/lzo
	dev-libs/tinyxml
	dev-libs/yajl
	media-libs/fontconfig
	media-libs/ftgl
	media-libs/glew
	media-libs/libass
	media-libs/libjpeg-turbo
	media-libs/libmad
	media-libs/libmodplug
	media-libs/libmpeg2
	media-libs/libsamplerate
	media-libs/libshairport
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/taglib
	media-sound/lame
	media-video/rtmpdump
	net-fs/samba[smbclient]
	net-libs/libmicrohttpd
	net-libs/libssh
	net-misc/curl
	virtual/libusb
	virtual/opengl
	x11-libs/libva
	x11-libs/libXrandr
"
RDEPEND="
	${CDEPEND}
	virtual/jre
	${PYTHON_DEPS}
"
DEPEND="
	${CDEPEND}
	virtual/jdk
	dev-lang/swig
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/cmake-fribidi.patch"
	use pulseaudio || epatch "${FILESDIR}/nopulse.patch"

	#Patch ffmpeg building to use MAKEOPTS
	sed -i -e "s/BUILD_COMMAND make -j 4/BUILD_COMMAND make ${MAKEOPTS}/" lib/ffmpeg/CMakeLists.txt

	#Save git revision for Plex version string
	#echo ${COMMIT:0:8} > GitRevision.txt
}

src_configure() {
	local mycmakeargs=( -DCMAKE_BUILD_TYPE='Release' -DCMAKE_INSTALL_PREFIX='/opt/plexhometheater' -DENABLE_AUTOUPDATE='FALSE' -DENABLE_DUMP_SYMBOLS='FALSE' -DENABLE_PYTHON='TRUE' -DPYTHON_EXEC='/usr/bin/python2' -DUSE_INTERNAL_FFMPEG='TRUE' -DCREATE_BUNDLE='FALSE' )
	cmake-utils_src_configure
}

src_compile() {
	#Parallel build sometimes fails
	cmake-utils_src_compile -j1
}

src_install() {
	cmake-utils_src_install

	doicon "plex/Resources/plexhometheater.png"
	domenu "plex/Resources/plexhometheater.desktop"

	dobin "${FILESDIR}/plexhometheater"
}
