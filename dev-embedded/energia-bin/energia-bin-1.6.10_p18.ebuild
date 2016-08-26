# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils udev

DESCRIPTION="electronics prototyping platform for Texas Instruments MSP430 LaunchPad based on Wiring and Arduino"
HOMEPAGE="http://energia.nu/"
MY_PN="${PN/-bin}"
MY_P="${MY_PN}-1.6.10E18"
SRC_URI="
	http://energia.nu/downloads/downloadv4.php?file=${MY_P}-linux64.tar.xz -> ${MY_P}-linux64.tar.xz
	http://energia.nu/files/71-ti-permissions.rules
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

RESTRICT="binchecks strip"

src_unpack() {
	unpack "${MY_P}"-linux64.tar.xz
	cp "${DISTDIR}"/71-ti-permissions.rules "${WORKDIR}"
}

src_install() {
	newicon lib/arduino.png "${MY_PN}".png
	make_desktop_entry "${MY_PN}" Energia "${MY_PN}"

	mkdir -p "${D}"/opt/"${PN}"
	cp -a * "${D}"/opt/"${PN}"

	make_wrapper ${MY_PN} "${EROOT}opt/${PN}/${MY_PN}" "${EROOT}opt/${PN}"

	udev_dorules "${WORKDIR}"/71-ti-permissions.rules
}

pkg_postinst() {
	udev_reload
}
