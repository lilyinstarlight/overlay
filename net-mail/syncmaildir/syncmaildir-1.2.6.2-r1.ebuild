# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils systemd

DESCRIPTION="Sync Mail Dir (smd) is a set of tools to synchronize a pair of mailboxes"
HOMEPAGE="http://syncmaildir.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"

CDEPEND="
	>=dev-libs/glib-2.32:2
	gnome? (
		dev-libs/dbus-glib
		x11-libs/gtk+:3
		dev-lang/vala:*
		x11-libs/libnotify
		gnome-base/gconf:2
		dev-libs/libgee:0.8
	)
"
DEPEND="
	${CDEPEND}
	app-text/txt2man
"
RDEPEND="
	${CDEPEND}
	virtual/ssh
	dev-util/xdelta:0
	dev-lang/lua
"

src_prepare() {
	epatch "${FILESDIR}"/makefile-destdir.patch
	epatch "${FILESDIR}"/makefile-respect-variables.patch
	epatch "${FILESDIR}"/makefile-no-doc.patch
	epatch "${FILESDIR}"/lua-no-slot.patch

	use gnome || epatch "${FILESDIR}"/no-applet.patch

	default
}

src_compile() {
	#Parallel builds sometimes fail
	emake -j1
}

src_install() {
	emake DESTDIR="${D}" PREFIX="usr" install

	systemd_douserunit "${FILESDIR}"/smd-loop.service

	dodoc README KNOWN_BUGS DESIGN ChangeLog
	dodoc -r sample-hooks
}

pkg_postinst() {
	einfo "Sync Mail Dir must be installed on both the"
	einfo "client and the server between which mail will"
	einfo "be synchronized."
	einfo
	einfo "See http://syncmaildir.sourceforge.net/ for"
	einfo "configuration and security information."
}
