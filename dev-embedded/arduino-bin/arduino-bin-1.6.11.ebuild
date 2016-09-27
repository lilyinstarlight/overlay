# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils

DESCRIPTION="electronics prototyping platform based on easy-to-use hardware and software"
HOMEPAGE="https://www.arduino.cc/"
MY_PN="${PN/-bin}"
MY_P="${MY_PN}-${PV}"
SRC_URI="
	amd64? ( https://downloads.arduino.cc/${MY_P}-linux64.tar.xz -> ${MY_P}-linux64.tar.xz )
	x86? ( https://downloads.arduino.cc/${MY_P}-linux32.tar.xz -> ${MY_P}-linux32.tar.xz )
"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

RESTRICT="binchecks preserve-libs strip"

src_install() {
	newicon lib/arduino.png "${MY_PN}".png
	make_desktop_entry "${MY_PN}" Arduino "${MY_PN}"

	mkdir -p "${D}"/opt/"${PN}"
	cp -a * "${D}"/opt/"${PN}"

	make_wrapper ${MY_PN} "${EROOT}opt/${PN}/${MY_PN}" "${EROOT}opt/${PN}"
}
