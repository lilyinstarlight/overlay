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
IUSE="airplay cec +opengl pulseaudio +samba +usb +xrandr"

CDEPEND="
	dev-lang/python:2.7
	dev-libs/boost
	dev-libs/libcdio
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
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/taglib
	media-sound/lame
	media-video/rtmpdump
	net-libs/libmicrohttpd
	net-libs/libssh
	net-misc/curl
	x11-libs/libva

	airplay? ( app-pda/libplist )
	cec? ( dev-libs/libcec )
	opengl? ( virtual/opengl )
	samba? ( net-fs/samba[smbclient] )
	xrandr? ( x11-libs/libXrandr )
	usb? ( virtual/libusb )
"
RDEPEND="
	${CDEPEND}
	virtual/jre
	pulseaudio? ( media-sound/pulseaudio )
"
DEPEND="
	${CDEPEND}
	virtual/jdk
	dev-lang/swig
"

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
