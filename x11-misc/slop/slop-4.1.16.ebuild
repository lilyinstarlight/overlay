# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="slop (Select Operation) is an application that queries the user for a selection and prints it out"
HOMEPAGE="https://github.com/naelstrof/slop"
SRC_URI="https://github.com/naelstrof/slop/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	x11-libs/libX11
	x11-libs/libXext
"
RDEPEND="
	${DEPEND}
"

src_prepare() {
	epatch "${FILESDIR}"/no-cppcheck.patch
	epatch "${FILESDIR}"/no-gengetopt.patch
	#Apparently librt is necessary to compile for Ubuntu
	#It isn't needed or marked as a dependency here so be sure it isn't compiled with it
	epatch "${FILESDIR}"/no-librt.patch
}
