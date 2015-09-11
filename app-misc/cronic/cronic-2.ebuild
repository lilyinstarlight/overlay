# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="A cure for cron's chronic email problem"
HOMEPAGE="http://habilis.net/cronic/"
MY_PV="v${PV}"
MY_P="${PN}-${MY_PV}"
SRC_URI="http://habilis.net/cronic/${PN} -> ${MY_P}"

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
	cp "${DISTDIR}/${MY_P}" "${WORKDIR}/${PN}"
}

src_install() {
	dobin "${PN}"
}
