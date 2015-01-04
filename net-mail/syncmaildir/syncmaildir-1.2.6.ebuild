# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Sync Mail Dir (smd) is a set of tools to synchronize a pair of mailboxes in Maildir format"
HOMEPAGE="http://syncmaildir.sourceforge.net/"
SRC_URI="mirror://sourceforge/syncmaildir/syncmaildir-1.2.6.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"

COMMON="
	dev-libs/glib:2
	gnome? (
		dev-lang/vala:0.22
		x11-libs/libnotify
		gnome-base/gconf:2
		dev-libs/libgee:0
	)
"
DEPEND="
	${COMMON}
	app-text/txt2man
"
RDEPEND="
	${COMMON}
	virtual/ssh
	dev-util/xdelta
	dev-lang/lua
"

src_prepare() {
	epatch "${FILESDIR}"/makefile-destdir.patch
	epatch "${FILESDIR}"/makefile-respect-variables.patch
	use gnome && epatch "${FILESDIR}"/vala-unowned.patch || epatch "${FILESDIR}"/no-applet.patch
}

src_compile() {
	#Parallel builds sometimes fail
	emake -j1
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}

pkg_postinst() {
	einfo "Sync Mail Dir must be installed on both the"
	einfo "client and the server between which mail will"
	einfo "be synchronized."
	einfo
	einfo "See http://syncmaildir.sourceforge.net/ for"
	einfo "configuration and security information."
}
