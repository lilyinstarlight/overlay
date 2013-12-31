# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit eutils savedconfig toolchain-funcs git-2

DESCRIPTION="an advanced status tool for dwm"
HOMEPAGE="http://github.com/fkmclane/dwm"
EGIT_REPO_URI="https://github.com/fkmclane/dwm.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="alsa"

DEPEND="x11-libs/libX11
	alsa? (
		media-libs/alsa-lib
		)"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i \
		-e "s/CFLAGS = -std=c99 -pedantic -Wall -Os/CFLAGS += -std=c99 -pedantic -Wall/" \
		-e "/^LDFLAGS/{s|=|+=|g;s|-s ||g}" \
		-e "s/#ALSALIBS =/ALSALIBS ?=/" \
		-e "s/#ALSAFLAGS =/ALSAFLAGS ?=/" \
		-e "s@/usr/X11R6/include@${EPREFIX}/usr/include/X11@" \
		-e "s@/usr/X11R6/lib@${EPREFIX}/usr/lib@" \
		-e "s@-I/usr/include@@" -e "s@-L/usr/lib@@" \
		dwmstatus/config.mk || die
	sed -i \
		-e '/@echo CC/d' \
		-e 's|@${CC}|$(CC)|g' \
		dwmstatus/Makefile || die

	restore_config dwmstatus/config.h
	epatch_user
}

src_compile() {
	if use alsa; then
		emake CC=$(tc-getCC) -C dwmstatus dwmstatus
	else
		emake CC=$(tc-getCC) ALSAFLAGS="" ALSALIBS="" -C dwmstatus dwmstatus
	fi
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" -C dwmstatus install

	save_config dwmstatus/config.h
}

pkg_postinst() {
	einfo "This ebuild has support for user defined configs"
	einfo "Please read this ebuild for more details and re-emerge as needed"
	einfo "if you want to add or remove functionality for ${PN}"
}
