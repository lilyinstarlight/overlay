# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-mod

DESCRIPTION="Non-fuse kernel driver for exFat and VFat file systems"
HOMEPAGE="https://github.com/dorimanx/exfat-nofuse"

COMMIT="01c30ad52625a7261e1b0d874553b6ca7af25966"
SRC_URI="https://github.com/dorimanx/${PN}/archive/${COMMIT}.tar.gz -> ${PN}-${COMMIT}.tar.gz
	https://patch-diff.githubusercontent.com/raw/dorimanx/exfat-nofuse/pull/137.patch -> ${PN}-${COMMIT}.linux-4.18.patch"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}-${COMMIT}"

MODULE_NAMES="exfat(kernel/fs:${S})"
BUILD_TARGETS="all"

PATCHES=( "${DISTDIR}/${PN}-${COMMIT}.linux-4.18.patch" )

src_prepare(){
	sed -i -e "/^KREL/,2d" Makefile || die

	default
}
src_compile(){
	BUILD_PARAMS="KDIR=${KV_OUT_DIR} M=${S}"
	linux-mod_src_compile
}
