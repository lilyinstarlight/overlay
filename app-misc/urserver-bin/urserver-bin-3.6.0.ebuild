# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils gnome2-utils unpacker versionator

DESCRIPTION="Unified Remote Server"
HOMEPAGE="https://unifiedremote.com"

BUILD_X86="751"
BUILD_AMD64="745"

MY_PN="${PN/-bin/}"
MY_P="${MY_PN}-${PV}"

SRC_URI="
	x86? ( https://www.unifiedremote.com/static/builds/server/linux-x86/${BUILD_X86}/${MY_P}.${BUILD_X86}.deb -> ${MY_P}.x86.deb )
	amd64? ( https://www.unifiedremote.com/static/builds/server/linux-x64/${BUILD_AMD64}/${MY_P}.${BUILD_AMD64}.deb -> ${MY_P}.amd64.deb )
"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

RDEPEND="
	x11-libs/libX11
	x11-libs/libXext
	net-wireless/bluez
"

S="${WORKDIR}"

RESTRICT="mirror bindist"

QA_PREBUILT="opt/urserver/urserver"

src_unpack() {
	unpack_deb ${A}
}

src_prepare() {
	sed -i \
		-e "s:/opt/urserver/urserver-start:urserver-start:g" \
		-e "s:/opt/urserver/urserver-stop:urserver-stop:g" \
		usr/share/applications/"${MY_PN}".desktop || die

	sed -i \
		-e "s:/opt/urserver/urserver-start:urserver-start:g" \
		opt/urserver/"${MY_PN}"-autostart.desktop || die

	default
}

src_install() {
	insinto /opt
	doins -r opt/"${MY_PN}"

	fperms +x /opt/"${MY_PN}/${MY_PN}"
	fperms +x /opt/"${MY_PN}/${MY_PN}"-start
	fperms +x /opt/"${MY_PN}/${MY_PN}"-stop

	doicon usr/share/icons/"${MY_PN}".png
	domenu usr/share/applications/"${MY_PN}".desktop

	make_wrapper "${MY_PN}" /opt/"${MY_PN}/${MY_PN}"
	make_wrapper "${MY_PN}"-start /opt/"${MY_PN}/${MY_PN}"-start
	make_wrapper "${MY_PN}"-stop /opt/"${MY_PN}/${MY_PN}"-stop
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
