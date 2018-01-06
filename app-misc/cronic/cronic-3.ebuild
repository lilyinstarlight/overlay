# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="a cure for cron's chronic email problem"
HOMEPAGE="http://habilis.net/cronic/"
MY_PV="v${PV}"
MY_P="${PN}-${MY_PV}"
SRC_URI="http://habilis.net/cronic/${MY_P}"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="
	app-shells/bash
"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/${MY_P}" "${WORKDIR}/${PN}" || die
}

src_install() {
	dobin "${PN}"
}
