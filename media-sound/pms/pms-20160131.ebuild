# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit autotools git-r3

DESCRIPTION="Practical Music Search: an open source ncurses client for mpd, written in C++"
HOMEPAGE="https://ambientsound.github.io/pms/"
EGIT_REPO_URI="git://github.com/ambientsound/${PN}.git https://github.com/ambientsound/${PN}.git"
EGIT_COMMIT="fcc4704"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="regex"

RDEPEND="
	dev-libs/glib:2
	media-libs/libmpdclient
	sys-libs/ncurses:=
"
DEPEND="
	app-text/pandoc
	dev-util/intltool
	regex? ( >=sys-devel/gcc-4.9 )
	${RDEPEND}
"

src_prepare() {
	eautoreconf

	default
}

src_configure() {
	econf \
		$(use_enable regex)
}
