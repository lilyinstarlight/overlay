# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils udev versionator

DESCRIPTION="electronics prototyping platform for TI MSP430 LaunchPad based on Arduino"
HOMEPAGE="http://energia.nu/"
MY_PN="${PN/-bin}"
VER="$(get_version_component_range 1-3)"
REL="$(get_version_component_range 4)"
REL="${REL/p}"
MY_PV="${VER}E${REL}"
MY_P="${MY_PN}-${MY_PV}"
SRC_URI="
	http://energia.nu/downloads/downloadv4.php?file=${MY_P}-linux64.tar.xz -> ${MY_P}-linux64.tar.xz
	http://energia.nu/files/71-ti-permissions.rules
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

DEPEND=""
RDEPEND="sys-libs/glibc[multilib]"

S="${WORKDIR}/${MY_P}"

RESTRICT="binchecks preserve-libs strip"

src_unpack() {
	unpack "${MY_P}"-linux64.tar.xz
	cp "${DISTDIR}"/71-ti-permissions.rules "${WORKDIR}" || die
}

src_install() {
	newicon lib/arduino.png "${MY_PN}".png
	make_desktop_entry "${MY_PN}" Energia "${MY_PN}"

	mkdir -p "${D}"/opt/"${PN}" || die
	cp -a * "${D}"/opt/"${PN}" || die

	make_wrapper ${MY_PN} "${EROOT}opt/${PN}/${MY_PN}" "${EROOT}opt/${PN}"

	udev_dorules "${WORKDIR}"/71-ti-permissions.rules
}

pkg_postinst() {
	udev_reload
}
