# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils udev versionator

DESCRIPTION="USB-based electronics prototyping platform compatible with Arduino"
HOMEPAGE="https://www.pjrc.com/teensy/"

MY_PV="$(replace_all_version_separators '')"
MY_PN="${PN/-bin}"
MY_P="${MY_PN}-${PV}"

ARDUINO_PN="arduino"
ARDUINO_PV="1.6.11"
ARDUINO_P="${ARDUINO_PN}-${ARDUINO_PV}"

SRC_URI="
	amd64? (
		https://downloads.arduino.cc/${ARDUINO_P}-linux64.tar.xz -> ${ARDUINO_P}-linux64.tar.xz
		https://file.fooster.io/overlay/${MY_P}-linux64.patch
	)

	x86? (
		https://downloads.arduino.cc/${ARDUINO_P}-linux32.tar.xz -> ${ARDUINO_P}-linux32.tar.xz
		https://file.fooster.io/overlay/${MY_P}-linux32.patch
	)

	http://pjrc.com/teensy/49-teensy.rules
"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${ARDUINO_P}"

RESTRICT="binchecks strip"

src_unpack() {
	if use amd64; then
		unpack "${ARDUINO_P}"-linux64.tar.xz
		cp "${DISTDIR}"/"${MY_P}"-linux64.patch "${WORKDIR}"
	else
		unpack "${ARDUINO_P}"-linux32.tar.xz
		cp "${DISTDIR}"/"${MY_P}"-linux32.patch "${WORKDIR}"
	fi

	cp "${DISTDIR}"/49-teensy.rules "${WORKDIR}"
}

src_prepare() {
	use amd64 && epatch ../"${MY_P}"-linux64.patch
	use x86 && epatch ../"${MY_P}"-linux32.patch

	default
}

src_install() {
	newicon lib/arduino.png "${MY_PN}".png
	make_desktop_entry "${MY_PN}" Teensyduino "${MY_PN}"

	mkdir -p "${D}"/opt/"${PN}"
	cp -a * "${D}"/opt/"${PN}"

	make_wrapper ${MY_PN} "${EROOT}opt/${PN}/${ARDUINO_PN}" "${EROOT}opt/${PN}"

	udev_dorules "${WORKDIR}"/49-teensy.rules
}

pkg_postinst() {
	udev_reload

	elog "Initial setup for your Teensy requires you to plug in the board,"
	elog "verify a sketch, then press the reset button on the board. After"
	elog "that, you can use the upload button."
}
