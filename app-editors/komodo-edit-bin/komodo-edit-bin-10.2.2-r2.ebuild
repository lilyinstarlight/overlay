# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python2_7 )
inherit eutils python-single-r1 pax-utils

MY_BUILD="17703"

DESCRIPTION="Freeware advanced editor for dynamic and Web languages"
HOMEPAGE="http://www.activestate.com/products/komodo_edit"
LICENSE="
	MPL-1.1
	MIT
	Boost-1.0
	CC-BY-2.5
	CC-BY-3.0
	SilverCity
	LGPL-2.1
	LGPL-3
	PSF-2
	Apache-2.0
	OFL-1.1"

SRC_URI="x86? ( http://downloads.activestate.com/Komodo/releases/${PV}/Komodo-Edit-${PV}-${MY_BUILD}-linux-x86.tar.gz )
	 amd64? ( http://downloads.activestate.com/Komodo/releases/${PV}/Komodo-Edit-${PV}-${MY_BUILD}-linux-x86_64.tar.gz )"

SLOT="0"
KEYWORDS="~x86 ~amd64"

RESTRICT="strip mirror"

IUSE="pax_kernel"

RDEPEND="
	virtual/jpeg
	virtual/libc
	x11-libs/gtk+
	x11-libs/pango
	x11-base/xorg-server
	x11-libs/gdk-pixbuf
	gnome-base/libgnomeui
	gnome-base/libgnome
	!app-editors/komodo-edit"

QA_PREBUILT="*"
QA_FLAGS_IGNORED="*"
QA_PRESTRIPPED="*"

S="${WORKDIR}"

src_install() {
	if use amd64; then
		S="${WORKDIR}"/Komodo-Edit-"${PV}"-"${MY_BUILD}"-linux-"${ARCH/amd64/x86_64}"
	fi

	if use x86; then
		S="${WORKDIR}"/Komodo-Edit-"${PV}"-"${MY_BUILD}"-linux-"${ARCH/x86/x86}"
	fi

	if use pax_kernel; then
		pax-mark m "${S}"/INSTALLDIR/lib/mozilla/komodo
	fi

	insinto /opt/"${PN}"
	doins -r "${S}"/INSTALLDIR/share
	mv "${S}"/INSTALLDIR/lib "${ED}opt/${PN}/" || die "Installation failed"

	make_wrapper komodo-edit "${EPREFIX}"/opt/"${PN}"/lib/mozilla/komodo "${EPREFIX}"/opt/"${PN}"/lib/mozilla /usr/bin

	newicon "${S}/INSTALLDIR/share/icons/komodo48.png" komodo-edit48.png

	make_desktop_entry \
		"${EPREFIX}/usr/bin/komodo-edit" \
		"Komodo Edit 10" \
		"${EPREFIX}/opt/${PN}/share/icons/komodo48.png" \
		"Development;IDE;TextEditor" \
		|| die "make_desktop_entry failed"
}
