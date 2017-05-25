# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python2_7 )
inherit eutils python-single-r1

MY_BUILD="17670"

DESCRIPTION="Freeware advanced editor for dynamic and Web languages"
HOMEPAGE="http://www.activestate.com/products/komodo_edit"
LICENSE="MPL-1.1"

SRC_URI="x86?	( http://downloads.activestate.com/Komodo/releases/${PV}/Komodo-Edit-${PV}-${MY_BUILD}-linux-x86.tar.gz )
	 amd64? ( http://downloads.activestate.com/Komodo/releases/${PV}/Komodo-Edit-${PV}-${MY_BUILD}-linux-x86_64.tar.gz )"

SLOT="0"
KEYWORDS="~x86 ~amd64"

RESTRICT="strip"

IUSE=""

DEPEND=""

RDEPEND="${DEPEND}
    virtual/jpeg
    virtual/libc
    x11-libs/gtk+
    x11-libs/pango
    x11-base/xorg-server
    x11-libs/gdk-pixbuf
    gnome-base/libgnomeui
    gnome-base/libgnome"

RESTRICT="mirror"

pkg_setup() {

	use amd64 && MY_ARCH='x86_64' || MY_ARCH=${ARCH}
	S="${WORKDIR}/Komodo-Edit-${PV}-${MY_BUILD}-linux-${MY_ARCH}"
}

src_install() {

	KOMODO_EDIT_INSTALLDIR="/opt/${P}"

	"${S}/install.sh" \
		--install-dir "${D}/${KOMODO_EDIT_INSTALLDIR}" \
		--dest-dir ${D}/${KOMODO_EDIT_INSTALLDIR} \
		--suppress-shortcut || die "original installer script failed"

	dosym "${D}/${KOMODO_EDIT_INSTALLDIR}/bin/komodo" "/usr/bin/${P}" &&
	dosym "./${P}" "/usr/bin/${PN}" ||
		die "failed dosym Komodo launcher script"

	rm -R "${D}/${KOMODO_EDIT_INSTALLDIR}/bin/komodo"
	dosym "${D}/${KOMODO_EDIT_INSTALLDIR}/lib/mozilla/komodo" "${KOMODO_EDIT_INSTALLDIR}/bin/komodo"

	dodoc "${D}/${KOMODO_EDIT_INSTALLDIR}/"lib/sdk/{CHANGELOG.txt,README.txt}
	dosym "${D}/${KOMODO_EDIT_INSTALLDIR}/share/icons/komodo48.png" \
		"/usr/share/pixmaps/${PN}.png" || die "dosym pixmap icon failed"

	dodir "${KOMODO_EDIT_INSTALLDIR}"

    make_desktop_entry \
        "${KOMODO_EDIT_INSTALLDIR}/bin/${PN}" \
        "Komodo Edit" \
        "${KOMODO_EDIT_INSTALLDIR}/share/icons/komodo48.png" \
        "Development;IDE;TextEditor" ||
        die "make_desktop_entry failed"
}
