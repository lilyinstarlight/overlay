# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils udev versionator

DESCRIPTION="USB-based electronics prototyping platform compatible with Arduino"
HOMEPAGE="https://www.pjrc.com/teensy/"

MY_PV="$(replace_all_version_separators '')"
MY_PN="${PN/-bin}"
MY_P="${MY_PN}-${PV}"

ARDUINO_PN="arduino"
ARDUINO_PV="1.8.5"
ARDUINO_P="${ARDUINO_PN}-${ARDUINO_PV}"

SRC_URI="
	amd64? ( https://file.fooster.io/overlay/${MY_P}-linux64.tar.xz )
	x86? ( https://file.fooster.io/overlay/${MY_P}-linux32.tar.xz )
"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/libusb:0"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

RESTRICT="binchecks preserve-libs strip"

src_unpack() {
	if use amd64; then
		unpack "${MY_P}"-linux64.tar.xz
	else
		unpack "${MY_P}"-linux32.tar.xz
	fi

	cp "${FILESDIR}"/49-teensy.rules "${WORKDIR}" || die
}

src_install() {
	newicon lib/arduino.png "${MY_PN}".png
	make_desktop_entry "${MY_PN}" Teensyduino "${MY_PN}"

	mkdir -p "${D}"/opt/"${PN}" || die
	cp -a * "${D}"/opt/"${PN}" || die

	make_wrapper ${MY_PN} "${EROOT}opt/${PN}/${ARDUINO_PN}" "${EROOT}opt/${PN}"

	udev_dorules "${WORKDIR}"/49-teensy.rules
}

pkg_postinst() {
	udev_reload

	elog "Initial setup for your Teensy requires you to plug in the board,"
	elog "verify a sketch, then press the reset button on the board. After"
	elog "that, you can use the upload button."
}
