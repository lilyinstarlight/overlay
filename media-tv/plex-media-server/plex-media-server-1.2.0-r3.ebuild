# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils pax-utils systemd unpacker user

DESCRIPTION="Plex Media Server is an organizer for your media and provides streaming over the web and to devices"
HOMEPAGE="http://plex.tv/"

MY_PN="plexmediaserver"
BUILD="2765"
COMMIT="2d034d4"
MY_PV="${PV}.${BUILD}-${COMMIT}"
MY_P="${MY_PN}_${MY_PV}"

SRC_URI="
	x86? (
		https://downloads.plex.tv/plex-media-server/${MY_PV}/${MY_P}_i386.deb
	)
	amd64? (
		https://downloads.plex.tv/plex-media-server/${MY_PV}/${MY_P}_amd64.deb
	)
"

LICENSE="PMS-EULA"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="pax_kernel"

DEPEND="
	net-dns/avahi
"
RDEPEND="
	${DEPEND}
"

S="${WORKDIR}"

RESTRICT="mirror preserve-libs"
QA_PREBUILT="*"

pkg_setup() {
	enewgroup plex
	enewuser plex -1 /bin/sh /var/lib/plexmediaserver "plex"
}

src_prepare() {
	epatch "${FILESDIR}/start_pms.patch"

	default
}

src_install() {
	# package contents
	insinto /etc/default
	doins etc/default/plexmediaserver

	dodir /opt/plexmediaserver
	cp -R usr/lib/plexmediaserver/* "${D}"/opt/plexmediaserver/

	if use pax_kernel; then
		pax-mark m "${D}"/opt/plexmediaserver/Plex\ Media\ Server
		pax-mark m "${D}"/opt/plexmediaserver/Plex\ Media\ Scanner
		pax-mark m "${D}"/opt/plexmediaserver/Plex\ DLNA\ Server
		pax-mark m "${D}"/opt/plexmediaserver/Plex\ Script\ Host
		pax-mark m "${D}"/opt/plexmediaserver/Plex\ Relay
		pax-mark m "${D}"/opt/plexmediaserver/libcrypto.so.1.0.0
		pax-mark m "${D}"/opt/plexmediaserver/libgnsdk_dsp.so.3.07.7
	fi

	dobin usr/sbin/start_pms

	domenu usr/share/applications/plexmediamanager.desktop
	doicon usr/share/pixmaps/plexmediamanager.png

	dodoc usr/share/doc/plexmediaserver/copyright

	# init files
	doinitd "${FILESDIR}"/plexmediaserver

	systemd_dounit "${FILESDIR}"/plexmediaserver.service

	# directories
	dodir /var/lib/plexmediaserver
	fowners plex:plex /var/lib/plexmediaserver
	dodir /var/log/pms
	fowners plex:plex /var/log/pms
}

pkg_postinst() {
	einfo "To start Plex Media Server, use the plexmediaserver init script or systemd unit."
	einfo "To manage your library and sign in to Plex, go to \"http://localhost:32400/web\"."
}
