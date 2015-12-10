# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit games

DESCRIPTION="animated pipes terminal screensaver"
MY_PN="pipes.sh"
MY_P="${MY_PN}-${PV}"
HOMEPAGE="https://github.com/pipeseroni/pipes.sh"
SRC_URI="https://github.com/pipeseroni/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_install() {
	newgamesbin "${MY_PN}" "${PN}"
	newman "doc/${MY_PN}.6" "${PN}.6"

	dodoc README.rst

	prepgamesdirs
}
