# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Browser plugin allowing usage of Windows NPAPI plugins through Wine."
HOMEPAGE="http://fds-team.de/cms/"
VERSION="4006752d5f96"
SRC_URI="
	https://bitbucket.org/mmueller2012/pipelight/get/v${PV}.tar.gz
	https://launchpad.net/pipelight/trunk/0.2/+download/pluginloader-prebuilt-v${PV}.tar.xz -> pluginloader-prebuilt-v${PV}.tar.gz
"
S="${WORKDIR}/mmueller2012-pipelight-${VERSION}"

LICENSE="MPL-1.1 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="
	x11-libs/libX11
	app-emulation/wine[compholio]
"
DEPEND="
	${RDEPEND}
"

src_prepare() {
	mv ${WORKDIR}/pluginloader.exe ${S}/src/windows
}

src_configure() {
	econf --prefix="/usr" --winepath="/usr/bin/wine" --moz-plugin-path="/usr/lib/nsbrowser/plugins/" --win32-prebuilt
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc LICENSE
}

pkg_postinst() {
	pipelight-plugin --create-mozilla-plugins

	einfo "To install Silverlight, run the following command:"
	einfo "  $ pipelight-plugin --enable silverlight"
	einfo "To install Adobe Flash, run the following command:"
	einfo "  $ pipelight-plugin --enable flash"
	einfo ""
	einfo "To install plugins globally, run pipelight-plugin as root."
}
