# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit linux-mod

DESCRIPTION="Non-fuse kernel driver for exFat and VFat file systems"
HOMEPAGE="https://github.com/dorimanx/exfat-nofuse"

COMMIT="a877c799d00eb0618aad15c6658650dac9a18a45"
SRC_URI="https://github.com/dorimanx/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}-${COMMIT}"

MODULE_NAMES="exfat(kernel/fs:${S})"
BUILD_TARGETS="all"

src_prepare(){
	sed -i -e "/^KREL/,2d" Makefile || die

	default
}
src_compile(){
	BUILD_PARAMS="KDIR=${KV_OUT_DIR} M=${S}"
	linux-mod_src_compile
}
