# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="Plex Home Theater"
HOMEPAGE="http://plex.tv/"
SRC_URI="https://github.com/plexinc/plex-home-theater-public/archive/pht-v${PV}.tar.gz"
S="${WORKDIR}/plex-home-theater-public-pht-v${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

CDEPEND="
	app-pda/libplist
	dev-db/sqlite:3
	dev-lang/python:2.7
	dev-libs/boost
	dev-libs/fribidi
	dev-libs/libcdio
	dev-libs/libcec
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
"
DEPEND="
	${CDEPEND}
	virtual/jdk
	dev-lang/swig
"

src_prepare() {
	epatch "${FILESDIR}/cmake-fribidi.patch"
}

src_configure() {
	mkdir build && cd build

	cmake .. -DCMAKE_BUILD_TYPE='Release' -DCMAKE_INSTALL_PREFIX='/opt/plexhometheater' -DENABLE_{AUTOUPDATE,DUMP_SYMBOLS}='FALSE' -DENABLE_PYTHON='TRUE' -DPYTHON_EXEC='/usr/bin/python2' -DUSE_INTERNAL_FFMPEG='TRUE' -DCREATE_BUNDLE='FALSE'
}

src_install() {
	emake DESTDIR="${D}" install

	doicon ${S}/plex/Resources/plexhometheater.png
	domenu ${S}/plex/Resources/plexhometheater.desktop

	doexe ${FILESDIR}/plexhometheater.sh
}
