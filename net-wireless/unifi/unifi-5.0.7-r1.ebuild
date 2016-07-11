# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit multilib systemd user

DESCRIPTION="Management Controller for Ubiquiti Networks UniFi APs"
HOMEPAGE="http://wiki.ubnt.com/UniFi_FAQ"
MY_PN="UniFi"
SRC_URI="http://dl.ubnt.com/unifi/${PV}/${MY_PN}.unix.zip -> ${P}.zip"

LICENSE="UniFi-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	dev-db/mongodb
	virtual/jre
"

S="${WORKDIR}/${MY_PN}"

RESTRICT="mirror preserve-libs"
QA_PREBUILT="*"

pkg_setup() {
	enewgroup unifi
	enewuser unifi -1 /bin/sh /var/lib/unifi "unifi" --system
}

src_install() {
	dodir /usr/$(get_libdir)/unifi

	cp -R "${S}"/* "${D}"/usr/$(get_libdir)/unifi

	keepdir /var/lib/unifi/data
	dodir /var/lib/unifi/work
	dodir /var/log/unifi

	fowners -R unifi:unifi /var/lib/unifi
	fowners -R unifi:unifi /var/log/unifi

	dosym /var/lib/unifi/data /usr/$(get_libdir)/unifi/data
	dosym /var/lib/unifi/work /usr/$(get_libdir)/unifi/work
	dosym /var/log/unifi /usr/$(get_libdir)/unifi/logs

	echo 'CONFIG_PROTECT="/var/lib/unifi/data/system.properties"' >99unifi
	doenvd 99unifi

	newconfd "${FILESDIR}/${PN}.conf" "${PN}"
	newinitd "${FILESDIR}/${PN}.init" "${PN}"

	systemd_dounit "${FILESDIR}/${PN}.service"
}
