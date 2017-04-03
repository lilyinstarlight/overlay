# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_6,2_7} )

inherit cmake-utils eutils python-single-r1

DESCRIPTION="Plex Home Theater"
HOMEPAGE="http://plex.tv/"

MY_PN="plex-home-theater-public"
BUILD="469"
COMMIT="47a90f01"
MY_PV="${PV}.${BUILD}-${COMMIT}"
MY_P="${MY_PN}-${MY_PV}"

SRC_URI="https://github.com/plexinc/${MY_PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="pulseaudio"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

CDEPEND="
	app-arch/bzip2
	app-pda/libplist
	dev-db/sqlite:3
	dev-libs/boost
	dev-libs/fribidi
	dev-libs/libcdio[-minimal]
	dev-libs/libcec
	dev-libs/libpcre[cxx]
	dev-libs/lzo:2
	dev-libs/tinyxml[stl]
	dev-libs/yajl
	media-libs/alsa-lib
	media-libs/flac
	media-libs/fontconfig
	media-libs/freetype
	media-libs/glew:0
	media-libs/libass
	media-libs/libmad
	media-libs/libmodplug
	media-libs/libmpeg2
	media-libs/libogg
	media-libs/libpng:*
	media-libs/libsamplerate
	media-libs/libsdl[alsa,sound,opengl,video,X]
	media-libs/libshairport
	media-libs/libvorbis
	media-libs/sdl-image[gif,jpeg,png]
	media-libs/sdl-mixer
	media-libs/taglib
	media-libs/tiff:*
	media-sound/lame
	pulseaudio? ( media-sound/pulseaudio )
	media-video/rtmpdump
	net-dns/avahi
	net-fs/samba[smbclient(+)]
	net-libs/libmicrohttpd[messages]
	net-libs/libssh
	net-misc/curl
	sys-apps/dbus
	sys-libs/libcap
	sys-libs/zlib
	virtual/jpeg:*
	virtual/libiconv
	virtual/libusb:*
	virtual/opengl
	x11-libs/libva[opengl]
	x11-libs/libvdpau
	x11-libs/libX11
	x11-libs/libXrandr
	${PYTHON_DEPS}
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

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/cmake-fribidi.patch"
	epatch "${FILESDIR}/cmake-dbus.patch"
	epatch "${FILESDIR}/libcec.patch"
	use pulseaudio || epatch "${FILESDIR}/nopulse.patch"

	#Patch ffmpeg building to use MAKEOPTS
	sed -i -e "s/BUILD_COMMAND make -j 4/BUILD_COMMAND make ${MAKEOPTS}/" lib/ffmpeg/CMakeLists.txt || die

	#Save git revision for Plex version string
	echo ${COMMIT} > GitRevision.txt || die

	default
}

src_configure() {
	#Set build number for Plex version string
	export BUILD_NUMBER=${BUILD}

	local mycmakeargs=( -DCMAKE_BUILD_TYPE='Release' -DCMAKE_INSTALL_PREFIX='/opt/plexhometheater' -DENABLE_AUTOUPDATE='FALSE' -DENABLE_DUMP_SYMBOLS='FALSE' -DENABLE_PYTHON='TRUE' -DPYTHON_EXEC='/usr/bin/python2' -DUSE_INTERNAL_FFMPEG='TRUE' -DCREATE_BUNDLE='FALSE' )
	cmake-utils_src_configure
}

src_compile() {
	#Parallel build sometimes fails
	cmake-utils_src_compile -j1
}

src_install() {
	cmake-utils_src_install

	#Build system puts a bunch of useless symbolic links in /opt/plexhometheater/bin
	find "${D}"/opt/plexhometheater/bin/ -maxdepth 1 -type l -exec rm -f \{\} \; || die

	doicon "plex/Resources/plexhometheater.png"
	domenu "plex/Resources/plexhometheater.desktop"

	dobin "${FILESDIR}/plexhometheater"
}
