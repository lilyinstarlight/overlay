# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Browser plugin allowing usage of Windows NPAPI plugins through Wine"
HOMEPAGE="http://pipelight.net/"
COMMIT="8a1bdc6c254f"
SRC_URI="
	https://bitbucket.org/mmueller2012/${PN}/get/v${PV}.tar.gz -> ${P}.tar.gz
	http://repos.fds-team.de/pluginloader/v${PV}/pluginloader.tar.gz -> ${P}-pluginloader.tar.gz
"
S="${WORKDIR}/mmueller2012-pipelight-${COMMIT}"

LICENSE="MPL-1.1 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kde"

CDEPEND="
	x11-libs/libX11
"
RDEPEND="
	${CDEPEND}
	>=app-emulation/wine-1.7.28[pipelight]
	media-fonts/corefonts
	app-crypt/gnupg
	app-arch/cabextract
	!kde? ( gnome-extra/zenity ) kde? ( kde-base/kdialog )
"
DEPEND="
	${CDEPEND}
"

src_unpack() {
	unpack "${P}".tar.gz
	cd "${S}"
	unpack "${P}"-pluginloader.tar.gz
}

src_configure() {
	econf --wine-path="/usr/bin/wine" --moz-plugin-path="/usr/lib/nsbrowser/plugins/" --win32-prebuilt
}

pkg_postinst() {
	pipelight-plugin --create-mozilla-plugins
	pipelight-plugin --update

	einfo "To see available plugins and installation help, run:"
	einfo "  $ pipelight-plugin --help"
	einfo ""
	einfo "By default, plugins are installed on a per-user basis."
	einfo "To install them globally, run pipelight-plugin as root."
}
