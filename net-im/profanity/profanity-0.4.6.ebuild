# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools

DESCRIPTION="Ncurses based jabber client inspired by irssi"
HOMEPAGE="http://www.profanity.im/"
SRC_URI="http://www.profanity.im/${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libnotify otr +themes xscreensaver"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libstrophe
	net-misc/curl
	sys-libs/ncurses
	otr? ( net-libs/libotr )
	xscreensaver? ( x11-libs/libXScrnSaver )
	libnotify? ( x11-libs/libnotify )
"
DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable libnotify notifications) \
		$(use_enable otr) \
		$(use_with themes) \
		$(use_with xscreensaver)
}

pkg_postinst() {
	elog
	elog "User guide is available online:"
	elog "  http://www.profanity.im/userguide.html"
	elog
}
