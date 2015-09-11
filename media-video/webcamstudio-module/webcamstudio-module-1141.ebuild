# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

S="${WORKDIR}/vloopback"

inherit eutils linux-mod toolchain-funcs

DESCRIPTION="Kernel module and helper library for WebcamStudio"
HOMEPAGE="https://code.google.com/p/webcamstudio/"

SRC_URI="mirror://sourceforge/webcamstudio/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

MODULE_NAMES="webcamstudio(misc:${S})"
CONFIG_CHECK="VIDEO_DEV"

pkg_setup() {
	linux-mod_pkg_setup

	rm -f Makefile

	BUILD_PARAMS="-C ${KV_DIR} SUBDIRS=${S} KERNEL_DIR=${KV_DIR}"
	BUILD_TARGETS="modules"
	MODULESD_WEBCAMSTUDIO_ENABLED="yes"
}

src_compile() {
	# We use manual compile of the lib so be compliant to Gentoo flags
	einfo "Compiling helper library"
	$(tc-getCC) \
		${CPPFLAGS} ${CFLAGS} \
		-fPIC \
		-c -o libwebcamstudio.o libwebcamstudio.c
	$(tc-getCC) \
		${CPPFLAGS} ${CFLAGS} ${LDFLAGS} \
		-fPIC \
		-shared -Wl,-soname,libwebcamstudio.so \
		-o libwebcamstudio.so.1.0.1  \
		libwebcamstudio.o
	ln -s libwebcamstudio.so.1.0.1 libwebcamstudio.so

	linux-mod_src_compile
}

src_install() {
	einfo "Installing helper library"
	dolib libwebcamstudio.so libwebcamstudio.so.1.0.1

	linux-mod_src_install
}
