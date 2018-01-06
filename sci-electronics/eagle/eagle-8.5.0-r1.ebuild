# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="EAGLE schematic and printed circuit board (PCB) layout editor"
HOMEPAGE="https://www.autodesk.com/products/eagle/overview"
FY="17"
SRC_URI="http://trial2.autodesk.com/NET${FY}SWDLD/20${FY}/EGLPRM/ESD/Autodesk_EAGLE_${PV}_English_Linux_64bit.tar.gz"

LICENSE="Autodesk-EULA"
SLOT="0"
KEYWORDS="~amd64 -*"
IUSE=""

QA_PREBUILT="*"
RESTRICT="mirror bindist"

RDEPEND="
	app-arch/bzip2
	app-crypt/mit-krb5
	dev-libs/expat
	dev-libs/glib
	dev-libs/gmp
	dev-libs/libbsd
	dev-libs/libffi
	dev-libs/libpcre
	dev-libs/libtasn1
	dev-libs/libunistring
	dev-libs/nettle
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libpng:0
	media-libs/mesa
	net-dns/libidn2
	net-libs/gnutls
	net-print/cups
	sys-apps/keyutils
	sys-apps/util-linux
	sys-devel/gcc
	sys-libs/e2fsprogs-libs
	sys-libs/glibc
	sys-libs/libselinux
	sys-libs/zlib
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXrandr
	x11-libs/libXxf86vm
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxshmfence
"

src_install() {
	echo -e "ROOTPATH=/opt/${PN}/bin\nPRELINK_PATH_MASK=/opt/${PN}" > "${S}/90eagle-${PV}"
	doenvd "${S}/90${P}"

	doman doc/eagle.1
	rm doc/eagle.1

	# add .so links to prevent Eagle from mixing bundled libraries with system libraries
	for so in lib/*.so.*; do
		[ -e "${so%%.so*}.so" ] || ln -s "$(basename "${so}")" "${so%%.so*}.so" || die
	done

	mkdir -p "${D}"/opt/"${PN}" || die
	cp -a * "${D}"/opt/"${PN}" || die

	doicon bin/${PN}-logo.png
	make_wrapper ${PN} "${EROOT}opt/${PN}/eagle" "${EROOT}opt/${PN}" "${EROOT}opt/${PN}/lib"
	make_desktop_entry ${PN} "EAGLE PCB Designer" ${PF}-logo "Graphics;Electronics"
}

pkg_postinst() {
	elog "Run \`env-update && source /etc/profile\` from within \${ROOT}"
	elog "now to set up the correct paths."
}
