# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils systemd unpacker user

DESCRIPTION="Plex Media Server is an organizer for your media and provides streaming over the web and to devices"
HOMEPAGE="http://plex.tv/"

MY_PN="plexmediaserver"
BUILD="1544"
COMMIT="651f92a"
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
KEYWORDS=""
IUSE=""

DEPEND="
	net-dns/avahi
"
RDEPEND="
	${DEPEND}
"

S="${WORKDIR}"

RESTRICT="mirror"
QA_PREBUILT="*"

pkg_setup() {
	enewgroup plex
	enewuser plex -1 /bin/sh /var/lib/plexmediaserver "plex" --system
}

src_prepare() {
	epatch "${FILESDIR}/start_pms_opt.patch"
}

src_install() {
	#Package contents
	insinto /etc/default
	doins etc/default/plexmediaserver

	dodir /opt/plexmediaserver
	cp -R usr/lib/plexmediaserver/* "${D}"/opt/plexmediaserver/

	dobin usr/sbin/start_pms

	domenu usr/share/applications/plexmediamanager.desktop
	doicon usr/share/pixmaps/plexmediamanager.png

	dodoc usr/share/doc/plexmediaserver/copyright

	#Init files
	doinitd "${FILESDIR}"/plexmediaserver
	systemd_dounit "${FILESDIR}"/plexmediaserver.service

	#Directories
	dodir /var/lib/plexmediaserver
	fowners plex:plex /var/lib/plexmediaserver
	dodir /var/log/pms
	fowners plex:plex /var/log/pms
}

pkg_postinst() {
	einfo "To start Plex Media Server, use the plexmediaserver init script or systemd unit."
	einfo "To manage your library and sign in to Plex, go to \"http://localhost:32400/web\"."
}
